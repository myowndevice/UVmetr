/**
  ******************************************************************************
  * @file    Project/main.c 
  * @author  MCD Application Team
  * @version V2.2.0
  * @date    30-September-2014
  * @brief   Main program body
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

void Delay (uint32_t nCount);
uint32_t LSIMeasurment(void);

uint32_t current_millis = 0;
bool blueen;
uint8_t td[10];
uint8_t buff[30];

#define BMEaddr 0x76
bool BMEinit(void);
unsigned short bmeT1,bmeP1;
short bmeT2,bmeT3,bmeP2,bmeP3,bmeP4,bmeP5,bmeP6,bmeP7,bmeP8,bmeP9;
unsigned char bmeH1,bmeH3;
short bmeH2;

bool I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte)
{
	uint32_t timeout;
	timeout = current_millis + 100;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY) && current_millis<timeout);
	if (current_millis>timeout) return FALSE;
	
	I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT) && current_millis<timeout);
	if (current_millis>timeout) return FALSE;
	
  I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) && current_millis<timeout);
	if (current_millis>timeout) return FALSE;
	
	while (nbyte>0)
	{
		I2C_SendData((uint8_t)*buff);//ctrl meas
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) && current_millis<timeout);
		if (current_millis>timeout) return FALSE;
		*buff++;
		nbyte--;
	}
}

bool I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte)
{
	uint32_t timeout;
	timeout = current_millis + 100;
	
	
	I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT) && current_millis<timeout);
	if (current_millis>timeout) return FALSE;
	
	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) && current_millis<timeout);
	if (current_millis>timeout) return FALSE;

	while  (nbyte > 3) {
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET && current_millis<timeout);
		if (current_millis>timeout) return FALSE;
		*buff = I2C_ReceiveData();
		*buff++;
		nbyte--;
	}

	if (nbyte == 3) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
		*buff = I2C_ReceiveData();
		*buff++;
		I2C_GenerateSTOP(ENABLE);
		*buff = I2C_ReceiveData();
		*buff++;
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET && current_millis<timeout);
		if (current_millis>timeout) return FALSE;
		*buff = I2C_ReceiveData();	
		nbyte=0;
	}
	if (nbyte == 2) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
    while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET && current_millis<timeout);
		if (current_millis>timeout) return FALSE;
		
		(void)I2C->SR3;
		
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET && current_millis<timeout);
		if (current_millis>timeout) return FALSE;
		
		disableInterrupts();
		
		I2C_GenerateSTOP(ENABLE);
		
		*buff= I2C_ReceiveData();

      /* Point to the next location where the byte read will be saved */
		*buff++;  
		enableInterrupts();
		*buff= I2C_ReceiveData();
		nbyte=0; 
	}
	
	if (nbyte == 1) 
	{
		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET && current_millis<timeout);
    if (current_millis>timeout) return FALSE;
		I2C_AcknowledgeConfig(I2C_ACK_NONE);   

		disableInterrupts();
    
    /* Clear ADDR register by reading SR1 then SR3 register (SR1 has already been read) */
    (void)I2C->SR3;
    
    /* Send STOP Condition */
    I2C_GenerateSTOP( ENABLE);
   
    /* Call User callback for critical section end (should typically re-enable interrupts) */
    enableInterrupts();
    
    /* Wait for the byte to be received */
    while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET && current_millis<timeout);
    if (current_millis>timeout) return FALSE;
		
    /* Read the byte received from the EEPROM */
    *buff = I2C_ReceiveData();
    
    /* Decrement the read bytes counter */
		nbyte=0;

    /* Wait to make sure that STOP control bit has been cleared */
    while(I2C->CR2 & I2C_CR2_STOP && current_millis<timeout);
    if (current_millis>timeout) return FALSE;
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
}


bool BMEinit(void) 
{
	
}


void main(void)
{
	BitStatus kn;
	uint8_t st;
	int i;
 
	//knold = RESET;
	//I2C_Send7bitAddress(0x48,I2C_DIRECTION_RX);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
	
	//Delay(1000000);
	
	//GPIO_Init(GPIOD,GPIO_PIN_2,GPIO_MODE_OUT_OD_HIZ_SLOW);//blue en
	
	//Delay(1000000);
	
	//GPIO_WriteReverse(GPIOD,GPIO_PIN_2);
	
	//blueen = FALSE;
	//GPIO_Init(GPIOD,GPIO_PIN_3,GPIO_MODE_IN_PU_IT);//knopka
	
	
	BEEP_LSICalibrationConfig(LSIMeasurment());
	BEEP_Cmd(DISABLE);
	//Delay(100);
	//BEEP_Init(BEEP_FREQUENCY_1KHZ);
	//BEEP_Cmd(ENABLE);
	
	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 57);
	/* Clear TIM4 update flag */
	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	/* Enable update interrupt */
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);

	/* enable interrupts */
	enableInterrupts();

	/* Enable TIM4 */
	TIM4_Cmd(ENABLE);

	//Delay(10000);

	I2C_DeInit();
	I2C_Cmd( ENABLE);
  I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);

	BMEinit();

	i=2;
	
	//настроили типа
	
	/* Infinite loop */
  while (1)
  {
		Delay(1000);
		//получаем инфу!
		/*
		I2C_GenerateSTART(ENABLE);
		while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
		
		I2C_Send7bitAddress(BMEaddr, I2C_DIRECTION_TX);
		while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
		
		I2C_SendData((uint8_t)0xF7);//ctrl meas
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED));
		
		I2C_GenerateSTART(ENABLE);
		while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
		
		I2C_Send7bitAddress(BMEaddr, I2C_DIRECTION_RX);
		while (!I2C_CheckEvent(I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
		
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET);
		for (i=0;i<7;i++) {
			td[i] = I2C_ReceiveData();
			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET);
		}
		
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
		td[7] = I2C_ReceiveData();
		I2C_GenerateSTOP(ENABLE);
		td[8] = I2C_ReceiveData();
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET);
		td[9] = I2C_ReceiveData();
		
		i=1;
		*/
  }
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
uint32_t LSIMeasurment(void)
{

  uint32_t lsi_freq_hz = 0x0;
  uint32_t fmaster = 0x0;
  uint16_t ICValue1 = 0x0;
  uint16_t ICValue2 = 0x0;

  /* Get master frequency */
  fmaster = CLK_GetClockFreq();

  /* Enable the LSI measurement: LSI clock connected to timer Input Capture 1 */
  AWU->CSR |= AWU_CSR_MSR;

#if defined (STM8S903) || defined (STM8S103) || defined (STM8S003)
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV8, 0);
	
  /* Enable TIM1 */
  TIM1_Cmd(ENABLE);
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue1 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue2 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* Disable IC1 input capture */
  TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  /* Disable timer2 */
  TIM1_Cmd(DISABLE);
  
#else  
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
  TIM3_ICInit(TIM3_CHANNEL_1, TIM3_ICPOLARITY_RISING, TIM3_ICSELECTION_DIRECTTI, TIM3_ICPSC_DIV8, 0);

  /* Enable TIM3 */
  TIM3_Cmd(ENABLE);

	/* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
	/* Get CCR1 value*/
  ICValue1 = TIM3_GetCapture1();
  TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
    /* Get CCR1 value*/
  ICValue2 = TIM3_GetCapture1();
	TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* Disable IC1 input capture */
  TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
  /* Disable timer3 */
  TIM3_Cmd(DISABLE);
#endif

  /* Compute LSI clock frequency */
  lsi_freq_hz = (8 * fmaster) / (ICValue2 - ICValue1);
  
  /* Disable the LSI measurement: LSI clock disconnected from timer Input Capture 1 */
  AWU->CSR &= (uint8_t)(~AWU_CSR_MSR);

 return (lsi_freq_hz);
}

void Delay(uint32_t nCount)
{
    /* Decrement nCount value */
    uint32_t tm = current_millis+nCount;
				
		while (current_millis < tm);
}
