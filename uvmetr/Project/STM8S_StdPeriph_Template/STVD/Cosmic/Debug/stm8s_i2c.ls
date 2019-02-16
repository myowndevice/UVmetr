   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.5 - 29 Dec 2015
   3                     ; Generator (Limited) V4.4.4 - 27 Jan 2016
   4                     ; Optimizer V4.4.4 - 27 Jan 2016
  49                     ; 67 void I2C_DeInit(void)
  49                     ; 68 {
  51                     .text:	section	.text,new
  52  0000               _I2C_DeInit:
  56                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  58  0000 725f5210      	clr	21008
  59                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  61  0004 725f5211      	clr	21009
  62                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  64  0008 725f5212      	clr	21010
  65                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  67  000c 725f5213      	clr	21011
  68                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  70  0010 725f5214      	clr	21012
  71                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  73  0014 725f521a      	clr	21018
  74                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  76  0018 725f521b      	clr	21019
  77                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  79  001c 725f521c      	clr	21020
  80                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  82  0020 3502521d      	mov	21021,#2
  83                     ; 78 }
  86  0024 81            	ret	
 227                     .const:	section	.text
 228  0000               L01:
 229  0000 000186a1      	dc.l	100001
 230  0004               L21:
 231  0004 000f4240      	dc.l	1000000
 232                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 232                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 232                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 232                     ; 99 {
 233                     .text:	section	.text,new
 234  0000               _I2C_Init:
 236  0000 5209          	subw	sp,#9
 237       00000009      OFST:	set	9
 240                     ; 100   uint16_t result = 0x0004;
 242                     ; 101   uint16_t tmpval = 0;
 244                     ; 102   uint8_t tmpccrh = 0;
 246  0002 0f07          	clr	(OFST-2,sp)
 248                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 250  0004 c65212        	ld	a,21010
 251  0007 a4c0          	and	a,#192
 252  0009 c75212        	ld	21010,a
 253                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 255  000c c65212        	ld	a,21010
 256  000f 1a15          	or	a,(OFST+12,sp)
 257  0011 c75212        	ld	21010,a
 258                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 260  0014 72115210      	bres	21008,#0
 261                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 263  0018 c6521c        	ld	a,21020
 264  001b a430          	and	a,#48
 265  001d c7521c        	ld	21020,a
 266                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 268  0020 725f521b      	clr	21019
 269                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 271  0024 96            	ldw	x,sp
 272  0025 1c000c        	addw	x,#OFST+3
 273  0028 cd0000        	call	c_ltor
 275  002b ae0000        	ldw	x,#L01
 276  002e cd0000        	call	c_lcmp
 278  0031 2560          	jrult	L311
 279                     ; 131     tmpccrh = I2C_CCRH_FS;
 281  0033 a680          	ld	a,#128
 282  0035 6b07          	ld	(OFST-2,sp),a
 284                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 286  0037 96            	ldw	x,sp
 287  0038 0d12          	tnz	(OFST+9,sp)
 288  003a 261d          	jrne	L511
 289                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 291  003c 1c000c        	addw	x,#OFST+3
 292  003f cd0000        	call	c_ltor
 294  0042 a603          	ld	a,#3
 295  0044 cd0000        	call	c_smul
 297  0047 96            	ldw	x,sp
 298  0048 5c            	incw	x
 299  0049 cd0000        	call	c_rtol
 302  004c 7b15          	ld	a,(OFST+12,sp)
 303  004e cd00f4        	call	LC001
 305  0051 96            	ldw	x,sp
 306  0052 cd0102        	call	LC002
 307  0055 1f08          	ldw	(OFST-1,sp),x
 310  0057 2021          	jra	L711
 311  0059               L511:
 312                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 314  0059 1c000c        	addw	x,#OFST+3
 315  005c cd0000        	call	c_ltor
 317  005f a619          	ld	a,#25
 318  0061 cd0000        	call	c_smul
 320  0064 96            	ldw	x,sp
 321  0065 5c            	incw	x
 322  0066 cd0000        	call	c_rtol
 325  0069 7b15          	ld	a,(OFST+12,sp)
 326  006b cd00f4        	call	LC001
 328  006e 96            	ldw	x,sp
 329  006f cd0102        	call	LC002
 330  0072 1f08          	ldw	(OFST-1,sp),x
 332                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 334  0074 7b07          	ld	a,(OFST-2,sp)
 335  0076 aa40          	or	a,#64
 336  0078 6b07          	ld	(OFST-2,sp),a
 338  007a               L711:
 339                     ; 147     if (result < (uint16_t)0x01)
 341  007a 1e08          	ldw	x,(OFST-1,sp)
 342  007c 2603          	jrne	L121
 343                     ; 150       result = (uint16_t)0x0001;
 345  007e 5c            	incw	x
 346  007f 1f08          	ldw	(OFST-1,sp),x
 348  0081               L121:
 349                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 351  0081 7b15          	ld	a,(OFST+12,sp)
 352  0083 97            	ld	xl,a
 353  0084 a603          	ld	a,#3
 354  0086 42            	mul	x,a
 355  0087 a60a          	ld	a,#10
 356  0089 cd0000        	call	c_sdivx
 358  008c 5c            	incw	x
 359  008d 1f05          	ldw	(OFST-4,sp),x
 361                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 363  008f 7b06          	ld	a,(OFST-3,sp)
 365  0091 2028          	jra	L321
 366  0093               L311:
 367                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 369  0093 96            	ldw	x,sp
 370  0094 1c000c        	addw	x,#OFST+3
 371  0097 cd0000        	call	c_ltor
 373  009a 3803          	sll	c_lreg+3
 374  009c 3902          	rlc	c_lreg+2
 375  009e 3901          	rlc	c_lreg+1
 376  00a0 96            	ldw	x,sp
 377  00a1 3900          	rlc	c_lreg
 378  00a3 5c            	incw	x
 379  00a4 cd0000        	call	c_rtol
 382  00a7 7b15          	ld	a,(OFST+12,sp)
 383  00a9 ad49          	call	LC001
 385  00ab 96            	ldw	x,sp
 386  00ac ad54          	call	LC002
 388                     ; 167     if (result < (uint16_t)0x0004)
 390  00ae a30004        	cpw	x,#4
 391  00b1 2403          	jruge	L521
 392                     ; 170       result = (uint16_t)0x0004;
 394  00b3 ae0004        	ldw	x,#4
 396  00b6               L521:
 397  00b6 1f08          	ldw	(OFST-1,sp),x
 398                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 400  00b8 7b15          	ld	a,(OFST+12,sp)
 401  00ba 4c            	inc	a
 402  00bb               L321:
 403  00bb c7521d        	ld	21021,a
 404                     ; 181   I2C->CCRL = (uint8_t)result;
 406  00be 7b09          	ld	a,(OFST+0,sp)
 407  00c0 c7521b        	ld	21019,a
 408                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 410  00c3 7b08          	ld	a,(OFST-1,sp)
 411  00c5 a40f          	and	a,#15
 412  00c7 1a07          	or	a,(OFST-2,sp)
 413  00c9 c7521c        	ld	21020,a
 414                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 416  00cc 72105210      	bset	21008,#0
 417                     ; 189 	I2C->CR2 |= I2C_CR2_ACK;
 419  00d0 72145211      	bset	21009,#2
 420                     ; 190 	I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 422  00d4 72175211      	bres	21009,#3
 423                     ; 194   I2C->OARL = (uint8_t)(OwnAddress);
 425  00d8 7b11          	ld	a,(OFST+8,sp)
 426  00da c75213        	ld	21011,a
 427                     ; 195   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 427                     ; 196                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 429  00dd 1e10          	ldw	x,(OFST+7,sp)
 430  00df 4f            	clr	a
 431  00e0 01            	rrwa	x,a
 432  00e1 48            	sll	a
 433  00e2 01            	rrwa	x,a
 434  00e3 49            	rlc	a
 435  00e4 a406          	and	a,#6
 436  00e6 6b04          	ld	(OFST-5,sp),a
 438  00e8 7b14          	ld	a,(OFST+11,sp)
 439  00ea aa40          	or	a,#64
 440  00ec 1a04          	or	a,(OFST-5,sp)
 441  00ee c75214        	ld	21012,a
 442                     ; 197 }
 445  00f1 5b09          	addw	sp,#9
 446  00f3 81            	ret	
 447  00f4               LC001:
 448  00f4 b703          	ld	c_lreg+3,a
 449  00f6 3f02          	clr	c_lreg+2
 450  00f8 3f01          	clr	c_lreg+1
 451  00fa 3f00          	clr	c_lreg
 452  00fc ae0004        	ldw	x,#L21
 453  00ff cc0000        	jp	c_lmul
 454  0102               LC002:
 455  0102 5c            	incw	x
 456  0103 cd0000        	call	c_ludv
 458  0106 be02          	ldw	x,c_lreg+2
 459  0108 81            	ret	
 514                     ; 205 void I2C_Cmd(FunctionalState NewState)
 514                     ; 206 {
 515                     .text:	section	.text,new
 516  0000               _I2C_Cmd:
 520                     ; 210   if (NewState != DISABLE)
 522  0000 4d            	tnz	a
 523  0001 2705          	jreq	L551
 524                     ; 213     I2C->CR1 |= I2C_CR1_PE;
 526  0003 72105210      	bset	21008,#0
 529  0007 81            	ret	
 530  0008               L551:
 531                     ; 218     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 533  0008 72115210      	bres	21008,#0
 534                     ; 220 }
 537  000c 81            	ret	
 572                     ; 228 void I2C_GeneralCallCmd(FunctionalState NewState)
 572                     ; 229 {
 573                     .text:	section	.text,new
 574  0000               _I2C_GeneralCallCmd:
 578                     ; 231   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 580                     ; 233   if (NewState != DISABLE)
 582  0000 4d            	tnz	a
 583  0001 2705          	jreq	L771
 584                     ; 236     I2C->CR1 |= I2C_CR1_ENGC;
 586  0003 721c5210      	bset	21008,#6
 589  0007 81            	ret	
 590  0008               L771:
 591                     ; 241     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 593  0008 721d5210      	bres	21008,#6
 594                     ; 243 }
 597  000c 81            	ret	
 632                     ; 253 void I2C_GenerateSTART(FunctionalState NewState)
 632                     ; 254 {
 633                     .text:	section	.text,new
 634  0000               _I2C_GenerateSTART:
 638                     ; 256   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 640                     ; 258   if (NewState != DISABLE)
 642  0000 4d            	tnz	a
 643  0001 2705          	jreq	L122
 644                     ; 261     I2C->CR2 |= I2C_CR2_START;
 646  0003 72105211      	bset	21009,#0
 649  0007 81            	ret	
 650  0008               L122:
 651                     ; 266     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 653  0008 72115211      	bres	21009,#0
 654                     ; 268 }
 657  000c 81            	ret	
 692                     ; 276 void I2C_GenerateSTOP(FunctionalState NewState)
 692                     ; 277 {
 693                     .text:	section	.text,new
 694  0000               _I2C_GenerateSTOP:
 698                     ; 279   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 700                     ; 281   if (NewState != DISABLE)
 702  0000 4d            	tnz	a
 703  0001 2705          	jreq	L342
 704                     ; 284     I2C->CR2 |= I2C_CR2_STOP;
 706  0003 72125211      	bset	21009,#1
 709  0007 81            	ret	
 710  0008               L342:
 711                     ; 289     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 713  0008 72135211      	bres	21009,#1
 714                     ; 291 }
 717  000c 81            	ret	
 753                     ; 299 void I2C_SoftwareResetCmd(FunctionalState NewState)
 753                     ; 300 {
 754                     .text:	section	.text,new
 755  0000               _I2C_SoftwareResetCmd:
 759                     ; 302   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 761                     ; 304   if (NewState != DISABLE)
 763  0000 4d            	tnz	a
 764  0001 2705          	jreq	L562
 765                     ; 307     I2C->CR2 |= I2C_CR2_SWRST;
 767  0003 721e5211      	bset	21009,#7
 770  0007 81            	ret	
 771  0008               L562:
 772                     ; 312     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 774  0008 721f5211      	bres	21009,#7
 775                     ; 314 }
 778  000c 81            	ret	
 814                     ; 323 void I2C_StretchClockCmd(FunctionalState NewState)
 814                     ; 324 {
 815                     .text:	section	.text,new
 816  0000               _I2C_StretchClockCmd:
 820                     ; 326   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 822                     ; 328   if (NewState != DISABLE)
 824  0000 4d            	tnz	a
 825  0001 2705          	jreq	L703
 826                     ; 331     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 828  0003 721f5210      	bres	21008,#7
 831  0007 81            	ret	
 832  0008               L703:
 833                     ; 337     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 835  0008 721e5210      	bset	21008,#7
 836                     ; 339 }
 839  000c 81            	ret	
 902                     ; 348 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 902                     ; 349 {
 903                     .text:	section	.text,new
 904  0000               _I2C_AcknowledgeConfig:
 906  0000 88            	push	a
 907       00000000      OFST:	set	0
 910                     ; 353   if (Ack == I2C_ACK_NONE)
 912  0001 4d            	tnz	a
 913  0002 2606          	jrne	L343
 914                     ; 356     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 916  0004 72155211      	bres	21009,#2
 918  0008 2011          	jra	L543
 919  000a               L343:
 920                     ; 361     I2C->CR2 |= I2C_CR2_ACK;
 922  000a 72145211      	bset	21009,#2
 923                     ; 363     if (Ack == I2C_ACK_CURR)
 925  000e 4a            	dec	a
 926  000f 2606          	jrne	L743
 927                     ; 366       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 929  0011 72175211      	bres	21009,#3
 931  0015 2004          	jra	L543
 932  0017               L743:
 933                     ; 371       I2C->CR2 |= I2C_CR2_POS;
 935  0017 72165211      	bset	21009,#3
 936  001b               L543:
 937                     ; 374 }
 940  001b 84            	pop	a
 941  001c 81            	ret	
1013                     ; 384 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1013                     ; 385 {
1014                     .text:	section	.text,new
1015  0000               _I2C_ITConfig:
1017  0000 89            	pushw	x
1018       00000000      OFST:	set	0
1021                     ; 387   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1023                     ; 388   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1025                     ; 390   if (NewState != DISABLE)
1027  0001 9f            	ld	a,xl
1028  0002 4d            	tnz	a
1029  0003 2706          	jreq	L704
1030                     ; 393     I2C->ITR |= (uint8_t)I2C_IT;
1032  0005 9e            	ld	a,xh
1033  0006 ca521a        	or	a,21018
1035  0009 2006          	jra	L114
1036  000b               L704:
1037                     ; 398     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1039  000b 7b01          	ld	a,(OFST+1,sp)
1040  000d 43            	cpl	a
1041  000e c4521a        	and	a,21018
1042  0011               L114:
1043  0011 c7521a        	ld	21018,a
1044                     ; 400 }
1047  0014 85            	popw	x
1048  0015 81            	ret	
1084                     ; 408 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1084                     ; 409 {
1085                     .text:	section	.text,new
1086  0000               _I2C_FastModeDutyCycleConfig:
1090                     ; 411   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1092                     ; 413   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1094  0000 a140          	cp	a,#64
1095  0002 2605          	jrne	L134
1096                     ; 416     I2C->CCRH |= I2C_CCRH_DUTY;
1098  0004 721c521c      	bset	21020,#6
1101  0008 81            	ret	
1102  0009               L134:
1103                     ; 421     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1105  0009 721d521c      	bres	21020,#6
1106                     ; 423 }
1109  000d 81            	ret	
1132                     ; 430 uint8_t I2C_ReceiveData(void)
1132                     ; 431 {
1133                     .text:	section	.text,new
1134  0000               _I2C_ReceiveData:
1138                     ; 433   return ((uint8_t)I2C->DR);
1140  0000 c65216        	ld	a,21014
1143  0003 81            	ret	
1208                     ; 443 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1208                     ; 444 {
1209                     .text:	section	.text,new
1210  0000               _I2C_Send7bitAddress:
1212  0000 89            	pushw	x
1213       00000000      OFST:	set	0
1216                     ; 450   Address &= (uint8_t)0xFE;
1218  0001 7b01          	ld	a,(OFST+1,sp)
1219  0003 a4fe          	and	a,#254
1220  0005 6b01          	ld	(OFST+1,sp),a
1221                     ; 453   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1223  0007 1a02          	or	a,(OFST+2,sp)
1224  0009 c75216        	ld	21014,a
1225                     ; 454 }
1228  000c 85            	popw	x
1229  000d 81            	ret	
1263                     ; 461 void I2C_SendData(uint8_t Data)
1263                     ; 462 {
1264                     .text:	section	.text,new
1265  0000               _I2C_SendData:
1269                     ; 464   I2C->DR = Data;
1271  0000 c75216        	ld	21014,a
1272                     ; 465 }
1275  0003 81            	ret	
1499                     ; 581 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1499                     ; 582 {
1500                     .text:	section	.text,new
1501  0000               _I2C_CheckEvent:
1503  0000 89            	pushw	x
1504  0001 5206          	subw	sp,#6
1505       00000006      OFST:	set	6
1508                     ; 583   __IO uint16_t lastevent = 0x00;
1510  0003 5f            	clrw	x
1511  0004 1f04          	ldw	(OFST-2,sp),x
1513                     ; 584   uint8_t flag1 = 0x00 ;
1515                     ; 585   uint8_t flag2 = 0x00;
1517                     ; 586   ErrorStatus status = ERROR;
1519                     ; 591   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1521  0006 1e07          	ldw	x,(OFST+1,sp)
1522  0008 a30004        	cpw	x,#4
1523  000b 2609          	jrne	L526
1524                     ; 593     lastevent = I2C->SR2 & I2C_SR2_AF;
1526  000d c65218        	ld	a,21016
1527  0010 a404          	and	a,#4
1528  0012 5f            	clrw	x
1529  0013 97            	ld	xl,a
1531  0014 201a          	jra	L726
1532  0016               L526:
1533                     ; 597     flag1 = I2C->SR1;
1535  0016 c65217        	ld	a,21015
1536  0019 6b03          	ld	(OFST-3,sp),a
1538                     ; 598     flag2 = I2C->SR3;
1540  001b c65219        	ld	a,21017
1541  001e 6b06          	ld	(OFST+0,sp),a
1543                     ; 599     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1545  0020 5f            	clrw	x
1546  0021 7b03          	ld	a,(OFST-3,sp)
1547  0023 97            	ld	xl,a
1548  0024 1f01          	ldw	(OFST-5,sp),x
1550  0026 5f            	clrw	x
1551  0027 7b06          	ld	a,(OFST+0,sp)
1552  0029 97            	ld	xl,a
1553  002a 7b02          	ld	a,(OFST-4,sp)
1554  002c 01            	rrwa	x,a
1555  002d 1a01          	or	a,(OFST-5,sp)
1556  002f 01            	rrwa	x,a
1557  0030               L726:
1558  0030 1f04          	ldw	(OFST-2,sp),x
1560                     ; 602   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1562  0032 1e04          	ldw	x,(OFST-2,sp)
1563  0034 01            	rrwa	x,a
1564  0035 1408          	and	a,(OFST+2,sp)
1565  0037 01            	rrwa	x,a
1566  0038 1407          	and	a,(OFST+1,sp)
1567  003a 01            	rrwa	x,a
1568  003b 1307          	cpw	x,(OFST+1,sp)
1569  003d 2604          	jrne	L136
1570                     ; 605     status = SUCCESS;
1572  003f a601          	ld	a,#1
1575  0041 2001          	jra	L336
1576  0043               L136:
1577                     ; 610     status = ERROR;
1579  0043 4f            	clr	a
1581  0044               L336:
1582                     ; 614   return status;
1586  0044 5b08          	addw	sp,#8
1587  0046 81            	ret	
1640                     ; 631 I2C_Event_TypeDef I2C_GetLastEvent(void)
1640                     ; 632 {
1641                     .text:	section	.text,new
1642  0000               _I2C_GetLastEvent:
1644  0000 5206          	subw	sp,#6
1645       00000006      OFST:	set	6
1648                     ; 633   __IO uint16_t lastevent = 0;
1650  0002 5f            	clrw	x
1651  0003 1f05          	ldw	(OFST-1,sp),x
1653                     ; 634   uint16_t flag1 = 0;
1655                     ; 635   uint16_t flag2 = 0;
1657                     ; 637   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1659  0005 7205521805    	btjf	21016,#2,L366
1660                     ; 639     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1662  000a ae0004        	ldw	x,#4
1664  000d 2013          	jra	L566
1665  000f               L366:
1666                     ; 644     flag1 = I2C->SR1;
1668  000f c65217        	ld	a,21015
1669  0012 97            	ld	xl,a
1670  0013 1f01          	ldw	(OFST-5,sp),x
1672                     ; 645     flag2 = I2C->SR3;
1674  0015 c65219        	ld	a,21017
1675  0018 5f            	clrw	x
1676  0019 97            	ld	xl,a
1677  001a 1f03          	ldw	(OFST-3,sp),x
1679                     ; 648     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1681  001c 7b02          	ld	a,(OFST-4,sp)
1682  001e 01            	rrwa	x,a
1683  001f 1a01          	or	a,(OFST-5,sp)
1684  0021 01            	rrwa	x,a
1685  0022               L566:
1686  0022 1f05          	ldw	(OFST-1,sp),x
1688                     ; 651   return (I2C_Event_TypeDef)lastevent;
1690  0024 1e05          	ldw	x,(OFST-1,sp)
1693  0026 5b06          	addw	sp,#6
1694  0028 81            	ret	
1909                     ; 682 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1909                     ; 683 {
1910                     .text:	section	.text,new
1911  0000               _I2C_GetFlagStatus:
1913  0000 89            	pushw	x
1914  0001 89            	pushw	x
1915       00000002      OFST:	set	2
1918                     ; 684   uint8_t tempreg = 0;
1920  0002 0f02          	clr	(OFST+0,sp)
1922                     ; 685   uint8_t regindex = 0;
1924                     ; 686   FlagStatus bitstatus = RESET;
1926                     ; 692   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1928  0004 9e            	ld	a,xh
1929  0005 6b01          	ld	(OFST-1,sp),a
1931                     ; 694   switch (regindex)
1934                     ; 711     default:
1934                     ; 712       break;
1935  0007 4a            	dec	a
1936  0008 2708          	jreq	L766
1937  000a 4a            	dec	a
1938  000b 270a          	jreq	L176
1939  000d 4a            	dec	a
1940  000e 270c          	jreq	L376
1941  0010 200f          	jra	L7001
1942  0012               L766:
1943                     ; 697     case 0x01:
1943                     ; 698       tempreg = (uint8_t)I2C->SR1;
1945  0012 c65217        	ld	a,21015
1946                     ; 699       break;
1948  0015 2008          	jp	LC003
1949  0017               L176:
1950                     ; 702     case 0x02:
1950                     ; 703       tempreg = (uint8_t)I2C->SR2;
1952  0017 c65218        	ld	a,21016
1953                     ; 704       break;
1955  001a 2003          	jp	LC003
1956  001c               L376:
1957                     ; 707     case 0x03:
1957                     ; 708       tempreg = (uint8_t)I2C->SR3;
1959  001c c65219        	ld	a,21017
1960  001f               LC003:
1961  001f 6b02          	ld	(OFST+0,sp),a
1963                     ; 709       break;
1965                     ; 711     default:
1965                     ; 712       break;
1967  0021               L7001:
1968                     ; 716   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
1970  0021 7b04          	ld	a,(OFST+2,sp)
1971  0023 1502          	bcp	a,(OFST+0,sp)
1972  0025 2704          	jreq	L1101
1973                     ; 719     bitstatus = SET;
1975  0027 a601          	ld	a,#1
1978  0029 2001          	jra	L3101
1979  002b               L1101:
1980                     ; 724     bitstatus = RESET;
1982  002b 4f            	clr	a
1984  002c               L3101:
1985                     ; 727   return bitstatus;
1989  002c 5b04          	addw	sp,#4
1990  002e 81            	ret	
2034                     ; 762 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2034                     ; 763 {
2035                     .text:	section	.text,new
2036  0000               _I2C_ClearFlag:
2038  0000 89            	pushw	x
2039       00000002      OFST:	set	2
2042                     ; 764   uint16_t flagpos = 0;
2044                     ; 769   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2046  0001 01            	rrwa	x,a
2047  0002 5f            	clrw	x
2048  0003 02            	rlwa	x,a
2049  0004 1f01          	ldw	(OFST-1,sp),x
2051                     ; 771   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2053  0006 7b02          	ld	a,(OFST+0,sp)
2054  0008 43            	cpl	a
2055  0009 c75218        	ld	21016,a
2056                     ; 772 }
2059  000c 85            	popw	x
2060  000d 81            	ret	
2226                     ; 794 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2226                     ; 795 {
2227                     .text:	section	.text,new
2228  0000               _I2C_GetITStatus:
2230  0000 89            	pushw	x
2231  0001 5204          	subw	sp,#4
2232       00000004      OFST:	set	4
2235                     ; 796   ITStatus bitstatus = RESET;
2237                     ; 797   __IO uint8_t enablestatus = 0;
2239  0003 0f03          	clr	(OFST-1,sp)
2241                     ; 798   uint16_t tempregister = 0;
2243                     ; 803   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2245  0005 9e            	ld	a,xh
2246  0006 a407          	and	a,#7
2247  0008 5f            	clrw	x
2248  0009 97            	ld	xl,a
2249  000a 1f01          	ldw	(OFST-3,sp),x
2251                     ; 806   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2253  000c c6521a        	ld	a,21018
2254  000f 1402          	and	a,(OFST-2,sp)
2255  0011 6b03          	ld	(OFST-1,sp),a
2257                     ; 808   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2259  0013 7b05          	ld	a,(OFST+1,sp)
2260  0015 a430          	and	a,#48
2261  0017 97            	ld	xl,a
2262  0018 4f            	clr	a
2263  0019 02            	rlwa	x,a
2264  001a a30100        	cpw	x,#256
2265  001d 260d          	jrne	L5211
2266                     ; 811     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2268  001f c65217        	ld	a,21015
2269  0022 1506          	bcp	a,(OFST+2,sp)
2270  0024 2715          	jreq	L5311
2272  0026 0d03          	tnz	(OFST-1,sp)
2273  0028 2711          	jreq	L5311
2274                     ; 814       bitstatus = SET;
2276  002a 200b          	jp	LC005
2277                     ; 819       bitstatus = RESET;
2278  002c               L5211:
2279                     ; 825     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2281  002c c65218        	ld	a,21016
2282  002f 1506          	bcp	a,(OFST+2,sp)
2283  0031 2708          	jreq	L5311
2285  0033 0d03          	tnz	(OFST-1,sp)
2286  0035 2704          	jreq	L5311
2287                     ; 828       bitstatus = SET;
2289  0037               LC005:
2291  0037 a601          	ld	a,#1
2294  0039 2001          	jra	L3311
2295  003b               L5311:
2296                     ; 833       bitstatus = RESET;
2299  003b 4f            	clr	a
2301  003c               L3311:
2302                     ; 837   return  bitstatus;
2306  003c 5b06          	addw	sp,#6
2307  003e 81            	ret	
2352                     ; 874 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2352                     ; 875 {
2353                     .text:	section	.text,new
2354  0000               _I2C_ClearITPendingBit:
2356  0000 89            	pushw	x
2357       00000002      OFST:	set	2
2360                     ; 876   uint16_t flagpos = 0;
2362                     ; 882   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2364  0001 01            	rrwa	x,a
2365  0002 5f            	clrw	x
2366  0003 02            	rlwa	x,a
2367  0004 1f01          	ldw	(OFST-1,sp),x
2369                     ; 885   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2371  0006 7b02          	ld	a,(OFST+0,sp)
2372  0008 43            	cpl	a
2373  0009 c75218        	ld	21016,a
2374                     ; 886 }
2377  000c 85            	popw	x
2378  000d 81            	ret	
2391                     	xdef	_I2C_ClearITPendingBit
2392                     	xdef	_I2C_GetITStatus
2393                     	xdef	_I2C_ClearFlag
2394                     	xdef	_I2C_GetFlagStatus
2395                     	xdef	_I2C_GetLastEvent
2396                     	xdef	_I2C_CheckEvent
2397                     	xdef	_I2C_SendData
2398                     	xdef	_I2C_Send7bitAddress
2399                     	xdef	_I2C_ReceiveData
2400                     	xdef	_I2C_ITConfig
2401                     	xdef	_I2C_FastModeDutyCycleConfig
2402                     	xdef	_I2C_AcknowledgeConfig
2403                     	xdef	_I2C_StretchClockCmd
2404                     	xdef	_I2C_SoftwareResetCmd
2405                     	xdef	_I2C_GenerateSTOP
2406                     	xdef	_I2C_GenerateSTART
2407                     	xdef	_I2C_GeneralCallCmd
2408                     	xdef	_I2C_Cmd
2409                     	xdef	_I2C_Init
2410                     	xdef	_I2C_DeInit
2411                     	xref.b	c_lreg
2412                     	xref.b	c_x
2431                     	xref	c_sdivx
2432                     	xref	c_ludv
2433                     	xref	c_rtol
2434                     	xref	c_smul
2435                     	xref	c_lmul
2436                     	xref	c_lcmp
2437                     	xref	c_ltor
2438                     	end
