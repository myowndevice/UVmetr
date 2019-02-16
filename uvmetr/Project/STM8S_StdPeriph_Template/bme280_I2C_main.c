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
unsigned short bmeT1,bmeP1;
short bmeT2,bmeT3,bmeP2,bmeP3,bmeP4,bmeP5,bmeP6,bmeP7,bmeP8,bmeP9;
unsigned char bmeH1,bmeH3;
short bmeH2,bmeH4,bmeH5;
char bmeH6;
long bmeT,bmeH,bmeP,t_fine,traw,praw,hraw;

int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
	
  I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	while (nbyte>0)
	{
		I2C_SendData((uint8_t)*buff);//ctrl meas
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
		{	
			if (current_millis>timeout) return 0;
		}	
		*buff++;
		nbyte--;
	}
	
	I2C_GenerateSTOP(ENABLE);
	
	return 1;
}

int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
	
	if (nbyte >= 3) 
	{
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		disableInterrupts();
		(void)I2C->SR3;
		enableInterrupts();
	
		while  (nbyte > 3) {
			
			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
			{	
				if (current_millis>timeout) return 0;
			}	
		
			*buff = I2C_ReceiveData();
			*buff++;
			nbyte--;
		}
	
		//осталось 3 байта!
	
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
		disableInterrupts();
		*buff = I2C_ReceiveData();
		*buff++;
		I2C_GenerateSTOP(ENABLE);
		*buff = I2C_ReceiveData();
		enableInterrupts();
		*buff++;
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		*buff = I2C_ReceiveData();	
		 nbyte=0;

		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	
	}
	
	if (nbyte == 2) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		(void)I2C->SR3;
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
    
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		disableInterrupts();
		I2C_GenerateSTOP(ENABLE);
		*buff= I2C_ReceiveData();
		enableInterrupts();
		/* Point to the next location where the byte read will be saved */
		*buff++;  
		*buff= I2C_ReceiveData();
		nbyte=0; 
		
		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	if (nbyte == 1) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NONE);   
		
		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
			
		disableInterrupts();
    
    /* Clear ADDR register by reading SR1 then SR3 register (SR1 has already been read) */
    (void)I2C->SR3;
    
    /* Send STOP Condition */
    I2C_GenerateSTOP( ENABLE);
   
    /* Call User callback for critical section end (should typically re-enable interrupts) */
    enableInterrupts();
    
    /* Wait for the byte to be received */
    while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Read the byte received from the EEPROM */
    *buff = I2C_ReceiveData();
    
    /* Decrement the read bytes counter */
		nbyte=0;

    /* Wait to make sure that STOP control bit has been cleared */
    while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	return 1;
}


int BMEinit(void) 
{
		
		//reset
		buff[0] = (uint8_t) 0xE0;
		buff[1] = (uint8_t) 0xB6;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 2) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		Delay(3);
		
		buff[0] = (uint8_t) 0xD0;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 1) ) 
		{	
			return 0;
		};
		
		buff[0] = (uint8_t) 0xF3;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 1) ) 
		{
			return 0;		
		}	;
		
		buff[0] = (uint8_t) 0xF3;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 2) ) 
		{
			return 0;	
		};	
		
		
		
		buff[0] = (uint8_t) 0xF4;
		buff[1] = (uint8_t) 0b01101011;
		buff[2] = (uint8_t) 0xF2;
		buff[3] = (uint8_t) 0b00000001;
		buff[4] = (uint8_t) 0xF5;
		buff[5] = (uint8_t) 0b1010100;
	  if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 6) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		buff[0] = (uint8_t) 0x88;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		}
		
		if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 25) ) return 0;		
		
		bmeT1 = (uint16_t) buff[1] << 8  | buff[0];
		bmeT2 = (uint16_t) buff[3] << 8  | buff[2];
		bmeT3 = (uint16_t) buff[5] << 8  | buff[4];
		
		bmeP1 = (uint16_t) buff[7] << 8 | buff[6];
		bmeP2 = (uint16_t) buff[9] << 8 | buff[8];
		bmeP3 = (uint16_t) buff[11] << 8 | buff[10];
		bmeP4 = (uint16_t) buff[13] << 8 | buff[12];
		bmeP5 = (uint16_t) buff[15] << 8 | buff[14];
		bmeP6 = (uint16_t) buff[17] << 8 | buff[16];
		bmeP7 = (uint16_t) buff[19] << 8 | buff[18];
		bmeP8 = (uint16_t) buff[21] << 8 | buff[20];
		bmeP9 = (uint16_t) buff[23] << 8 | buff[22];
		
		bmeH1 = (uint8_t) buff[24];
		
		buff[0] = (uint8_t) 0xE1;
		if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) return 0;
		if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 7) ) return 0;		
		
		bmeH2 = (uint16_t) buff[1] << 8 | buff[0];
		bmeH3 = (uint8_t) buff[2];
		bmeH4 = (uint16_t) buff[3] << 4 | (0b00000111 & buff[4]);
		bmeH5 = (uint16_t) buff[5] << 4 | (buff[4]>>3);
		bmeH6 = (uint8_t) buff[6];
		
		
		return 1;
}

int bmedata(void)
{
	long var1,var2,T,vx1,v1,v2;
	uint32_t p;
	
	//Delay(1000);
	buff[0] = (uint8_t) 0xF7;
	if( ! I2C_writenbyte((uint8_t)BMEaddr, buff, 1) ) return 0;
	
	if (! I2C_readnbyte((uint8_t)BMEaddr, buff, 8) ) return 0;		
	
	praw = (int32_t) buff[0]<<12 | buff[1]<<4 | buff[2]>>4;
	traw = (int32_t) buff[3]<<12 | buff[4]<<4 | buff[5]>>4;
	hraw = (int32_t) buff[6]<<8 | buff[7];


  var1  = (((((long)traw >> 3) - ((long)bmeT1 << 1))) * ((long)bmeT2)) >> 11;
	
	var2 =  (((((traw >> 4) - ((long)bmeT1)) * ((traw >> 4) - ((long)bmeT1))) >> 12) * ((long)bmeT3)) >> 14;

	t_fine = var1+var2;

	bmeT = (t_fine * 5 + 128) >> 8;
	
	vx1  = t_fine - (int32_t)76800;
	vx1  = ((((hraw << 14) - ((int32_t)bmeH4 << 20) - ((int32_t)bmeH5 * vx1)) +	(int32_t)16384) >> 15) *
			(((((((vx1 * (int32_t)bmeH6) >> 10) * (((vx1 * (int32_t)bmeH3) >> 11) +
			(int32_t)32768)) >> 10) + (int32_t)2097152) * ((int32_t)bmeH2) + 8192) >> 14);
	vx1 -= ((((vx1 >> 15) * (vx1 >> 15)) >> 7) * (int32_t)bmeH1) >> 4;
	vx1  = (vx1 < 0) ? 0 : vx1;
	vx1  = (vx1 > 419430400) ? 419430400 : vx1;

	bmeH = (uint32_t)(vx1 >> 12) * 100 /1024;
	
	
	v1 = (((int32_t)t_fine) >> 1) - (int32_t)64000;
	v2 = (((v1 >> 2) * (v1 >> 2)) >> 11 ) * ((int32_t)bmeP6);
	v2 = v2 + ((v1 * ((int32_t)bmeP5)) << 1);
	v2 = (v2 >> 2) + (((int32_t)bmeP4) << 16);
	v1 = (((bmeP3 * (((v1 >> 2) * (v1 >> 2)) >> 13 )) >> 3) + ((((int32_t)bmeP2) * v1) >> 1)) >> 18;
	v1 = (((32768 + v1)) * ((int32_t)bmeP1)) >> 15;
	if (v1 == 0) return 0; // avoid exception caused by division by zero
	p = (((uint32_t)(((int32_t)1048576) - praw) - (v2 >> 12))) * 3125;
	if (p < 0x80000000) {
		p = (p << 1) / ((uint32_t)v1);
	} else {
		p = (p / (uint32_t)v1) << 1;
	}
	v1 = (((int32_t)bmeP9) * ((int32_t)(((p >> 3) * (p >> 3)) >> 13))) >> 12;
	v2 = (((int32_t)(p >> 2)) * ((int32_t)bmeP8)) >> 13;
	p = (uint32_t)((int32_t)p + ((v1 + v2 + bmeP7) >> 4));

	// Convert pressure to Q24.8 format (fractional part always be .000)
	p <<= 8;

	bmeP = (uint32_t)p/256;
	
	return 1;
}

void main(void)
{
	BitStatus kn;
	uint8_t st;
	int fl=0;
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
	
	Delay(1000);
	


	//I2C_DeInit();
	I2C_Cmd( ENABLE);
  I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);
	
	BMEinit();

	
	//настроили типа
	
	/* Infinite loop */
  while (1)
  {
		bmedata();
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
