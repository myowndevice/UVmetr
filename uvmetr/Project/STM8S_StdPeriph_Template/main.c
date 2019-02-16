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

#define ALL_PORTC GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7
#define ALL_PORTA GPIO_PIN_1
#define ALL_PORTD GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6


//LCD
/*
struct lcdports{
	//u8 portc;
	u8 portc_odr;u8 portc_ddr; u8 portc_cr1;
	//u8 porta;
	u8 porta_odr;u8 porta_ddr; u8 porta_cr1;
	//u8 portd;
	u8 portd_odr;u8 portd_ddr; u8 portd_cr1;
};
*/
struct lcdports{
	//u8 portc;
	u8 portc_odr;
	//u8 porta;
	u8 porta_odr;
	//u8 portd;
	u8 portd_odr;
};
struct pinports{
	u8 portc;
	u8 porta;
	u8 portd;
};

u8 com[4]; //текущее представление показываемых сегментов на каждом коме
u8 blockcopylcd=0;

struct pinports lcdpins[12];

//struct lcdports lcdmR[8];//2 member on every com
struct lcdports lcdm[32];//4 member on every com


//time
u8 ind[3]={0,0,0};
u8 tchk[3]={0,0,0};
u8 numind=0;u32 sch=0;

#define KNNUM  1  //колво кнопок
#define KNONE  4  //обычное нажатие
#define KNLONG 5  //долгое
#define KNTWO  6  //двойное

#define KNDTIME 50 //время в мс дребезга контактов
#define KNTIMETWO 300 //время в мс двойного нажатия
#define KNTIMELONG 1000 //время в мс долгого нажатия

u8  kn[KNNUM];//итоговое состояние кнопки 0 - не обработана, и дальше обычное нажатие долгое и двойное
u8  knstatus[KNNUM];//состояние кнопки 0 - не нажата 1 - нажата
u16 kntime[KNNUM];//время нажатия кнопки
u8  kndtime=0;

u16 timenct=0;
u16 timemcp=0;
u16 timeuv=0;
u16 sleeptime=0;
u16 timeshowrezhim=0;

u8 rezhim=2;

u8 sec,min;

void Delay (u16 nCount);
uint32_t LSIMeasurment(void);

uint32_t current_millis = 0;
bool blueen;
uint8_t buff[15];

#define MCPaddr 0b01101000
#define UVaddr  (0x10)
#define NCTaddr  (0x48)
u16 uindex;
u16 uindexMax;


int kn1=0,kn2=0,kn1old=0,kn2old=0,fandes=0;fansot=0;

//сегменты индикатора!
#define ON1 GPIO_WriteLow(GPIOD,GPIO_PIN_6)
#define ON2 GPIO_WriteLow(GPIOA,GPIO_PIN_1)
#define ON3 GPIO_WriteLow(GPIOD,GPIO_PIN_3)
#define OFF1 GPIO_WriteHigh(GPIOD,GPIO_PIN_6)
#define OFF2 GPIO_WriteHigh(GPIOA,GPIO_PIN_1)
#define OFF3 GPIO_WriteHigh(GPIOD,GPIO_PIN_3)

#define AON GPIO_WriteLow(GPIOD,GPIO_PIN_5)
#define BON GPIO_WriteLow(GPIOD,GPIO_PIN_2)
#define CON GPIO_WriteLow(GPIOC,GPIO_PIN_4)
#define DON GPIO_WriteLow(GPIOC,GPIO_PIN_6)
#define EON GPIO_WriteLow(GPIOC,GPIO_PIN_7)
#define FON GPIO_WriteLow(GPIOD,GPIO_PIN_4)
#define GON GPIO_WriteLow(GPIOC,GPIO_PIN_3)
#define TON GPIO_WriteLow(GPIOC,GPIO_PIN_5)



#define ALLOFF GPIO_WriteHigh(GPIOC,GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7);GPIO_WriteHigh(GPIOD,GPIO_PIN_2|GPIO_PIN_4|GPIO_PIN_5);


const double cK[9]={
2.508355*10,
7.860106/100,
-2.503131/10,
8.315270/100,
-1.228034/100,
9.804036/10000,
-4.413030/100000,
1.057734/1000/1000,
-1.052755/10000/10000};

const double cKm[8]={
2.5173462*10,
-1.1662878,
-1.0833638,
-8.9773540/10,
-3.7342377/10,
-8.6632643/100,
-1.0450598/100,
-5.1920577/100/100};

const double cKf[7]={
-1.318058*100,
4.830222*10,
-1.646031,
5.464731/100,
-9.650715/10000,
8.802193/1000000,
-3.110810/100000000};

long mcpT,bmeT;

void shownumber(u16 num) {
	ind[0]=num/100;
	ind[1]=num/10-ind[0]*10;
	ind[2]=num - ind[0]*100 - ind[1]*10;

	if (ind[0]==0) {
		ind[0]=10;
		if (ind[1]==0) ind[1]=10;
	}
}


char* shift_and_mul_utoa16(uint16_t n, char *buffer)
{
    char *ptr;
		uint8_t d4, d3, d2, d1, q, d0;

        d1 = (n>>4)  & 0xF;
        d2 = (n>>8)  & 0xF;
        d3 = (n>>12) & 0xF;

        d0 = 6*(d3 + d2 + d1) + (n & 0xF);
        q = (d0 * 0xCD) >> 11;
        d0 = d0 - 10*q;

        d1 = q + 9*d3 + 5*d2 + d1;
        q = (d1 * 0xCD) >> 11;
        d1 = d1 - 10*q;

        d2 = q + 2*d2;
        q = (d2 * 0x1A) >> 8;
        d2 = d2 - 10*q;

        d3 = q + 4*d3;
        d4 = (d3 * 0x1A) >> 8;
        d3 = d3 - 10*d4;

				ptr = buffer;
    *ptr++ = ( d4 + '0' );
    *ptr++ = ( d3 + '0' );
    *ptr++ = ( d2 + '0' );
    *ptr++ = ( d1 + '0' );
    *ptr++ = ( d0 + '0' );
        *ptr = 0;

        while(buffer[0] == '0') ++buffer;
        return buffer;
}


int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte, int nostop)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
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
		I2C->DR = (uint8_t)*buff;//I2C_SendData((uint8_t)*buff);//ctrl meas
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
		{	
			if (current_millis>timeout) return 0;
		}	
		*buff++;
		nbyte--;
	}
	
	if(nostop==0) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
	}
	
	return 1;
}

int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte,int nocheckbusy)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	if (nocheckbusy==0) 
	{
		while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
		{	
			if (current_millis>timeout) return 0;
		}
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
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
		
			*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
			*buff++;
			nbyte--;
		}
	
		//осталось 3 байта!
	
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);
		disableInterrupts();
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		*buff++;
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		enableInterrupts();
		*buff++;
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();	
		 nbyte=0;

		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	
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
		// Point to the next location where the byte read will be saved
		*buff++;  
		*buff= I2C_ReceiveData();
		nbyte=0; 
		
		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    // Re-Enable Acknowledgement to be ready for another reception
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	
	if (nbyte == 1) 
	{
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);   
		
		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
			
		disableInterrupts();
    
    /* Clear ADDR register by reading SR1 then SR3 register (SR1 has already been read) */
    (void)I2C->SR3;
    
    /* Send STOP Condition */
    I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP( ENABLE);
   
    /* Call User callback for critical section end (should typically re-enable interrupts) */
    enableInterrupts();
    
    /* Wait for the byte to be received */
    while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Read the byte received from the EEPROM */
    *buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
    
    /* Decrement the read bytes counter */
		nbyte=0;

    /* Wait to make sure that STOP control bit has been cleared */
    while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	return 1;
}

int nctinit(void)
{
		
		//not need
		buff[0] = (uint8_t) 0b1;
		buff[1] = (uint8_t) 0b100000;//config reg one shot!
		//buff[1] = (uint8_t) 0b1;//config reg
		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		

		return 1;
}

int nctdata(void)
{
		long tmcpT;
		
		buff[0] = (uint8_t) 0x4;
		buff[1] = (uint8_t) 0;
		//buff[1] = (uint8_t) 0b1;//config reg
		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		Delay(90);
		
		buff[0] = (uint8_t) 0x00;
		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)NCTaddr, buff, 2,0) ) 
		{	
			return 0;
		};
		
		tmcpT = (u32) (buff[0]<<8) | buff[1];
		bmeT = (tmcpT>>4) * 625 / 100;
		
		return 1;
}


int uvinit(void)
{
		//return 1;
		buff[0] = (uint8_t) 0b0;//config reg
		buff[1] = (uint8_t) 0b01000000;//low byte 400ms
		buff[2] = (uint8_t) 0b0;//high byte
		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};

		//I2C->CR2 |= I2C_CR2_STOP;
		
		return 1;
}

u16 readUVword(u8 addr) {
		buff[0] = addr;//(uint8_t) 0x07;//uva
		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 1,1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)UVaddr, buff, 2,1) ) 
		{	
			return 0;
		};

		return (u16) ((buff[1]<<8) | buff[0]);
	
}

u16 uva,uvb,uvcomp1,uvcomp2;//,uvd;

#define UKc	2.64291101055807
#define UKa	1.7315233785822
#define UKd	0.794684842262697
#define UKb	0.622678935827725



int uvdata(void)
{
		float uvia,uvib;
		int i;
		long tmcpT;
		
		uva = readUVword(0x07);
		//uvd = readUVword(0x08);
		uvb = readUVword(0x09);
		uvcomp1 = readUVword(0x0A);
		uvcomp2 = readUVword(0x0B);
		
		//uva-=uvd;
		//uvb-=uvd;
		//uvcomp1-=uvd;
		//uvcomp2-=uvd;
		
		//c	2,64291101055807
		//a	1,7315233785822
		//d	0,794684842262697
		//b	0,622678935827725

		
		
		//uvia = ((uva-UKa*uvcomp1-UKb*uvcomp2)*1/9/100);//for 100ms
		//uvib = ((uvb-UKc*uvcomp1-UKd*uvcomp2)*1/8/100);
		
		uvia = ((uva-UKa*uvcomp1-UKb*uvcomp2)*0.001461);//for 100ms
		uvib = ((uvb-UKc*uvcomp1-UKd*uvcomp2)*0.002591);
		
		//a = ((uva-3.33*uvcomp1-2.5*uvcomp2)*1.0/909.0);
		//b = ((uvb-3.66*uvcomp1-2.75*uvcomp2)*1.0/800.0);
		
		if (uvia<0 || uvib<0) uindex=0;
		else uindex = (uvia+uvib)*100/2/6;//800ms!!
		
		return 1;
}


double mypow(double a,int b) {
		
		//if (b=0) return 0;
		double x=a;
		if (b==1) return a;
		//b--;
		while (b--) 
		{
			x *= a;
		}
		
		return x;
}

int mcpinit(void)
{
		//buff[0] = (uint8_t) 0b00011111;
		buff[0] = (uint8_t) 0b00011100;
		if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 2,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		
		return 1;
}

long u1,u2;
u8 esr_stage=0;
u8 esr_time=0;
long esr_u1=0;
long tmcpT;
		

int mcpdata(void)
{
		double t;
		int i;
		double e;
		
		if (! I2C_readnbyte((uint8_t)MCPaddr, buff, 4,0) ) return 0;		
		
		tmcpT = ((long)buff[0]<<24) + ((long)buff[1]<<16) + ((long)buff[2]<<8);
		tmcpT/=256;
	
		e = (double) tmcpT/64;//512; //* 15.625/8000;//в миливольтах
		
		if (rezhim==6) {
			//milioms
			long r;
			
			if (tmcpT<0) tmcpT=-tmcpT;
			
			r = tmcpT*10/8;//10000/64/125//r=u/i
				
				//r = (u1-u2)/(1.25/9.09-1.25/100)*1000;
				//r = (u1-u2)/(1.12-0.12)*1000;
				//if (r < 0.001) r=0;
			if (r > 999) r=999;
			shownumber(r);
		}

		if (rezhim==5) {
			//izm esr!
				
			if (tmcpT<0) tmcpT=-tmcpT;
				
			if (esr_stage) sleeptime=60;
			
			if ((esr_stage==0)&&(tmcpT< 200)) {
				esr_stage=0;
				ind[0]=4;
				ind[1]=0;
				ind[2]=0;
			}
			else if (esr_stage==0) {
				esr_time = 20;
				esr_stage=1;
				ind[0]=1;
			}
			else if ((esr_stage==1)&&(esr_time)) {
				ind[1]=esr_time/10;
				ind[2]=esr_time-ind[1]*10;
			}
			else if ((esr_stage==1)&&(esr_time==0)) {
				esr_stage=2;
				u1 = tmcpT;
				esr_u1=tmcpT;
				ind[0]=2;
			}	
			else if ((esr_stage==2)&&(tmcpT <200)) {
				esr_stage=3;
				esr_time = 5;
				ind[0]=3;
			}
			else if ((esr_stage==3)&&(tmcpT >200)) {
				esr_stage=4;
				esr_time = 5;
				ind[0]=3;
			}
			//else if (esr_stage==2) {
				//u1 = tmcpT;
				//esr_u1=tmcpT;
			//}
			else if ((esr_stage==4)&&(esr_time==0)) {
				//end!!!
				u2 = tmcpT;
				esr_stage=5;					
				
			}
			else if ((esr_stage==5)&&(tmcpT <200)) {
				esr_stage=0;
			}
			else if ((esr_stage==5)) {
				long r;
				
				r= (u1-u2)*1000*110/64/112/10;
				
				//r = (u1-u2)/(1.25/9.09-1.25/100)*1000;
				//r = (u1-u2)/(1.12-0.12)*1000;
				//if (r < 0.001) r=0;
				if (r > 999) r=999;
				shownumber(r);
			}
		}
			
		if ((rezhim==3) || (rezhim==4)) {
			//current measure
			u8 mant=0;
			u8 big=0;
			
			e /= 1000;
			if (rezhim==3) e /= 2.4;//
			else e = e * 103. / 3.;
			
			if (e<0) e=-e;
			
			if (e>1) {
				big=1;
				tchk[2]=0;
			}	else tchk[2]=1;
			
			if (rezhim==3) tchk[0]=1;
			else  tchk[0]=0;
			
			tchk[1]=1;
				
			//надо получить число из 0.012 получить 1.2
			//а из 120 получить 1.2	
				
			for (mant=0;mant<10;mant++){
				if ((e >= 1) && (e <= 9)) break;				
			
				if (big) {
					e/=10;
				}	else 
					e*=10;
			}
			
			ind[2] = mant;
			ind[0] = (u8)e;
			ind[1] = (u8)(e*10)-ind[0]*10;
			return 1;
		}		
		
		if (e <-5) return 0;	
		if (e >30) return 0; //720gradusov
		
		t=0;

		//e = 20.0;

		if (e>20) 
		{		
			t=t+cKf[0];
			for (i=0;i<6;i++) 
			{
				t=t + (cKf[i+1])*mypow(e,(i+1));
			}
		} else {
			for (i=0;i<((e>0)? 9 : 8);i++) 
			{
				t=t + ((e>0)?cK[i]:cKm[i])*mypow(e,i+1);
			}
		}
		t*=100;
		tmcpT = (long) t + bmeT;
		mcpT = tmcpT;
		//mcpT += bmeT;
		//c = (float)pow(a,b);
		
		return 1;
}

u8 readytosleep=0;

u8 sleep(void) {
	//mcp adc
	//blockcopylcd = 1;
	readytosleep = 1;
	//Delay(10);
	
	//off disp! need pullup PA1 !
	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_IN_PU_NO_IT);	
	//----
	
	//nct datchik sleep
	buff[0] = (uint8_t) 0b1;//config reg
	buff[1] = (uint8_t) 0b1;//shutdown
	if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return 0;
	};
	
	//uv datchik
	buff[0] = (uint8_t) 0b0;//config reg
	buff[1] = (uint8_t) 0b01000001;//low byte
	buff[2] = (uint8_t) 0b0;//high byte - always 0
	if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return 0;
	};


	//mcp adc
	buff[0] = (uint8_t) 0b10001100;//one shot and sleep
	if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 1,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return 0;
	};

	Delay(10);//need for end i2c!
	
	halt();
	
	Delay(100);
	
	kn[0] = 0;	
	
	nctinit();
	mcpinit();
	uvinit();
	
	
	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_OUT_PP_LOW_SLOW);	
	
	
	//on LCD
	readytosleep = 0;
	//vse perevodim v shutdown
	//potom halt
	//potom opyat' vse vkl
	return;
	
		
	
	//uv datchik
	buff[0] = (uint8_t) 0b0;//config reg
	buff[1] = (uint8_t) 0b00100001;//low byte
	buff[2] = (uint8_t) 0b0;//high byte - always 0
	if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return 0;
	};

	//mcp adc
	buff[0] = (uint8_t) 0b10001111;//one shot and sleep
	if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 1,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return 0;
	};
		
		
	//ekran vykl!


	
}



void cifra(u8 num){
	ALLOFF
	
	if (num==0) {
		AON;BON;CON;DON;EON;FON;
	}
	if (num==1) {
		BON;CON;
	}
	if (num==2) {
		AON;BON;GON;EON;DON;
	}
	if (num==3) {
		AON;BON;CON;DON;GON;
	}
	if (num==4) {
		FON;GON;BON;CON;
	}
	if (num==5) {
		AON;FON;GON;CON;DON;
	}
	if (num==6) {
		AON;EON;FON;GON;CON;DON;
	}
	if (num==7) {
		AON;BON;CON;
	}
	if (num==8) {
		AON;BON;CON;GON;DON;EON;FON;
	}
	if (num==9) {
		AON;BON;CON;GON;DON;FON;
	}
	
}

#define PULON 300
#define PULOFF 3000

void addnum(u8 index, u8 pin1,u8 pin2) {
	//cr1 = ddr для наших пинов
	u8 num;
	num = ind[index];
	
	if (tchk[index]) {
		com[3] |= pin2;
	}
	
	switch (num) {
		case 0:
				//p1 - com0 com2     com3
				//p2 - com0 com2 com1 
				
				com[0] |= pin1|pin2;
				com[1] |= pin2;
				com[2] |= pin1|pin2;
				com[3] |= pin1;
				break;
		case 1:
				//p2 - com1 com2
				com[1] |= pin2;
				com[2] |= pin2;
				break;
		case 2:
				//p1 - com1 com2 com3
				//p2 - com0 com1
				com[0] |= pin2;
				com[1] |= pin1|pin2;
				com[2] |= pin1;
				com[3] |= pin1;
				break;
		case 3:
				//p1 -      com1     com3
				//p2 - com0 com1 com2
				com[0] |= pin2;
				com[1] |= pin1|pin2;
				com[2] |= pin2;
				com[3] |= pin1;
				break;
		case 4:
				//p1 - com0 com1
				//p2 -      com1 com2
				com[0] |= pin1;
				com[1] |= pin1|pin2;
				com[2]|= pin2;
				break;
		case 5:
				//p1 - com0 com1     com3
				//p2 - com0      com2
				com[0] |= pin1|pin2;
				com[1] |= pin1;
				com[2] |= pin2;
				com[3] |= pin1;
				break;
		case 6:
				//p1 - com0 com1 com2    com3
				//p2 - com0      com2
				com[0] |= pin1|pin2;
				com[1] |= pin1;
				com[2] |= pin1|pin2;
				com[3] |= pin1;
				break;
		case 7:
				//p2 - com1 com2
				com[0] |= pin2;
				com[1] |= pin2;
				com[2] |= pin2;
				break;
		case 8:
				//p1 - com0 com2     com3
				//p2 - com0 com2 com1 
				
				com[0] |= pin1|pin2;
				com[1] |= pin2|pin1;
				com[2] |= pin1|pin2;
				com[3] |= pin1;
				break;
		case 9:
				//p1 - com0 com2     com3
				//p2 - com0 com2 com1 
				
				com[0] |= pin1|pin2;
				com[1] |= pin2|pin1;
				com[2] |= pin2;
				com[3] |= pin1;
				break;
		
	}
}	

/*
void copylcdmR(void) {
	u8 i;
	if (blockcopylcd) return;
	
	for(i=0;i<8;i++) {
		//lcdmR[i].porta = lcdm[i].porta;
		lcdmR[i].porta_ddr = lcdm[i].porta_ddr;
		lcdmR[i].porta_odr = lcdm[i].porta_odr;
		lcdmR[i].porta_cr1 = lcdm[i].porta_cr1;
		
		//lcdmR[i].portd = lcdm[i].portd;
		lcdmR[i].portd_ddr = lcdm[i].portd_ddr;
		lcdmR[i].portd_odr = lcdm[i].portd_odr;
		lcdmR[i].portd_cr1 = lcdm[i].portd_cr1;
		
		//lcdmR[i].portc = lcdm[i].portc;
		lcdmR[i].portc_ddr = lcdm[i].portc_ddr;
		lcdmR[i].portc_odr = lcdm[i].portc_odr;
		lcdmR[i].portc_cr1 = lcdm[i].portc_cr1;
		
	}
}
*/

void calclcd(void) {
	//com0 - 3 pd6
	//com1 - 2 pd5
	//com2 - 17 pc7
	//com3 - 16 pc6
	
	//5 - 1  pd4  0
	//7 - 15 pc5  1
	//8 - 14 pc4  2
	//9 - 13 pc3  3
	//10 - 5 pa1  4
	//11 - 20 pd3 5
	//12 - 19 pd2 6
	u8 i,j;
	
	if (timeshowrezhim) {
		//0- temp  1-termopara 2 - uv 3-tok 4 - volt 5 - bat
		if (rezhim==0) {
			ind[0]=1;
			ind[1]=0;
			ind[2]=1;
		}
		if (rezhim==1) {
			ind[0]=1;
			ind[1]=0;
			ind[2]=2;
		}
		if (rezhim==2) {
			ind[0]=2;
			ind[1]=0;
			ind[2]=0;
		}
		if (rezhim==3) {
			ind[0]=3;
			ind[1]=0;
			ind[2]=1;
		}
		if (rezhim==4) {
			ind[0]=3;
			ind[1]=0;
			ind[2]=2;
		}
		if (rezhim==5) {
			ind[0]=4;
			ind[1]=0;
			ind[2]=1;
		}
		if (rezhim==6) {
			ind[0]=4;
			ind[1]=0;
			ind[2]=2;
		}
	}
	
	
	//сначала заполним переменные com каждый бит отвечает за включенный сегмент в данном общем выводе
	for (i=0;i<4;i++) com[i]=0;
	
	//каждая цифра это все комы и 2 вывода, соотв номер цифры определяет какие 2 пина, а дальше все одинаково
	//7-8
	addnum(0, GPIO_PIN_1,GPIO_PIN_2);
	//9-10
	addnum(1, GPIO_PIN_3,GPIO_PIN_4);
	//11-12
	addnum(2, GPIO_PIN_5,GPIO_PIN_6);
	
	
	for (i=0;i<16;i++) {
		lcdm[16+i].porta_odr = GPIOA->ODR & (~(ALL_PORTA));
		lcdm[16+i].portd_odr = GPIOD->ODR & (~(ALL_PORTD));
		lcdm[16+i].portc_odr = GPIOC->ODR & (~(ALL_PORTC));
	}
	
	for (i=0;i<4;i++) {
		//1100 1010 1010 1010
		lcdm[16+i*4].porta_odr |= lcdpins[i].porta;
		lcdm[16+i*4].portd_odr |= lcdpins[i].portd;
		lcdm[16+i*4].portc_odr |= lcdpins[i].portc;
		
		lcdm[16+i*4+1].porta_odr |= lcdpins[i].porta;
		lcdm[16+i*4+1].portd_odr |= lcdpins[i].portd;
		lcdm[16+i*4+1].portc_odr |= lcdpins[i].portc;
		
		for (j=0;j<4;j++) {
			if (i==j) continue;
			
			lcdm[16+i*4].porta_odr |= lcdpins[j].porta;
			lcdm[16+i*4].portd_odr |= lcdpins[j].portd;
			lcdm[16+i*4].portc_odr |= lcdpins[j].portc;
			
			lcdm[16+i*4+2].porta_odr |= lcdpins[j].porta;
			lcdm[16+i*4+2].portd_odr |= lcdpins[j].portd;
			lcdm[16+i*4+2].portc_odr |= lcdpins[j].portc;
		}
		
		for (j=4;j<11;j++) {
			//1100  //all seg off
			lcdm[16+i*4].porta_odr |= lcdpins[j].porta;
			lcdm[16+i*4].portd_odr |= lcdpins[j].portd;
			lcdm[16+i*4].portc_odr |= lcdpins[j].portc;
			
			lcdm[16+i*4+1].porta_odr |= lcdpins[j].porta;
			lcdm[16+i*4+1].portd_odr |= lcdpins[j].portd;
			lcdm[16+i*4+1].portc_odr |= lcdpins[j].portc;
		}
	}
	
	for (i=0;i<4;i++) {
		if (com[i]) {		
			u8 j,pin;
			pin = 1;
			
			for (j=0;j<7;j++) {
				if (com[i] & pin) {
					lcdm[16+i*4+0].porta_odr &= ~lcdpins[j+4].porta;
					lcdm[16+i*4+1].porta_odr &= ~lcdpins[j+4].porta;
					lcdm[16+i*4+2].porta_odr |= lcdpins[j+4].porta;
					lcdm[16+i*4+3].porta_odr |= lcdpins[j+4].porta;
					
					lcdm[16+i*4+0].portd_odr &= ~lcdpins[j+4].portd;
					lcdm[16+i*4+1].portd_odr &= ~lcdpins[j+4].portd;
					lcdm[16+i*4+2].portd_odr |= lcdpins[j+4].portd;
					lcdm[16+i*4+3].portd_odr |= lcdpins[j+4].portd;
					
					lcdm[16+i*4+0].portc_odr &= ~lcdpins[j+4].portc;
					lcdm[16+i*4+1].portc_odr &= ~lcdpins[j+4].portc;
					lcdm[16+i*4+2].portc_odr |= lcdpins[j+4].portc;
					lcdm[16+i*4+3].portc_odr |= lcdpins[j+4].portc;
				}
				pin = pin << 1;
			}			
		}	
	}
	
	blockcopylcd=1;
	for (i=0;i<16;i++) {
		lcdm[i].porta_odr = lcdm[16+i].porta_odr;
		lcdm[i].portd_odr = lcdm[16+i].portd_odr;
		lcdm[i].portc_odr = lcdm[16+i].portc_odr;					
	}
	
	blockcopylcd=0;
}

/*
void calclcd_old(void) {
	//com0 - 3 pd6
	//com1 - 2 pd5
	//com2 - 17 pc7
	//com3 - 16 pc6
	
	//5 - 1  pd4  0
	//7 - 15 pc5  1
	//8 - 14 pc4  2
	//9 - 13 pc3  3
	//10 - 5 pa1  4
	//11 - 20 pd3 5
	//12 - 19 pd2 6
	u8 i;
	
	blockcopylcd=1;
	
	//сначала заполним переменные com каждый бит отвечает за включенный сегмент в данном общем выводе
	for (i=0;i<4;i++) com[i]=0;
	
	//каждая цифра это все комы и 2 вывода, соотв номер цифры определяет какие 2 пина, а дальше все одинаково
	//7-8
	addnum(0, GPIO_PIN_1,GPIO_PIN_2);
	//9-10
	addnum(1, GPIO_PIN_3,GPIO_PIN_4);
	//11-12
	addnum(2, GPIO_PIN_5,GPIO_PIN_6);
	
	
	for (i=0;i<4;i++) {
		//all input
		lcdm[i*2].porta_ddr = GPIOA->DDR & (~(ALL_PORTA));
		lcdm[i*2].porta_odr = GPIOA->ODR & (~(ALL_PORTA));
		lcdm[i*2+1].porta_odr = GPIOA->ODR & (~(ALL_PORTA));

		lcdm[i*2].portd_ddr = GPIOD->DDR & (~(ALL_PORTD));
		lcdm[i*2].portd_odr = GPIOD->ODR & (~(ALL_PORTD));
		lcdm[i*2+1].portd_odr = GPIOD->ODR & (~(ALL_PORTD));

		lcdm[i*2].portc_ddr = GPIOC->DDR & (~(ALL_PORTC));
		lcdm[i*2].portc_odr = GPIOC->ODR & (~(ALL_PORTC));
		lcdm[i*2+1].portc_odr = GPIOC->ODR & (~(ALL_PORTC));

		if (com[i]) {		
			u8 j,pin;
			pin = 1;
			
			lcdm[i*2].porta_ddr |= lcdpins[i].porta;
			lcdm[i*2].porta_odr |= lcdpins[i].porta;

			lcdm[i*2].portd_ddr |= lcdpins[i].portd;
			lcdm[i*2].portd_odr |= lcdpins[i].portd;

			lcdm[i*2].portc_ddr |= lcdpins[i].portc;
			lcdm[i*2].portc_odr |= lcdpins[i].portc;

			for (j=0;j<7;j++) {
				if (com[i] & pin) {
					lcdm[i*2].porta_ddr   |= lcdpins[j+4].porta;
					lcdm[i*2+1].porta_odr |= lcdpins[j+4].porta;	
					
					lcdm[i*2].portd_ddr   |= lcdpins[j+4].portd;
					lcdm[i*2+1].portd_odr |= lcdpins[j+4].portd;	
					
					lcdm[i*2].portc_ddr   |= lcdpins[j+4].portc;
					lcdm[i*2+1].portc_odr |= lcdpins[j+4].portc;	
				}
				pin = pin << 1;
			}			
		}	
	}
	
	for (i=0;i<4;i++) {
		//all input
		//cr1 = ddr
		lcdm[i*2].porta_cr1 = GPIOA->CR1 & (~(ALL_PORTA)) | (lcdm[i*2].porta_ddr & (ALL_PORTA));
		
		lcdm[i*2+1].porta_ddr = lcdm[i*2].porta_ddr;
		lcdm[i*2+1].porta_cr1 = lcdm[i*2].porta_cr1;		
		
		//
		lcdm[i*2].portd_cr1 = GPIOD->CR1 & (~(ALL_PORTD)) | (lcdm[i*2].portd_ddr & (ALL_PORTD));
		
		lcdm[i*2+1].portd_ddr = lcdm[i*2].portd_ddr;
		lcdm[i*2+1].portd_cr1 = lcdm[i*2].portd_cr1;		
		
		//
		lcdm[i*2].portc_cr1 = GPIOC->CR1 & (~(ALL_PORTC)) | (lcdm[i*2].portc_ddr & (ALL_PORTC));
		
		lcdm[i*2+1].portc_ddr = lcdm[i*2].portc_ddr;
		lcdm[i*2+1].portc_cr1 = lcdm[i*2].portc_cr1;		
	}
	
	
	blockcopylcd=0;
}
*/

/*
void fullontest(void) {
	u16 i;
	u16 j;
	
	for (i=0;i<10000;i++) {
		GPIO_WriteHigh(GPIOD,GPIO_PIN_5|GPIO_PIN_6);
		GPIO_WriteHigh(GPIOC,GPIO_PIN_6|GPIO_PIN_7);
		
		GPIO_WriteLow(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4);
		GPIO_WriteLow(GPIOC,GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5);
		GPIO_WriteLow(GPIOA,GPIO_PIN_1);
		
		for(j=0;j<100;j++) {
		}
		
		GPIO_WriteLow(GPIOD,GPIO_PIN_5|GPIO_PIN_6);
		GPIO_WriteLow(GPIOC,GPIO_PIN_6|GPIO_PIN_7);
		
		GPIO_WriteHigh(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4);
		GPIO_WriteHigh(GPIOC,GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5);
		GPIO_WriteHigh(GPIOA,GPIO_PIN_1);
		
		for(j=0;j<100;j++) {
		}
		
	}

	GPIO_Init(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOA,GPIO_PIN_1,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7,GPIO_MODE_OUT_PP_LOW_SLOW);
	
	return;
	
}
*/

void main(void)
{
	u16 i,j;
	
	//buff[0]=0;
	//buff[1]=55;
	//buff[2]=78;
	
	//tmcpT = ((long)buff[0]<<24) + ((long)buff[1]<<16) + ((long)buff[2]<<8);
	
	//питание - оставляем только нужную периферию!
	CLK->PCKENR1 = CLK_PCKENR1_TIM2+CLK_PCKENR1_I2C;	CLK->PCKENR2 = 0b11110011;
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);//2mgh энергосбережение
	//internal clock
	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_OUT_PP_LOW_SLOW);	

	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOA,EXTI_SENSITIVITY_FALL_ONLY);
	GPIO_Init(GPIOA,GPIO_PIN_2,GPIO_MODE_IN_PU_IT);//кнопка!

  I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);

	//com0 - 3 pd6
	//com1 - 2 pd5
	//com2 - 17 pc7
	//com3 - 16 pc6
	
	//5 - 1  pd4  5
	//7 - 15 pc5  6
	//8 - 14 pc4  7
	//9 - 13 pc3  8
	//10 - 5 pa1  9
	//11 - 20 pd3 10
	//12 - 19 pd2 11
	for (i=0;i<12;i++) {
		lcdpins[i].porta = 0;
		lcdpins[i].portd = 0;
		lcdpins[i].portc = 0;
	}
	
	lcdpins[0].portd = GPIO_PIN_6;
	lcdpins[1].portd = GPIO_PIN_5;
	lcdpins[2].portc = GPIO_PIN_7;
	lcdpins[3].portc = GPIO_PIN_6;
	
	lcdpins[4].portd = GPIO_PIN_4;
	lcdpins[5].portc = GPIO_PIN_5;
	lcdpins[6].portc = GPIO_PIN_4;
	lcdpins[7].portc = GPIO_PIN_3;
	lcdpins[8].porta = GPIO_PIN_1;
	lcdpins[9].portd = GPIO_PIN_3;
	lcdpins[10].portd = GPIO_PIN_2;	
	

	ind[0] = 0;
	ind[1] = 0;
	ind[2] = 0;
	
	calclcd();
	//copylcdmR();
	
	
	TIM2_TimeBaseInit(TIM2_PRESCALER_8, 124);//2000Hz  124  249
  TIM2_ClearFlag(TIM2_FLAG_UPDATE);
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
  TIM2->IER |= (uint8_t)TIM2_IT_UPDATE;
  
	TIM2_Cmd(ENABLE);
	
	/* Enable TIM4 */
	/*
	TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);//1000Hz
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4->IER |= (uint8_t)TIM4_IT_UPDATE;
	TIM4_Cmd(ENABLE);
	*/
	
	//настройку прерваний надо делать до их включения!
	//надо оба фронта для отслеживания долгого нажатия!
	/* enable interrupts */

	//ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF,ITC_PRIORITYLEVEL_3);
	//ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_1);

	enableInterrupts();

	//while(1);
	

	Delay(100);

	bmeT=0;
	
	//I2C_DeInit();
	I2C_Cmd( ENABLE);
	
	//sleep();
	
	mcpinit();
	uvinit();
	nctinit();
	
	//sleep();

	//Delay(2000);
	
	//halt();

	
	kn[0] = KNONE;
	/* Infinite loop */
  while (1) {
		
		if (kn[0] == KNONE) {
			sleeptime = 60;
			kn[0]=0;
			rezhim++;
			if (rezhim>6) rezhim = 0;
			
			tchk[0]=0;
			tchk[1]=0;
			tchk[2]=0;
				
			if (rezhim==0) {
				tchk[1]=1;
				timenct=0;
			}	
		
			if (rezhim==1) {
				tchk[2]=1;
				timemcp =0;
				timenct =0;
			}	
			
			if (rezhim==2) {
				tchk[0]=1;
				ind[0]=10;
				ind[1]=10;
				ind[2]=10;				
			}	
			if (rezhim==3) {
				tchk[2]=1;
				ind[0]=10;
				ind[1]=10;
				ind[2]=10;
			}	
			
			if (rezhim==5) esr_stage=0;
			
			timeshowrezhim = 2000; //show rezhim!
		}
		else if (kn[0]>KNONE) kn[0]=0;
			
		
		
		if (timenct==0) {
			nctdata();
			timenct = 500;
			if (rezhim==0) {
				shownumber(bmeT/10);
				calclcd();
			}	
		}	
		
		if (rezhim == 2) {
			if (timeuv==0) {
				timeuv=410;
				uvdata();
				
				//shownumber(uindexMax);
				
				//1300
				
				//tchk[1]=1;
				//if (uindex > uindexMax) 
				
				uindexMax = uindex;

				tchk[0]=0;
				tchk[1]=1;
				tchk[2]=0;
				shownumber(uindexMax/10);


				/*
				if (uindexMax> 999) {
					//13.1
					tchk[0]=0;
					tchk[1]=1;
					tchk[2]=0;
					shownumber(uindexMax/10);
				} else if (uindexMax > 99) {
					//5.00
					tchk[0]=1;
					tchk[1]=0;
					tchk[2]=0;
					shownumber(uindexMax/10);
					//calclcd();
				} else {
					//0.22
					tchk[0]=1;
					tchk[1]=0;
					tchk[2]=0;
					shownumber(uindexMax);
					//calclcd();
				}							
				*/
				
				calclcd();
				
			}				
		}	
		
		
		if ((rezhim == 1) && (timemcp==0) )  {
			if (mcpdata()==0){
				//error!!
				mcpT = 0;
			}
			if (mcpT>9999) {
				shownumber(mcpT/100);
				tchk[0]=0;
				tchk[1]=0;
				tchk[2]=1;
				//calclcd();				
			}
			else 
			{
				tchk[0]=0;
				tchk[1]=1;
				tchk[2]=0;
				shownumber(mcpT/10);
				//calclcd();
			}	
			calclcd();
			timemcp=500;
		}		
		
		if ((rezhim >= 3) && (timemcp==0) )  {
			if (mcpdata()==0){
				//error!!
				mcpT = 0;
			}
			
			calclcd();
			timemcp=500;
		}		
		
		if (sleeptime==0) {
			sleep();
			sleeptime=60;
			
		}
		
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
	//TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV8, 0);
	
	//TI1_Config((uint8_t)TIM1_ICPOLARITY_RISING,
  //             (uint8_t)TIM1_ICSELECTION_DIRECTTI,
  //             (uint8_t)0);
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  
  /* Select the Input and set the filter */
  TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
                          (uint8_t)(( (TIM1_ICSELECTION_DIRECTTI)) | ((uint8_t)( 0 << 4))));
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
	TIM1->CCER1 |=  TIM1_CCER1_CC1E;
	
   /* Set the Input Capture Prescaler value */
	//TIM1_SetIC1Prescaler(TIM1_ICPSC_DIV8);
	TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
                          | (uint8_t)TIM1_ICPSC_DIV8);
	
  /* Enable TIM1 */
  //TIM1_Cmd(ENABLE);
	TIM1->CR1 |= TIM1_CR1_CEN;
  
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

u16 timedelay=0;

void Delay(u16 nCount)
{
    /* Decrement nCount value */
    timedelay = nCount;
				
		while (timedelay);
}

void knint(u8 knum, u8 zn,u8 pin) {
	//будет отслеживать только изменение состояния кнопки
	if (knstatus[knum] && ((zn&pin) == 0)) {//кнопку нажали
		knstatus[knum] = zn&pin;
		if (kn[knum]>=KNONE) return; //еще не обработали предыдущее нажатие в основном цикле пропустим это нажатие

		kn[knum]++;//колво нажатий плюс один
		if (kn[knum]==1) kntime[knum] = KNTIMELONG;//первый раз начнм замер времени
		
		if (kn[knum]==2) {
			if (kntime[knum] > (KNTIMELONG-KNTIMETWO) ) kn[knum] = KNTWO;
			else kn[knum] = KNONE;
		}
	}
	
	if ((kn[knum]==1) && (kntime[knum]==0)) kn[knum]=KNLONG;
	if ((kn[knum]==1) && (kntime[knum]<(KNTIMELONG-KNTIMETWO)) && zn&pin) kn[knum]=KNONE;
	
	knstatus[knum] = zn&pin;
	
}	 

u16 timeuvmax=0;
u16 timesec=0;


INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	current_millis++;
	
	if (timedelay) timedelay--;

	if (timenct) timenct--;
	if (timemcp) timemcp--;
	if (timeuv) timeuv--;
	if (timesec) timesec--;
	
	if (timesec==0) {
		timesec=1000;
		
		if(sleeptime) sleeptime--;
	}
	
	if (timeuvmax) timeuvmax--;
	else {
			timeuvmax=10000;
			uindexMax =0;
	}
	

	{  //-------обработка кнопок
		u8 i,pd;
		
		if(kndtime) kndtime--;
		if (kndtime==0) {
			//опрос кнопок редко для избежания дребезга
			kndtime = KNDTIME;
			
			pd = GPIO_ReadInputData(GPIOA);
			knint(0, pd, GPIO_PIN_2);
		}
		for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
	}

	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
	
 }
 
 u8 lcdframe=0;
 u8 time2=0;
 
 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	struct lcdports com,othercom,otherpin;
	struct lcdports real1,real2;
	u16 i;
	u8 ind;

	lcdframe++;
	if (lcdframe==75) lcdframe = 0;
	ind = lcdframe;	

	//опасен случай когда вывод был в аутпут и переключается в инпут
	//в этом случае в cr  будет 1 - и он включится как пулап
	//соотв. поэтому сначала надо умножить на cr чтобы обнулить то что можно
	//а в конце можно приравнять его!
	
	//blockcopylcd=1;
	
	if (readytosleep==0) {
		if ((ind < 16) && (blockcopylcd==0)) {
	
			GPIOA->ODR = lcdm[ind].porta_odr;
			GPIOD->ODR = lcdm[ind].portd_odr;
			GPIOC->ODR = lcdm[ind].portc_odr;
		}
		else {
				GPIOA->ODR &= ~(ALL_PORTA);
				GPIOD->ODR &= ~(ALL_PORTD);
				GPIOC->ODR &= ~(ALL_PORTC);
		}
	}
	
	if (timeshowrezhim) timeshowrezhim--;
	
	if (time2) time2--;
	if (time2==0) {
		time2=2;
	
		if (timedelay) timedelay--;
	
		if (timenct) timenct--;
		if (timemcp) timemcp--;
		if (timeuv) timeuv--;
	
	
		if (timesec) timesec--;
		
		if (timesec==0) {
			timesec=1000;
			
			if (esr_time) esr_time--;
			
			if(sleeptime) sleeptime--;
		}
		
	
		if (timeuvmax) timeuvmax--;
		else {
				timeuvmax=10000;
				uindexMax =0;
		}
	
		{  //-------обработка кнопок
			u8 i,pd;
			
			if(kndtime) kndtime--;
			if (kndtime==0) {
				//опрос кнопок редко для избежания дребезга
				kndtime = KNDTIME;
				
				pd = GPIO_ReadInputData(GPIOA);
				knint(0, pd, GPIO_PIN_2);
			}
			for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
		}
	}



	//sch++;
	//TIM2->SR1 = (uint8_t)(~TIM2_IT_UPDATE);//
	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 }
