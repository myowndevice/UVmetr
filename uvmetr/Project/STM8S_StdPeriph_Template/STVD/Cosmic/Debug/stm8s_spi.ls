   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.5 - 29 Dec 2015
   3                     ; Generator (Limited) V4.4.4 - 27 Jan 2016
   4                     ; Optimizer V4.4.4 - 27 Jan 2016
  49                     ; 50 void SPI_DeInit(void)
  49                     ; 51 {
  51                     .text:	section	.text,new
  52  0000               _SPI_DeInit:
  56                     ; 52   SPI->CR1    = SPI_CR1_RESET_VALUE;
  58  0000 725f5200      	clr	20992
  59                     ; 53   SPI->CR2    = SPI_CR2_RESET_VALUE;
  61  0004 725f5201      	clr	20993
  62                     ; 54   SPI->ICR    = SPI_ICR_RESET_VALUE;
  64  0008 725f5202      	clr	20994
  65                     ; 55   SPI->SR     = SPI_SR_RESET_VALUE;
  67  000c 35025203      	mov	20995,#2
  68                     ; 56   SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  70  0010 35075205      	mov	20997,#7
  71                     ; 57 }
  74  0014 81            	ret	
 390                     ; 78 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 390                     ; 79 {
 391                     .text:	section	.text,new
 392  0000               _SPI_Init:
 394  0000 89            	pushw	x
 395  0001 88            	push	a
 396       00000001      OFST:	set	1
 399                     ; 91   SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 399                     ; 92                        (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 401  0002 7b07          	ld	a,(OFST+6,sp)
 402  0004 1a08          	or	a,(OFST+7,sp)
 403  0006 6b01          	ld	(OFST+0,sp),a
 405  0008 9f            	ld	a,xl
 406  0009 1a02          	or	a,(OFST+1,sp)
 407  000b 1a01          	or	a,(OFST+0,sp)
 408  000d c75200        	ld	20992,a
 409                     ; 95   SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 411  0010 7b09          	ld	a,(OFST+8,sp)
 412  0012 1a0a          	or	a,(OFST+9,sp)
 413  0014 c75201        	ld	20993,a
 414                     ; 97   if (Mode == SPI_MODE_MASTER)
 416  0017 7b06          	ld	a,(OFST+5,sp)
 417  0019 a104          	cp	a,#4
 418  001b 2606          	jrne	L302
 419                     ; 99     SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 421  001d 72105201      	bset	20993,#0
 423  0021 2004          	jra	L502
 424  0023               L302:
 425                     ; 103     SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 427  0023 72115201      	bres	20993,#0
 428  0027               L502:
 429                     ; 107   SPI->CR1 |= (uint8_t)(Mode);
 431  0027 c65200        	ld	a,20992
 432  002a 1a06          	or	a,(OFST+5,sp)
 433  002c c75200        	ld	20992,a
 434                     ; 110   SPI->CRCPR = (uint8_t)CRCPolynomial;
 436  002f 7b0b          	ld	a,(OFST+10,sp)
 437  0031 c75205        	ld	20997,a
 438                     ; 111 }
 441  0034 5b03          	addw	sp,#3
 442  0036 81            	ret	
 497                     ; 119 void SPI_Cmd(FunctionalState NewState)
 497                     ; 120 {
 498                     .text:	section	.text,new
 499  0000               _SPI_Cmd:
 503                     ; 124   if (NewState != DISABLE)
 505  0000 4d            	tnz	a
 506  0001 2705          	jreq	L532
 507                     ; 126     SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 509  0003 721c5200      	bset	20992,#6
 512  0007 81            	ret	
 513  0008               L532:
 514                     ; 130     SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 516  0008 721d5200      	bres	20992,#6
 517                     ; 132 }
 520  000c 81            	ret	
 629                     ; 141 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 629                     ; 142 {
 630                     .text:	section	.text,new
 631  0000               _SPI_ITConfig:
 633  0000 89            	pushw	x
 634  0001 88            	push	a
 635       00000001      OFST:	set	1
 638                     ; 143   uint8_t itpos = 0;
 640                     ; 145   assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 642                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 644                     ; 149   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 646  0002 9e            	ld	a,xh
 647  0003 a40f          	and	a,#15
 648  0005 5f            	clrw	x
 649  0006 97            	ld	xl,a
 650  0007 a601          	ld	a,#1
 651  0009 5d            	tnzw	x
 652  000a 2704          	jreq	L41
 653  000c               L61:
 654  000c 48            	sll	a
 655  000d 5a            	decw	x
 656  000e 26fc          	jrne	L61
 657  0010               L41:
 658  0010 6b01          	ld	(OFST+0,sp),a
 660                     ; 151   if (NewState != DISABLE)
 662  0012 0d03          	tnz	(OFST+2,sp)
 663  0014 2707          	jreq	L113
 664                     ; 153     SPI->ICR |= itpos; /* Enable interrupt*/
 666  0016 c65202        	ld	a,20994
 667  0019 1a01          	or	a,(OFST+0,sp)
 669  001b 2004          	jra	L313
 670  001d               L113:
 671                     ; 157     SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 673  001d 43            	cpl	a
 674  001e c45202        	and	a,20994
 675  0021               L313:
 676  0021 c75202        	ld	20994,a
 677                     ; 159 }
 680  0024 5b03          	addw	sp,#3
 681  0026 81            	ret	
 715                     ; 166 void SPI_SendData(uint8_t Data)
 715                     ; 167 {
 716                     .text:	section	.text,new
 717  0000               _SPI_SendData:
 721                     ; 168   SPI->DR = Data; /* Write in the DR register the data to be sent*/
 723  0000 c75204        	ld	20996,a
 724                     ; 169 }
 727  0003 81            	ret	
 750                     ; 176 uint8_t SPI_ReceiveData(void)
 750                     ; 177 {
 751                     .text:	section	.text,new
 752  0000               _SPI_ReceiveData:
 756                     ; 178   return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 758  0000 c65204        	ld	a,20996
 761  0003 81            	ret	
 797                     ; 187 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 797                     ; 188 {
 798                     .text:	section	.text,new
 799  0000               _SPI_NSSInternalSoftwareCmd:
 803                     ; 190   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 805                     ; 192   if (NewState != DISABLE)
 807  0000 4d            	tnz	a
 808  0001 2705          	jreq	L163
 809                     ; 194     SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 811  0003 72105201      	bset	20993,#0
 814  0007 81            	ret	
 815  0008               L163:
 816                     ; 198     SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 818  0008 72115201      	bres	20993,#0
 819                     ; 200 }
 822  000c 81            	ret	
 845                     ; 207 void SPI_TransmitCRC(void)
 845                     ; 208 {
 846                     .text:	section	.text,new
 847  0000               _SPI_TransmitCRC:
 851                     ; 209   SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 853  0000 72185201      	bset	20993,#4
 854                     ; 210 }
 857  0004 81            	ret	
 893                     ; 218 void SPI_CalculateCRCCmd(FunctionalState NewState)
 893                     ; 219 {
 894                     .text:	section	.text,new
 895  0000               _SPI_CalculateCRCCmd:
 899                     ; 221   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 901                     ; 223   if (NewState != DISABLE)
 903  0000 4d            	tnz	a
 904  0001 2705          	jreq	L314
 905                     ; 225     SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 907  0003 721a5201      	bset	20993,#5
 910  0007 81            	ret	
 911  0008               L314:
 912                     ; 229     SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 914  0008 721b5201      	bres	20993,#5
 915                     ; 231 }
 918  000c 81            	ret	
 982                     ; 238 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 982                     ; 239 {
 983                     .text:	section	.text,new
 984  0000               _SPI_GetCRC:
 986  0000 88            	push	a
 987       00000001      OFST:	set	1
 990                     ; 240   uint8_t crcreg = 0;
 992                     ; 243   assert_param(IS_SPI_CRC_OK(SPI_CRC));
 994                     ; 245   if (SPI_CRC != SPI_CRC_RX)
 996  0001 4d            	tnz	a
 997  0002 2705          	jreq	L154
 998                     ; 247     crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1000  0004 c65207        	ld	a,20999
1003  0007 2003          	jra	L354
1004  0009               L154:
1005                     ; 251     crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1007  0009 c65206        	ld	a,20998
1009  000c               L354:
1010                     ; 255   return crcreg;
1014  000c 5b01          	addw	sp,#1
1015  000e 81            	ret	
1040                     ; 263 void SPI_ResetCRC(void)
1040                     ; 264 {
1041                     .text:	section	.text,new
1042  0000               _SPI_ResetCRC:
1046                     ; 267   SPI_CalculateCRCCmd(ENABLE);
1048  0000 a601          	ld	a,#1
1049  0002 cd0000        	call	_SPI_CalculateCRCCmd
1051                     ; 270   SPI_Cmd(ENABLE);
1053  0005 a601          	ld	a,#1
1055                     ; 271 }
1058  0007 cc0000        	jp	_SPI_Cmd
1082                     ; 278 uint8_t SPI_GetCRCPolynomial(void)
1082                     ; 279 {
1083                     .text:	section	.text,new
1084  0000               _SPI_GetCRCPolynomial:
1088                     ; 280   return SPI->CRCPR; /* Return the CRC polynomial register */
1090  0000 c65205        	ld	a,20997
1093  0003 81            	ret	
1149                     ; 288 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1149                     ; 289 {
1150                     .text:	section	.text,new
1151  0000               _SPI_BiDirectionalLineConfig:
1155                     ; 291   assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1157                     ; 293   if (SPI_Direction != SPI_DIRECTION_RX)
1159  0000 4d            	tnz	a
1160  0001 2705          	jreq	L325
1161                     ; 295     SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1163  0003 721c5201      	bset	20993,#6
1166  0007 81            	ret	
1167  0008               L325:
1168                     ; 299     SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1170  0008 721d5201      	bres	20993,#6
1171                     ; 301 }
1174  000c 81            	ret	
1295                     ; 311 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1295                     ; 312 {
1296                     .text:	section	.text,new
1297  0000               _SPI_GetFlagStatus:
1299  0000 88            	push	a
1300       00000001      OFST:	set	1
1303                     ; 313   FlagStatus status = RESET;
1305                     ; 318   if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1307  0001 c45203        	and	a,20995
1308  0004 2702          	jreq	L306
1309                     ; 320     status = SET; /* SPI_FLAG is set */
1311  0006 a601          	ld	a,#1
1314  0008               L306:
1315                     ; 324     status = RESET; /* SPI_FLAG is reset*/
1318                     ; 328   return status;
1322  0008 5b01          	addw	sp,#1
1323  000a 81            	ret	
1358                     ; 346 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1358                     ; 347 {
1359                     .text:	section	.text,new
1360  0000               _SPI_ClearFlag:
1364                     ; 348   assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1366                     ; 350   SPI->SR = (uint8_t)(~SPI_FLAG);
1368  0000 43            	cpl	a
1369  0001 c75203        	ld	20995,a
1370                     ; 351 }
1373  0004 81            	ret	
1455                     ; 366 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1455                     ; 367 {
1456                     .text:	section	.text,new
1457  0000               _SPI_GetITStatus:
1459  0000 88            	push	a
1460  0001 89            	pushw	x
1461       00000002      OFST:	set	2
1464                     ; 368   ITStatus pendingbitstatus = RESET;
1466                     ; 369   uint8_t itpos = 0;
1468                     ; 370   uint8_t itmask1 = 0;
1470                     ; 371   uint8_t itmask2 = 0;
1472                     ; 372   uint8_t enablestatus = 0;
1474                     ; 373   assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1476                     ; 375   itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1478  0002 a40f          	and	a,#15
1479  0004 5f            	clrw	x
1480  0005 97            	ld	xl,a
1481  0006 a601          	ld	a,#1
1482  0008 5d            	tnzw	x
1483  0009 2704          	jreq	L45
1484  000b               L65:
1485  000b 48            	sll	a
1486  000c 5a            	decw	x
1487  000d 26fc          	jrne	L65
1488  000f               L45:
1489  000f 6b01          	ld	(OFST-1,sp),a
1491                     ; 378   itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1493  0011 7b03          	ld	a,(OFST+1,sp)
1494  0013 4e            	swap	a
1495  0014 a40f          	and	a,#15
1496  0016 6b02          	ld	(OFST+0,sp),a
1498                     ; 380   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1500  0018 5f            	clrw	x
1501  0019 97            	ld	xl,a
1502  001a a601          	ld	a,#1
1503  001c 5d            	tnzw	x
1504  001d 2704          	jreq	L06
1505  001f               L26:
1506  001f 48            	sll	a
1507  0020 5a            	decw	x
1508  0021 26fc          	jrne	L26
1509  0023               L06:
1511                     ; 382   enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1513  0023 c45203        	and	a,20995
1514  0026 6b02          	ld	(OFST+0,sp),a
1516                     ; 384   if (((SPI->ICR & itpos) != RESET) && enablestatus)
1518  0028 c65202        	ld	a,20994
1519  002b 1501          	bcp	a,(OFST-1,sp)
1520  002d 2708          	jreq	L766
1522  002f 7b02          	ld	a,(OFST+0,sp)
1523  0031 2704          	jreq	L766
1524                     ; 387     pendingbitstatus = SET;
1526  0033 a601          	ld	a,#1
1529  0035 2001          	jra	L176
1530  0037               L766:
1531                     ; 392     pendingbitstatus = RESET;
1533  0037 4f            	clr	a
1535  0038               L176:
1536                     ; 395   return  pendingbitstatus;
1540  0038 5b03          	addw	sp,#3
1541  003a 81            	ret	
1586                     ; 412 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1586                     ; 413 {
1587                     .text:	section	.text,new
1588  0000               _SPI_ClearITPendingBit:
1590  0000 88            	push	a
1591       00000001      OFST:	set	1
1594                     ; 414   uint8_t itpos = 0;
1596                     ; 415   assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1598                     ; 420   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1600  0001 4e            	swap	a
1601  0002 a40f          	and	a,#15
1602  0004 5f            	clrw	x
1603  0005 97            	ld	xl,a
1604  0006 a601          	ld	a,#1
1605  0008 5d            	tnzw	x
1606  0009 2704          	jreq	L66
1607  000b               L07:
1608  000b 48            	sll	a
1609  000c 5a            	decw	x
1610  000d 26fc          	jrne	L07
1611  000f               L66:
1613                     ; 422   SPI->SR = (uint8_t)(~itpos);
1615  000f 43            	cpl	a
1616  0010 c75203        	ld	20995,a
1617                     ; 424 }
1620  0013 84            	pop	a
1621  0014 81            	ret	
1634                     	xdef	_SPI_ClearITPendingBit
1635                     	xdef	_SPI_GetITStatus
1636                     	xdef	_SPI_ClearFlag
1637                     	xdef	_SPI_GetFlagStatus
1638                     	xdef	_SPI_BiDirectionalLineConfig
1639                     	xdef	_SPI_GetCRCPolynomial
1640                     	xdef	_SPI_ResetCRC
1641                     	xdef	_SPI_GetCRC
1642                     	xdef	_SPI_CalculateCRCCmd
1643                     	xdef	_SPI_TransmitCRC
1644                     	xdef	_SPI_NSSInternalSoftwareCmd
1645                     	xdef	_SPI_ReceiveData
1646                     	xdef	_SPI_SendData
1647                     	xdef	_SPI_ITConfig
1648                     	xdef	_SPI_Cmd
1649                     	xdef	_SPI_Init
1650                     	xdef	_SPI_DeInit
1669                     	end
