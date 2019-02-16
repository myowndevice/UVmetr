   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.5 - 29 Dec 2015
   3                     ; Generator (Limited) V4.4.4 - 27 Jan 2016
   4                     ; Optimizer V4.4.4 - 27 Jan 2016
  21                     	bsct
  22  0000               _blockcopylcd:
  23  0000 00            	dc.b	0
  24  0001               _ind:
  25  0001 00            	dc.b	0
  26  0002 00            	dc.b	0
  27  0003 00            	dc.b	0
  28  0004               _tchk:
  29  0004 00            	dc.b	0
  30  0005 00            	dc.b	0
  31  0006 00            	dc.b	0
  32  0007               _numind:
  33  0007 00            	dc.b	0
  34  0008               _sch:
  35  0008 00000000      	dc.l	0
  36  000c               _kndtime:
  37  000c 00            	dc.b	0
  38  000d               _timenct:
  39  000d 0000          	dc.w	0
  40  000f               _timemcp:
  41  000f 0000          	dc.w	0
  42  0011               _timeuv:
  43  0011 0000          	dc.w	0
  44  0013               _sleeptime:
  45  0013 0000          	dc.w	0
  46  0015               _timeshowrezhim:
  47  0015 0000          	dc.w	0
  48  0017               _rezhim:
  49  0017 02            	dc.b	2
  50  0018               _current_millis:
  51  0018 00000000      	dc.l	0
  52  001c               _kn1:
  53  001c 0000          	dc.w	0
  54  001e               _kn2:
  55  001e 0000          	dc.w	0
  56  0020               _kn1old:
  57  0020 0000          	dc.w	0
  58  0022               _kn2old:
  59  0022 0000          	dc.w	0
  60  0024               _fandes:
  61  0024 0000          	dc.w	0
  62  0026               _fansot:
  63  0026 0000          	dc.w	0
  64                     .const:	section	.text
  65  0000               _cK:
  66  0000               L7:
  67  0000 41c8ab1c      	dc.w	16840,-21732
  68  0004               L71:
  69  0004 3da0f997      	dc.w	15776,-1641
  70  0008               L72:
  71  0008 be802909      	dc.w	-16768,10505
  72  000c               L73:
  73  000c 3daa4bf6      	dc.w	15786,19446
  74  0010               L74:
  75  0010 bc49337a      	dc.w	-17335,13178
  76  0014               L75:
  77  0014 3a8080e2      	dc.w	14976,-32542
  78  0018               L76:
  79  0018 b839188c      	dc.w	-18375,6284
  80  001c               L77:
  81  001c 358df776      	dc.w	13709,-2186
  82  0020               L701:
  83  0020 b234dca7      	dc.w	-19916,-9049
  84  0024               _cKm:
  85  0024               L711:
  86  0024 41c96340      	dc.w	16841,25408
  87  0028               L721:
  88  0028 bf9548eb      	dc.w	-16491,18667
  89  002c               L731:
  90  002c bf8aabaa      	dc.w	-16502,-21590
  91  0030               L741:
  92  0030 bf65d1fc      	dc.w	-16539,-11780
  93  0034               L751:
  94  0034 bebf3166      	dc.w	-16705,12646
  95  0038               L761:
  96  0038 bdb16c74      	dc.w	-16975,27764
  97  003c               L771:
  98  003c bc2b38fc      	dc.w	-17365,14588
  99  0040               L702:
 100  0040 ba081b4f      	dc.w	-17912,6991
 101  0044               _cKf:
 102  0044               L712:
 103  0044 c303ce48      	dc.w	-15613,-12728
 104  0048               L722:
 105  0048 42413579      	dc.w	16961,13689
 106  004c               L732:
 107  004c bfd2b124      	dc.w	-16430,-20188
 108  0050               L742:
 109  0050 3d5fd5db      	dc.w	15711,-10789
 110  0054               L752:
 111  0054 ba7cfcda      	dc.w	-17796,-806
 112  0058               L762:
 113  0058 3713ad21      	dc.w	14099,-21215
 114  005c               L772:
 115  005c b3059bb7      	dc.w	-19707,-25673
 156                     ; 170 void shownumber(u16 num) {
 158                     .text:	section	.text,new
 159  0000               _shownumber:
 161  0000 89            	pushw	x
 162  0001 88            	push	a
 163       00000001      OFST:	set	1
 166                     ; 171 	ind[0]=num/100;
 168  0002 a664          	ld	a,#100
 169  0004 62            	div	x,a
 170  0005 01            	rrwa	x,a
 171  0006 b701          	ld	_ind,a
 172                     ; 172 	ind[1]=num/10-ind[0]*10;
 174  0008 97            	ld	xl,a
 175  0009 a60a          	ld	a,#10
 176  000b 42            	mul	x,a
 177  000c 9f            	ld	a,xl
 178  000d 6b01          	ld	(OFST+0,sp),a
 180  000f a60a          	ld	a,#10
 181  0011 1e02          	ldw	x,(OFST+1,sp)
 182  0013 62            	div	x,a
 183  0014 01            	rrwa	x,a
 184  0015 1001          	sub	a,(OFST+0,sp)
 185  0017 b702          	ld	_ind+1,a
 186                     ; 173 	ind[2]=num - ind[0]*100 - ind[1]*10;
 188  0019 97            	ld	xl,a
 189  001a a60a          	ld	a,#10
 190  001c 42            	mul	x,a
 191  001d 9f            	ld	a,xl
 192  001e 6b01          	ld	(OFST+0,sp),a
 194  0020 b601          	ld	a,_ind
 195  0022 97            	ld	xl,a
 196  0023 a664          	ld	a,#100
 197  0025 42            	mul	x,a
 198  0026 9f            	ld	a,xl
 199  0027 1003          	sub	a,(OFST+2,sp)
 200  0029 40            	neg	a
 201  002a 1001          	sub	a,(OFST+0,sp)
 202  002c b703          	ld	_ind+2,a
 203                     ; 175 	if (ind[0]==0) {
 205  002e b601          	ld	a,_ind
 206  0030 260c          	jrne	L723
 207                     ; 176 		ind[0]=10;
 209  0032 350a0001      	mov	_ind,#10
 210                     ; 177 		if (ind[1]==0) ind[1]=10;
 212  0036 b602          	ld	a,_ind+1
 213  0038 2604          	jrne	L723
 216  003a 350a0002      	mov	_ind+1,#10
 217  003e               L723:
 218                     ; 179 }
 221  003e 5b03          	addw	sp,#3
 222  0040 81            	ret	
 332                     ; 182 char* shift_and_mul_utoa16(uint16_t n, char *buffer)
 332                     ; 183 {
 333                     .text:	section	.text,new
 334  0000               _shift_and_mul_utoa16:
 336  0000 89            	pushw	x
 337  0001 5208          	subw	sp,#8
 338       00000008      OFST:	set	8
 341                     ; 187         d1 = (n>>4)  & 0xF;
 343  0003 54            	srlw	x
 344  0004 54            	srlw	x
 345  0005 54            	srlw	x
 346  0006 54            	srlw	x
 347  0007 9f            	ld	a,xl
 348  0008 a40f          	and	a,#15
 349  000a 6b05          	ld	(OFST-3,sp),a
 351                     ; 188         d2 = (n>>8)  & 0xF;
 353  000c 7b09          	ld	a,(OFST+1,sp)
 354  000e a40f          	and	a,#15
 355  0010 6b07          	ld	(OFST-1,sp),a
 357                     ; 189         d3 = (n>>12) & 0xF;
 359  0012 1e09          	ldw	x,(OFST+1,sp)
 360  0014 01            	rrwa	x,a
 361  0015 9f            	ld	a,xl
 362  0016 4e            	swap	a
 363  0017 a40f          	and	a,#15
 364  0019 6b06          	ld	(OFST-2,sp),a
 366                     ; 191         d0 = 6*(d3 + d2 + d1) + (n & 0xF);
 368  001b 7b0a          	ld	a,(OFST+2,sp)
 369  001d a40f          	and	a,#15
 370  001f 6b01          	ld	(OFST-7,sp),a
 372  0021 7b06          	ld	a,(OFST-2,sp)
 373  0023 1b07          	add	a,(OFST-1,sp)
 374  0025 1b05          	add	a,(OFST-3,sp)
 375  0027 97            	ld	xl,a
 376  0028 a606          	ld	a,#6
 377  002a 42            	mul	x,a
 378  002b 9f            	ld	a,xl
 379  002c 1b01          	add	a,(OFST-7,sp)
 380  002e 6b02          	ld	(OFST-6,sp),a
 382                     ; 192         q = (d0 * 0xCD) >> 11;
 384  0030 97            	ld	xl,a
 385  0031 a6cd          	ld	a,#205
 386  0033 42            	mul	x,a
 387  0034 4f            	clr	a
 388  0035 5d            	tnzw	x
 389  0036 2a01          	jrpl	L21
 390  0038 43            	cpl	a
 391  0039               L21:
 392  0039 97            	ld	xl,a
 393  003a 5e            	swapw	x
 394  003b 57            	sraw	x
 395  003c 57            	sraw	x
 396  003d 57            	sraw	x
 397  003e 01            	rrwa	x,a
 398  003f 6b08          	ld	(OFST+0,sp),a
 400                     ; 193         d0 = d0 - 10*q;
 402  0041 cd00d8        	call	LC001
 403  0044 1002          	sub	a,(OFST-6,sp)
 404  0046 40            	neg	a
 405  0047 6b02          	ld	(OFST-6,sp),a
 407                     ; 195         d1 = q + 9*d3 + 5*d2 + d1;
 409  0049 7b07          	ld	a,(OFST-1,sp)
 410  004b 97            	ld	xl,a
 411  004c a605          	ld	a,#5
 412  004e 42            	mul	x,a
 413  004f 9f            	ld	a,xl
 414  0050 6b01          	ld	(OFST-7,sp),a
 416  0052 7b06          	ld	a,(OFST-2,sp)
 417  0054 97            	ld	xl,a
 418  0055 a609          	ld	a,#9
 419  0057 42            	mul	x,a
 420  0058 9f            	ld	a,xl
 421  0059 1b08          	add	a,(OFST+0,sp)
 422  005b 1b01          	add	a,(OFST-7,sp)
 423  005d 1b05          	add	a,(OFST-3,sp)
 424  005f 6b05          	ld	(OFST-3,sp),a
 426                     ; 196         q = (d1 * 0xCD) >> 11;
 428  0061 97            	ld	xl,a
 429  0062 a6cd          	ld	a,#205
 430  0064 42            	mul	x,a
 431  0065 4f            	clr	a
 432  0066 5d            	tnzw	x
 433  0067 2a01          	jrpl	L41
 434  0069 43            	cpl	a
 435  006a               L41:
 436  006a 97            	ld	xl,a
 437  006b 5e            	swapw	x
 438  006c 57            	sraw	x
 439  006d 57            	sraw	x
 440  006e 57            	sraw	x
 441  006f 01            	rrwa	x,a
 442  0070 6b08          	ld	(OFST+0,sp),a
 444                     ; 197         d1 = d1 - 10*q;
 446  0072 ad64          	call	LC001
 447  0074 1005          	sub	a,(OFST-3,sp)
 448  0076 40            	neg	a
 449  0077 6b05          	ld	(OFST-3,sp),a
 451                     ; 199         d2 = q + 2*d2;
 453  0079 7b07          	ld	a,(OFST-1,sp)
 454  007b 48            	sll	a
 455  007c 1b08          	add	a,(OFST+0,sp)
 456  007e 6b07          	ld	(OFST-1,sp),a
 458                     ; 200         q = (d2 * 0x1A) >> 8;
 460  0080 97            	ld	xl,a
 461  0081 a61a          	ld	a,#26
 462  0083 42            	mul	x,a
 463  0084 4f            	clr	a
 464  0085 5d            	tnzw	x
 465  0086 2a01          	jrpl	L61
 466  0088 43            	cpl	a
 467  0089               L61:
 468  0089 97            	ld	xl,a
 469  008a 5e            	swapw	x
 470  008b 01            	rrwa	x,a
 471  008c 6b08          	ld	(OFST+0,sp),a
 473                     ; 201         d2 = d2 - 10*q;
 475  008e ad48          	call	LC001
 476  0090 1007          	sub	a,(OFST-1,sp)
 477  0092 40            	neg	a
 478  0093 6b07          	ld	(OFST-1,sp),a
 480                     ; 203         d3 = q + 4*d3;
 482  0095 7b06          	ld	a,(OFST-2,sp)
 483  0097 48            	sll	a
 484  0098 48            	sll	a
 485  0099 1b08          	add	a,(OFST+0,sp)
 486  009b 6b06          	ld	(OFST-2,sp),a
 488                     ; 204         d4 = (d3 * 0x1A) >> 8;
 490  009d 97            	ld	xl,a
 491  009e a61a          	ld	a,#26
 492  00a0 42            	mul	x,a
 493  00a1 4f            	clr	a
 494  00a2 5d            	tnzw	x
 495  00a3 2a01          	jrpl	L02
 496  00a5 43            	cpl	a
 497  00a6               L02:
 498  00a6 97            	ld	xl,a
 499  00a7 5e            	swapw	x
 500  00a8 01            	rrwa	x,a
 501  00a9 6b08          	ld	(OFST+0,sp),a
 503                     ; 205         d3 = d3 - 10*d4;
 505  00ab ad2b          	call	LC001
 506  00ad 1006          	sub	a,(OFST-2,sp)
 507  00af 40            	neg	a
 508  00b0 6b06          	ld	(OFST-2,sp),a
 510                     ; 207 				ptr = buffer;
 513                     ; 208     *ptr++ = ( d4 + '0' );
 515  00b2 7b08          	ld	a,(OFST+0,sp)
 516  00b4 1e0d          	ldw	x,(OFST+5,sp)
 517  00b6 ad26          	call	LC002
 518                     ; 209     *ptr++ = ( d3 + '0' );
 520  00b8 7b06          	ld	a,(OFST-2,sp)
 521  00ba ad22          	call	LC002
 522                     ; 210     *ptr++ = ( d2 + '0' );
 524  00bc 7b07          	ld	a,(OFST-1,sp)
 525  00be ad1e          	call	LC002
 526                     ; 211     *ptr++ = ( d1 + '0' );
 528  00c0 7b05          	ld	a,(OFST-3,sp)
 529  00c2 ad1a          	call	LC002
 530                     ; 212     *ptr++ = ( d0 + '0' );
 532  00c4 7b02          	ld	a,(OFST-6,sp)
 533  00c6 ad16          	call	LC002
 534  00c8 1f03          	ldw	(OFST-5,sp),x
 535                     ; 213         *ptr = 0;
 537  00ca 7f            	clr	(x)
 539  00cb 1e0d          	ldw	x,(OFST+5,sp)
 540  00cd 2001          	jra	L514
 541  00cf               L114:
 542                     ; 215         while(buffer[0] == '0') ++buffer;
 544  00cf 5c            	incw	x
 545  00d0               L514:
 548  00d0 f6            	ld	a,(x)
 549  00d1 a130          	cp	a,#48
 550  00d3 27fa          	jreq	L114
 551                     ; 216         return buffer;
 555  00d5 5b0a          	addw	sp,#10
 556  00d7 81            	ret	
 557  00d8               LC001:
 558  00d8 97            	ld	xl,a
 559  00d9 a60a          	ld	a,#10
 560  00db 42            	mul	x,a
 561  00dc 9f            	ld	a,xl
 562  00dd 81            	ret	
 563  00de               LC002:
 564  00de ab30          	add	a,#48
 566  00e0 f7            	ld	(x),a
 567  00e1 5c            	incw	x
 568  00e2 81            	ret	
 643                     	switch	.const
 644  0060               L42:
 645  0060 000003e8      	dc.l	1000
 646                     ; 220 int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte, int nostop)
 646                     ; 221 {
 647                     .text:	section	.text,new
 648  0000               _I2C_writenbyte:
 650  0000 88            	push	a
 651  0001 5204          	subw	sp,#4
 652       00000004      OFST:	set	4
 655                     ; 223 	timeout = current_millis + 1000;
 657  0003 ae0018        	ldw	x,#_current_millis
 658  0006 cd0000        	call	c_ltor
 660  0009 ae0060        	ldw	x,#L42
 661  000c cd0000        	call	c_ladd
 663  000f 96            	ldw	x,sp
 664  0010 5c            	incw	x
 665  0011 cd0000        	call	c_rtol
 669  0014 200d          	jra	L364
 670  0016               L754:
 671                     ; 227 		if (current_millis>timeout) return 0;
 673  0016 ae0018        	ldw	x,#_current_millis
 674  0019 cd0000        	call	c_ltor
 676  001c 96            	ldw	x,sp
 677  001d 5c            	incw	x
 678  001e cd0000        	call	c_lcmp
 682  0021 221c          	jrugt	LC003
 683  0023               L364:
 684                     ; 225 	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
 686  0023 ae0302        	ldw	x,#770
 687  0026 cd0000        	call	_I2C_GetFlagStatus
 689  0029 4d            	tnz	a
 690  002a 26ea          	jrne	L754
 691                     ; 230 	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
 693  002c 72105211      	bset	21009,#0
 695  0030 2011          	jra	L374
 696  0032               L174:
 697                     ; 233 		if (current_millis>timeout) return 0;
 699  0032 ae0018        	ldw	x,#_current_millis
 700  0035 cd0000        	call	c_ltor
 702  0038 96            	ldw	x,sp
 703  0039 5c            	incw	x
 704  003a cd0000        	call	c_lcmp
 706  003d 2304          	jrule	L374
 709  003f               LC003:
 713  003f 5f            	clrw	x
 715  0040               L04:
 717  0040 5b05          	addw	sp,#5
 718  0042 81            	ret	
 719  0043               L374:
 720                     ; 231 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
 722  0043 ae0301        	ldw	x,#769
 723  0046 cd0000        	call	_I2C_CheckEvent
 725  0049 4d            	tnz	a
 726  004a 27e6          	jreq	L174
 727                     ; 236   I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
 729  004c 7b05          	ld	a,(OFST+1,sp)
 730  004e 48            	sll	a
 731  004f 5f            	clrw	x
 732  0050 95            	ld	xh,a
 733  0051 cd0000        	call	_I2C_Send7bitAddress
 736  0054 200d          	jra	L305
 737  0056               L105:
 738                     ; 239 		if (current_millis>timeout) return 0;
 740  0056 ae0018        	ldw	x,#_current_millis
 741  0059 cd0000        	call	c_ltor
 743  005c 96            	ldw	x,sp
 744  005d 5c            	incw	x
 745  005e cd0000        	call	c_lcmp
 749  0061 22dc          	jrugt	LC003
 750  0063               L305:
 751                     ; 237 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
 753  0063 ae0782        	ldw	x,#1922
 754  0066 cd0000        	call	_I2C_CheckEvent
 756  0069 4d            	tnz	a
 757  006a 27ea          	jreq	L105
 759  006c 2028          	jra	L315
 760  006e               L115:
 761                     ; 244 		I2C->DR = (uint8_t)*buff;//I2C_SendData((uint8_t)*buff);//ctrl meas
 763  006e 1e08          	ldw	x,(OFST+4,sp)
 764  0070 f6            	ld	a,(x)
 765  0071 c75216        	ld	21014,a
 767  0074 200d          	jra	L325
 768  0076               L715:
 769                     ; 247 			if (current_millis>timeout) return 0;
 771  0076 ae0018        	ldw	x,#_current_millis
 772  0079 cd0000        	call	c_ltor
 774  007c 96            	ldw	x,sp
 775  007d 5c            	incw	x
 776  007e cd0000        	call	c_lcmp
 780  0081 22bc          	jrugt	LC003
 781  0083               L325:
 782                     ; 245 		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
 784  0083 ae0104        	ldw	x,#260
 785  0086 cd0000        	call	_I2C_GetFlagStatus
 787  0089 4d            	tnz	a
 788  008a 27ea          	jreq	L715
 789                     ; 249 		*buff++;
 791  008c 1e08          	ldw	x,(OFST+4,sp)
 792  008e 5c            	incw	x
 793  008f 1f08          	ldw	(OFST+4,sp),x
 794                     ; 250 		nbyte--;
 796  0091 1e0a          	ldw	x,(OFST+6,sp)
 797  0093 5a            	decw	x
 798  0094 1f0a          	ldw	(OFST+6,sp),x
 799  0096               L315:
 800                     ; 242 	while (nbyte>0)
 802  0096 9c            	rvf	
 803  0097 1e0a          	ldw	x,(OFST+6,sp)
 804  0099 2cd3          	jrsgt	L115
 805                     ; 253 	if(nostop==0) 
 807  009b 1e0c          	ldw	x,(OFST+8,sp)
 808  009d 2604          	jrne	L135
 809                     ; 255 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
 811  009f 72125211      	bset	21009,#1
 812  00a3               L135:
 813                     ; 258 	return 1;
 815  00a3 ae0001        	ldw	x,#1
 817  00a6 2098          	jra	L04
 903                     ; 261 int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte,int nocheckbusy)
 903                     ; 262 {
 904                     .text:	section	.text,new
 905  0000               _I2C_readnbyte:
 907  0000 88            	push	a
 908  0001 5204          	subw	sp,#4
 909       00000004      OFST:	set	4
 912                     ; 264 	timeout = current_millis + 1000;
 914  0003 ae0018        	ldw	x,#_current_millis
 915  0006 cd0000        	call	c_ltor
 917  0009 ae0060        	ldw	x,#L42
 918  000c cd0000        	call	c_ladd
 920  000f 96            	ldw	x,sp
 921  0010 5c            	incw	x
 922  0011 cd0000        	call	c_rtol
 925                     ; 266 	if (nocheckbusy==0) 
 927  0014 1e0c          	ldw	x,(OFST+8,sp)
 928  0016 2618          	jrne	L175
 930  0018 200d          	jra	L575
 931  001a               L375:
 932                     ; 270 			if (current_millis>timeout) return 0;
 934  001a ae0018        	ldw	x,#_current_millis
 935  001d cd0000        	call	c_ltor
 937  0020 96            	ldw	x,sp
 938  0021 5c            	incw	x
 939  0022 cd0000        	call	c_lcmp
 943  0025 221c          	jrugt	LC004
 944  0027               L575:
 945                     ; 268 		while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
 947  0027 ae0302        	ldw	x,#770
 948  002a cd0000        	call	_I2C_GetFlagStatus
 950  002d 4d            	tnz	a
 951  002e 26ea          	jrne	L375
 952  0030               L175:
 953                     ; 274 	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
 955  0030 72105211      	bset	21009,#0
 957  0034 2011          	jra	L506
 958  0036               L306:
 959                     ; 277 		if (current_millis>timeout) return 0;
 961  0036 ae0018        	ldw	x,#_current_millis
 962  0039 cd0000        	call	c_ltor
 964  003c 96            	ldw	x,sp
 965  003d 5c            	incw	x
 966  003e cd0000        	call	c_lcmp
 968  0041 2304          	jrule	L506
 971  0043               LC004:
 984  0043 5f            	clrw	x
 986  0044               L601:
 988  0044 5b05          	addw	sp,#5
 989  0046 81            	ret	
 990  0047               L506:
 991                     ; 275 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
 993  0047 ae0301        	ldw	x,#769
 994  004a cd0000        	call	_I2C_CheckEvent
 996  004d 4d            	tnz	a
 997  004e 27e6          	jreq	L306
 998                     ; 280 	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
1000  0050 7b05          	ld	a,(OFST+1,sp)
1001  0052 48            	sll	a
1002  0053 ae0001        	ldw	x,#1
1003  0056 95            	ld	xh,a
1004  0057 cd0000        	call	_I2C_Send7bitAddress
1006                     ; 282 	if (nbyte >= 3) 
1008  005a 1e0a          	ldw	x,(OFST+6,sp)
1009  005c a30003        	cpw	x,#3
1010  005f 2e03cc0116    	jrslt	L316
1012  0064 200d          	jra	L716
1013  0066               L516:
1014                     ; 287 			if (current_millis>timeout) return 0;
1016  0066 ae0018        	ldw	x,#_current_millis
1017  0069 cd0000        	call	c_ltor
1019  006c 96            	ldw	x,sp
1020  006d 5c            	incw	x
1021  006e cd0000        	call	c_lcmp
1025  0071 22d0          	jrugt	LC004
1026  0073               L716:
1027                     ; 285 		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1029  0073 cd01ec        	call	LC005
1030  0076 27ee          	jreq	L516
1031                     ; 289 		disableInterrupts();
1034  0078 9b            	sim	
1036                     ; 290 		(void)I2C->SR3;
1039  0079 c65219        	ld	a,21017
1040                     ; 291 		enableInterrupts();
1043  007c 9a            	rim	
1047  007d 1e0a          	ldw	x,(OFST+6,sp)
1048  007f 2020          	jra	L726
1049  0081               L336:
1050                     ; 297 				if (current_millis>timeout) return 0;
1052  0081 ae0018        	ldw	x,#_current_millis
1053  0084 cd0000        	call	c_ltor
1055  0087 96            	ldw	x,sp
1056  0088 5c            	incw	x
1057  0089 cd0000        	call	c_lcmp
1061  008c 22b5          	jrugt	LC004
1062  008e               L536:
1063                     ; 295 			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1065  008e cd01f4        	call	LC006
1066  0091 27ee          	jreq	L336
1067                     ; 300 			*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1069  0093 1e08          	ldw	x,(OFST+4,sp)
1070  0095 c65216        	ld	a,21014
1071  0098 f7            	ld	(x),a
1072                     ; 301 			*buff++;
1074  0099 5c            	incw	x
1075  009a 1f08          	ldw	(OFST+4,sp),x
1076                     ; 302 			nbyte--;
1078  009c 1e0a          	ldw	x,(OFST+6,sp)
1079  009e 5a            	decw	x
1080  009f 1f0a          	ldw	(OFST+6,sp),x
1081  00a1               L726:
1082                     ; 293 		while  (nbyte > 3) {
1084  00a1 a30004        	cpw	x,#4
1085  00a4 2ee8          	jrsge	L536
1087  00a6 200d          	jra	L546
1088  00a8               L346:
1089                     ; 309 			if (current_millis>timeout) return 0;
1091  00a8 ae0018        	ldw	x,#_current_millis
1092  00ab cd0000        	call	c_ltor
1094  00ae 96            	ldw	x,sp
1095  00af 5c            	incw	x
1096  00b0 cd0000        	call	c_lcmp
1100  00b3 228e          	jrugt	LC004
1101  00b5               L546:
1102                     ; 307 		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1104  00b5 cd01f4        	call	LC006
1105  00b8 27ee          	jreq	L346
1106                     ; 312 		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);
1108  00ba 72155211      	bres	21009,#2
1109                     ; 313 		disableInterrupts();
1112  00be 9b            	sim	
1114                     ; 314 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1117  00bf 1e08          	ldw	x,(OFST+4,sp)
1118  00c1 c65216        	ld	a,21014
1119  00c4 f7            	ld	(x),a
1120                     ; 315 		*buff++;
1122  00c5 5c            	incw	x
1123  00c6 1f08          	ldw	(OFST+4,sp),x
1124                     ; 316 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1126  00c8 72125211      	bset	21009,#1
1127                     ; 317 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1129  00cc c65216        	ld	a,21014
1130  00cf f7            	ld	(x),a
1131                     ; 318 		enableInterrupts();
1134  00d0 9a            	rim	
1136                     ; 319 		*buff++;
1139  00d1 5c            	incw	x
1140  00d2 1f08          	ldw	(OFST+4,sp),x
1142  00d4 2010          	jra	L556
1143  00d6               L356:
1144                     ; 322 			if (current_millis>timeout) return 0;
1146  00d6 ae0018        	ldw	x,#_current_millis
1147  00d9 cd0000        	call	c_ltor
1149  00dc 96            	ldw	x,sp
1150  00dd 5c            	incw	x
1151  00de cd0000        	call	c_lcmp
1155  00e1 2303cc0043    	jrugt	LC004
1156  00e6               L556:
1157                     ; 320 		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
1159  00e6 ae0140        	ldw	x,#320
1160  00e9 cd0000        	call	_I2C_GetFlagStatus
1162  00ec 4d            	tnz	a
1163  00ed 27e7          	jreq	L356
1164                     ; 325 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();	
1166  00ef 1e08          	ldw	x,(OFST+4,sp)
1167  00f1 c65216        	ld	a,21014
1168  00f4 f7            	ld	(x),a
1169                     ; 326 		 nbyte=0;
1171  00f5 5f            	clrw	x
1172  00f6 1f0a          	ldw	(OFST+6,sp),x
1174  00f8 200d          	jra	L766
1175  00fa               L366:
1176                     ; 330 			if (current_millis>timeout) return 0;
1178  00fa ae0018        	ldw	x,#_current_millis
1179  00fd cd0000        	call	c_ltor
1181  0100 96            	ldw	x,sp
1182  0101 5c            	incw	x
1183  0102 cd0000        	call	c_lcmp
1187  0105 22dc          	jrugt	LC004
1188  0107               L766:
1189                     ; 328 		while(I2C->CR2 & I2C_CR2_STOP)
1191  0107 72025211ee    	btjt	21009,#1,L366
1192                     ; 335     I2C->CR2 |= I2C_CR2_ACK;
1194  010c 72145211      	bset	21009,#2
1195                     ; 336 		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
1197  0110 72175211      	bres	21009,#3
1198  0114 1e0a          	ldw	x,(OFST+6,sp)
1199  0116               L316:
1200                     ; 341 	if (nbyte == 2) 
1202  0116 a30002        	cpw	x,#2
1203  0119 266b          	jrne	L576
1204                     ; 343 		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
1206  011b a602          	ld	a,#2
1207  011d cd0000        	call	_I2C_AcknowledgeConfig
1210  0120 200d          	jra	L107
1211  0122               L776:
1212                     ; 347 			if (current_millis>timeout) return 0;
1214  0122 ae0018        	ldw	x,#_current_millis
1215  0125 cd0000        	call	c_ltor
1217  0128 96            	ldw	x,sp
1218  0129 5c            	incw	x
1219  012a cd0000        	call	c_lcmp
1223  012d 22b4          	jrugt	LC004
1224  012f               L107:
1225                     ; 345 		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1227  012f cd01ec        	call	LC005
1228  0132 27ee          	jreq	L776
1229                     ; 349 		(void)I2C->SR3;
1231  0134 c65219        	ld	a,21017
1232                     ; 350 		I2C_AcknowledgeConfig(I2C_ACK_NONE);
1234  0137 4f            	clr	a
1235  0138 cd0000        	call	_I2C_AcknowledgeConfig
1238  013b 200d          	jra	L117
1239  013d               L707:
1240                     ; 354 			if (current_millis>timeout) return 0;
1242  013d ae0018        	ldw	x,#_current_millis
1243  0140 cd0000        	call	c_ltor
1245  0143 96            	ldw	x,sp
1246  0144 5c            	incw	x
1247  0145 cd0000        	call	c_lcmp
1251  0148 2299          	jrugt	LC004
1252  014a               L117:
1253                     ; 352 		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1255  014a cd01f4        	call	LC006
1256  014d 27ee          	jreq	L707
1257                     ; 357 		disableInterrupts();
1260  014f 9b            	sim	
1262                     ; 358 		I2C_GenerateSTOP(ENABLE);
1265  0150 a601          	ld	a,#1
1266  0152 cd0000        	call	_I2C_GenerateSTOP
1268                     ; 359 		*buff= I2C_ReceiveData();
1270  0155 cd0000        	call	_I2C_ReceiveData
1272  0158 1e08          	ldw	x,(OFST+4,sp)
1273  015a f7            	ld	(x),a
1274                     ; 360 		enableInterrupts();
1277  015b 9a            	rim	
1279                     ; 362 		*buff++;  
1282  015c 5c            	incw	x
1283  015d 1f08          	ldw	(OFST+4,sp),x
1284                     ; 363 		*buff= I2C_ReceiveData();
1286  015f cd0000        	call	_I2C_ReceiveData
1288  0162 1e08          	ldw	x,(OFST+4,sp)
1289  0164 f7            	ld	(x),a
1290                     ; 364 		nbyte=0; 
1292  0165 5f            	clrw	x
1293  0166 1f0a          	ldw	(OFST+6,sp),x
1295  0168 2010          	jra	L327
1296  016a               L717:
1297                     ; 368 			if (current_millis>timeout) return 0;
1299  016a ae0018        	ldw	x,#_current_millis
1300  016d cd0000        	call	c_ltor
1302  0170 96            	ldw	x,sp
1303  0171 5c            	incw	x
1304  0172 cd0000        	call	c_lcmp
1308  0175 2303cc0043    	jrugt	LC004
1309  017a               L327:
1310                     ; 366 		while(I2C->CR2 & I2C_CR2_STOP)
1312  017a 72025211eb    	btjt	21009,#1,L717
1313                     ; 373     I2C_AcknowledgeConfig( I2C_ACK_CURR);
1315  017f a601          	ld	a,#1
1316  0181 cd0000        	call	_I2C_AcknowledgeConfig
1318  0184 1e0a          	ldw	x,(OFST+6,sp)
1319  0186               L576:
1320                     ; 377 	if (nbyte == 1) 
1322  0186 5a            	decw	x
1323  0187 265d          	jrne	L137
1324                     ; 379 		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);   
1326  0189 72155211      	bres	21009,#2
1328  018d 200d          	jra	L537
1329  018f               L337:
1330                     ; 383 			if (current_millis>timeout) return 0;
1332  018f ae0018        	ldw	x,#_current_millis
1333  0192 cd0000        	call	c_ltor
1335  0195 96            	ldw	x,sp
1336  0196 5c            	incw	x
1337  0197 cd0000        	call	c_lcmp
1341  019a 22db          	jrugt	LC004
1342  019c               L537:
1343                     ; 381 		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1345  019c ad4e          	call	LC005
1346  019e 27ef          	jreq	L337
1347                     ; 386 		disableInterrupts();
1350  01a0 9b            	sim	
1352                     ; 389     (void)I2C->SR3;
1355  01a1 c65219        	ld	a,21017
1356                     ; 392     I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP( ENABLE);
1358  01a4 72125211      	bset	21009,#1
1359                     ; 395     enableInterrupts();
1362  01a8 9a            	rim	
1366  01a9 200d          	jra	L547
1367  01ab               L347:
1368                     ; 400 			if (current_millis>timeout) return 0;
1370  01ab ae0018        	ldw	x,#_current_millis
1371  01ae cd0000        	call	c_ltor
1373  01b1 96            	ldw	x,sp
1374  01b2 5c            	incw	x
1375  01b3 cd0000        	call	c_lcmp
1379  01b6 22bf          	jrugt	LC004
1380  01b8               L547:
1381                     ; 398     while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
1383  01b8 ae0140        	ldw	x,#320
1384  01bb cd0000        	call	_I2C_GetFlagStatus
1386  01be 4d            	tnz	a
1387  01bf 27ea          	jreq	L347
1388                     ; 405     *buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1390  01c1 1e08          	ldw	x,(OFST+4,sp)
1391  01c3 c65216        	ld	a,21014
1392  01c6 f7            	ld	(x),a
1393                     ; 408 		nbyte=0;
1395  01c7 5f            	clrw	x
1396  01c8 1f0a          	ldw	(OFST+6,sp),x
1398  01ca 200d          	jra	L757
1399  01cc               L357:
1400                     ; 413 			if (current_millis>timeout) return 0;
1402  01cc ae0018        	ldw	x,#_current_millis
1403  01cf cd0000        	call	c_ltor
1405  01d2 96            	ldw	x,sp
1406  01d3 5c            	incw	x
1407  01d4 cd0000        	call	c_lcmp
1411  01d7 229e          	jrugt	LC004
1412  01d9               L757:
1413                     ; 411     while(I2C->CR2 & I2C_CR2_STOP)
1415  01d9 72025211ee    	btjt	21009,#1,L357
1416                     ; 418     I2C->CR2 |= I2C_CR2_ACK;
1418  01de 72145211      	bset	21009,#2
1419                     ; 419 		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
1421  01e2 72175211      	bres	21009,#3
1422  01e6               L137:
1423                     ; 422 	return 1;
1425  01e6 ae0001        	ldw	x,#1
1427  01e9 cc0044        	jra	L601
1428  01ec               LC005:
1429  01ec ae0102        	ldw	x,#258
1430  01ef cd0000        	call	_I2C_GetFlagStatus
1432  01f2 4d            	tnz	a
1433  01f3 81            	ret	
1434  01f4               LC006:
1435  01f4 ae0104        	ldw	x,#260
1436  01f7 cd0000        	call	_I2C_GetFlagStatus
1438  01fa 4d            	tnz	a
1439  01fb 81            	ret	
1464                     ; 425 int nctinit(void)
1464                     ; 426 {
1465                     .text:	section	.text,new
1466  0000               _nctinit:
1470                     ; 429 		buff[0] = (uint8_t) 0b1;
1472  0000 35010020      	mov	_buff,#1
1473                     ; 430 		buff[1] = (uint8_t) 0b100000;//config reg one shot!
1475  0004 35200021      	mov	_buff+1,#32
1476                     ; 432 		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
1478  0008 5f            	clrw	x
1479  0009 89            	pushw	x
1480  000a ae0002        	ldw	x,#2
1481  000d 89            	pushw	x
1482  000e ae0020        	ldw	x,#_buff
1483  0011 89            	pushw	x
1484  0012 a648          	ld	a,#72
1485  0014 cd0000        	call	_I2C_writenbyte
1487  0017 5b06          	addw	sp,#6
1488  0019 5d            	tnzw	x
1489  001a 2606          	jrne	L577
1490                     ; 434 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1492  001c 72125211      	bset	21009,#1
1493                     ; 435 			return 0;
1495  0020 5f            	clrw	x
1498  0021 81            	ret	
1499  0022               L577:
1500                     ; 439 		return 1;
1503  0022 ae0001        	ldw	x,#1
1506  0025 81            	ret	
1546                     	switch	.const
1547  0064               L031:
1548  0064 00000271      	dc.l	625
1549  0068               L231:
1550  0068 00000064      	dc.l	100
1551                     ; 442 int nctdata(void)
1551                     ; 443 {
1552                     .text:	section	.text,new
1553  0000               _nctdata:
1555  0000 5208          	subw	sp,#8
1556       00000008      OFST:	set	8
1559                     ; 446 		buff[0] = (uint8_t) 0x4;
1561  0002 35040020      	mov	_buff,#4
1562                     ; 447 		buff[1] = (uint8_t) 0;
1564  0006 3f21          	clr	_buff+1
1565                     ; 449 		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
1567  0008 5f            	clrw	x
1568  0009 89            	pushw	x
1569  000a ae0002        	ldw	x,#2
1570  000d 89            	pushw	x
1571  000e ae0020        	ldw	x,#_buff
1572  0011 89            	pushw	x
1573  0012 a648          	ld	a,#72
1574  0014 cd0000        	call	_I2C_writenbyte
1576  0017 5b06          	addw	sp,#6
1577  0019 5d            	tnzw	x
1578  001a 2606          	jrne	L5101
1579                     ; 451 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1581  001c 72125211      	bset	21009,#1
1582                     ; 452 			return 0;
1584  0020 201f          	jp	LC007
1585  0022               L5101:
1586                     ; 454 		Delay(90);
1589  0022 ae005a        	ldw	x,#90
1590  0025 cd0000        	call	_Delay
1592                     ; 456 		buff[0] = (uint8_t) 0x00;
1594  0028 3f20          	clr	_buff
1595                     ; 457 		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
1597  002a 5f            	clrw	x
1598  002b 89            	pushw	x
1599  002c 5c            	incw	x
1600  002d 89            	pushw	x
1601  002e ae0020        	ldw	x,#_buff
1602  0031 89            	pushw	x
1603  0032 a648          	ld	a,#72
1604  0034 cd0000        	call	_I2C_writenbyte
1606  0037 5b06          	addw	sp,#6
1607  0039 5d            	tnzw	x
1608  003a 2609          	jrne	L7101
1609                     ; 459 			I2C_GenerateSTOP(ENABLE);
1611  003c a601          	ld	a,#1
1612  003e cd0000        	call	_I2C_GenerateSTOP
1614                     ; 460 			return 0;
1616  0041               LC007:
1619  0041 5f            	clrw	x
1621  0042               L431:
1623  0042 5b08          	addw	sp,#8
1624  0044 81            	ret	
1625  0045               L7101:
1626                     ; 463 		if (! I2C_readnbyte((uint8_t)NCTaddr, buff, 2,0) ) 
1629  0045 5f            	clrw	x
1630  0046 89            	pushw	x
1631  0047 ae0002        	ldw	x,#2
1632  004a 89            	pushw	x
1633  004b ae0020        	ldw	x,#_buff
1634  004e 89            	pushw	x
1635  004f a648          	ld	a,#72
1636  0051 cd0000        	call	_I2C_readnbyte
1638  0054 5b06          	addw	sp,#6
1639  0056 5d            	tnzw	x
1640                     ; 465 			return 0;
1642  0057 27e8          	jreq	LC007
1643                     ; 468 		tmcpT = (u32) (buff[0]<<8) | buff[1];
1646  0059 452103        	mov	c_lreg+3,_buff+1
1647  005c 3f02          	clr	c_lreg+2
1648  005e 3f01          	clr	c_lreg+1
1649  0060 3f00          	clr	c_lreg
1650  0062 96            	ldw	x,sp
1651  0063 5c            	incw	x
1652  0064 cd0000        	call	c_rtol
1655  0067 b620          	ld	a,_buff
1656  0069 97            	ld	xl,a
1657  006a 4f            	clr	a
1658  006b 02            	rlwa	x,a
1659  006c cd0000        	call	c_itolx
1661  006f 96            	ldw	x,sp
1662  0070 5c            	incw	x
1663  0071 cd0000        	call	c_lor
1665  0074 96            	ldw	x,sp
1666  0075 1c0005        	addw	x,#OFST-3
1667  0078 cd0000        	call	c_rtol
1670                     ; 469 		bmeT = (tmcpT>>4) * 625 / 100;
1672  007b 96            	ldw	x,sp
1673  007c 1c0005        	addw	x,#OFST-3
1674  007f cd0000        	call	c_ltor
1676  0082 a604          	ld	a,#4
1677  0084 cd0000        	call	c_lrsh
1679  0087 ae0064        	ldw	x,#L031
1680  008a cd0000        	call	c_lmul
1682  008d ae0068        	ldw	x,#L231
1683  0090 cd0000        	call	c_ldiv
1685  0093 ae0014        	ldw	x,#_bmeT
1686  0096 cd0000        	call	c_rtol
1688                     ; 471 		return 1;
1690  0099 ae0001        	ldw	x,#1
1692  009c 20a4          	jra	L431
1717                     ; 475 int uvinit(void)
1717                     ; 476 {
1718                     .text:	section	.text,new
1719  0000               _uvinit:
1723                     ; 478 		buff[0] = (uint8_t) 0b0;//config reg
1725  0000 3f20          	clr	_buff
1726                     ; 479 		buff[1] = (uint8_t) 0b01000000;//low byte 400ms
1728  0002 35400021      	mov	_buff+1,#64
1729                     ; 480 		buff[2] = (uint8_t) 0b0;//high byte
1731  0006 3f22          	clr	_buff+2
1732                     ; 481 		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
1734  0008 5f            	clrw	x
1735  0009 89            	pushw	x
1736  000a ae0003        	ldw	x,#3
1737  000d 89            	pushw	x
1738  000e ae0020        	ldw	x,#_buff
1739  0011 89            	pushw	x
1740  0012 a610          	ld	a,#16
1741  0014 cd0000        	call	_I2C_writenbyte
1743  0017 5b06          	addw	sp,#6
1744  0019 5d            	tnzw	x
1745  001a 2606          	jrne	L3301
1746                     ; 483 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1748  001c 72125211      	bset	21009,#1
1749                     ; 484 			return 0;
1751  0020 5f            	clrw	x
1754  0021 81            	ret	
1755  0022               L3301:
1756                     ; 489 		return 1;
1759  0022 ae0001        	ldw	x,#1
1762  0025 81            	ret	
1800                     ; 492 u16 readUVword(u8 addr) {
1801                     .text:	section	.text,new
1802  0000               _readUVword:
1806                     ; 493 		buff[0] = addr;//(uint8_t) 0x07;//uva
1808  0000 b720          	ld	_buff,a
1809                     ; 494 		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 1,1) ) 
1811  0002 ae0001        	ldw	x,#1
1812  0005 89            	pushw	x
1813  0006 89            	pushw	x
1814  0007 ae0020        	ldw	x,#_buff
1815  000a 89            	pushw	x
1816  000b a610          	ld	a,#16
1817  000d cd0000        	call	_I2C_writenbyte
1819  0010 5b06          	addw	sp,#6
1820  0012 5d            	tnzw	x
1821  0013 2607          	jrne	L3501
1822                     ; 496 			I2C_GenerateSTOP(ENABLE);
1824  0015 a601          	ld	a,#1
1825  0017 cd0000        	call	_I2C_GenerateSTOP
1827                     ; 497 			return 0;
1829  001a 5f            	clrw	x
1832  001b 81            	ret	
1833  001c               L3501:
1834                     ; 500 		if (! I2C_readnbyte((uint8_t)UVaddr, buff, 2,1) ) 
1837  001c ae0001        	ldw	x,#1
1838  001f 89            	pushw	x
1839  0020 5c            	incw	x
1840  0021 89            	pushw	x
1841  0022 ae0020        	ldw	x,#_buff
1842  0025 89            	pushw	x
1843  0026 a610          	ld	a,#16
1844  0028 cd0000        	call	_I2C_readnbyte
1846  002b 5b06          	addw	sp,#6
1847  002d 5d            	tnzw	x
1848  002e 2602          	jrne	L5501
1849                     ; 502 			return 0;
1851  0030 5f            	clrw	x
1854  0031 81            	ret	
1855  0032               L5501:
1856                     ; 505 		return (u16) ((buff[1]<<8) | buff[0]);
1859  0032 b621          	ld	a,_buff+1
1860  0034 97            	ld	xl,a
1861  0035 b620          	ld	a,_buff
1862  0037 02            	rlwa	x,a
1865  0038 81            	ret	
1914                     ; 518 int uvdata(void)
1914                     ; 519 {
1915                     .text:	section	.text,new
1916  0000               _uvdata:
1918  0000 5210          	subw	sp,#16
1919       00000010      OFST:	set	16
1922                     ; 524 		uva = readUVword(0x07);
1924  0002 a607          	ld	a,#7
1925  0004 cd0000        	call	_readUVword
1927  0007 bf12          	ldw	_uva,x
1928                     ; 526 		uvb = readUVword(0x09);
1930  0009 a609          	ld	a,#9
1931  000b cd0000        	call	_readUVword
1933  000e bf10          	ldw	_uvb,x
1934                     ; 527 		uvcomp1 = readUVword(0x0A);
1936  0010 a60a          	ld	a,#10
1937  0012 cd0000        	call	_readUVword
1939  0015 bf0e          	ldw	_uvcomp1,x
1940                     ; 528 		uvcomp2 = readUVword(0x0B);
1942  0017 a60b          	ld	a,#11
1943  0019 cd0000        	call	_readUVword
1945  001c bf0c          	ldw	_uvcomp2,x
1946                     ; 545 		uvia = ((uva-UKa*uvcomp1-UKb*uvcomp2)*0.001461);//for 100ms
1948  001e cd0000        	call	c_uitof
1950  0021 ae00bc        	ldw	x,#L5111
1951  0024 cd0000        	call	c_fmul
1953  0027 96            	ldw	x,sp
1954  0028 cd00c1        	call	LC008
1956  002b ae00c0        	ldw	x,#L5011
1957  002e cd0000        	call	c_fmul
1959  0031 96            	ldw	x,sp
1960  0032 5c            	incw	x
1961  0033 cd0000        	call	c_rtol
1964  0036 be12          	ldw	x,_uva
1965  0038 cd0000        	call	c_uitof
1967  003b 96            	ldw	x,sp
1968  003c 5c            	incw	x
1969  003d cd0000        	call	c_fsub
1971  0040 96            	ldw	x,sp
1972  0041 1c0005        	addw	x,#OFST-11
1973  0044 cd0000        	call	c_fsub
1975  0047 ae00b8        	ldw	x,#L5211
1976  004a cd0000        	call	c_fmul
1978  004d 96            	ldw	x,sp
1979  004e 1c0009        	addw	x,#OFST-7
1980  0051 cd0000        	call	c_rtol
1983                     ; 546 		uvib = ((uvb-UKc*uvcomp1-UKd*uvcomp2)*0.002591);
1985  0054 be0c          	ldw	x,_uvcomp2
1986  0056 cd0000        	call	c_uitof
1988  0059 ae00b0        	ldw	x,#L5411
1989  005c cd0000        	call	c_fmul
1991  005f 96            	ldw	x,sp
1992  0060 ad5f          	call	LC008
1994  0062 ae00b4        	ldw	x,#L5311
1995  0065 cd0000        	call	c_fmul
1997  0068 96            	ldw	x,sp
1998  0069 5c            	incw	x
1999  006a cd0000        	call	c_rtol
2002  006d be10          	ldw	x,_uvb
2003  006f cd0000        	call	c_uitof
2005  0072 96            	ldw	x,sp
2006  0073 5c            	incw	x
2007  0074 cd0000        	call	c_fsub
2009  0077 96            	ldw	x,sp
2010  0078 1c0005        	addw	x,#OFST-11
2011  007b cd0000        	call	c_fsub
2013  007e ae00ac        	ldw	x,#L5511
2014  0081 cd0000        	call	c_fmul
2016  0084 96            	ldw	x,sp
2017  0085 1c000d        	addw	x,#OFST-3
2018  0088 cd0000        	call	c_rtol
2021                     ; 551 		if (uvia<0 || uvib<0) uindex=0;
2023  008b 7b09          	ld	a,(OFST-7,sp)
2024  008d 2b04          	jrmi	L3611
2026  008f 7b0d          	ld	a,(OFST-3,sp)
2027  0091 2a09          	jrpl	L1611
2028  0093               L3611:
2031  0093 5f            	clrw	x
2033  0094               L5611:
2034  0094 bf1e          	ldw	_uindex,x
2035                     ; 554 		return 1;
2037  0096 ae0001        	ldw	x,#1
2040  0099 5b10          	addw	sp,#16
2041  009b 81            	ret	
2042  009c               L1611:
2043                     ; 552 		else uindex = (uvia+uvib)*100/2/6;//800ms!!
2045  009c 96            	ldw	x,sp
2046  009d 1c0009        	addw	x,#OFST-7
2047  00a0 cd0000        	call	c_ltor
2049  00a3 96            	ldw	x,sp
2050  00a4 1c000d        	addw	x,#OFST-3
2051  00a7 cd0000        	call	c_fadd
2053  00aa ae00a8        	ldw	x,#L3711
2054  00ad cd0000        	call	c_fmul
2056  00b0 ae00a4        	ldw	x,#L3021
2057  00b3 cd0000        	call	c_fdiv
2059  00b6 ae00a0        	ldw	x,#L3121
2060  00b9 cd0000        	call	c_fdiv
2062  00bc cd0000        	call	c_ftoi
2064  00bf 20d3          	jra	L5611
2065  00c1               LC008:
2066  00c1 1c0005        	addw	x,#OFST-11
2067  00c4 cd0000        	call	c_rtol
2070  00c7 be0e          	ldw	x,_uvcomp1
2071  00c9 cc0000        	jp	c_uitof
2123                     ; 558 double mypow(double a,int b) {
2124                     .text:	section	.text,new
2125  0000               _mypow:
2127  0000 5204          	subw	sp,#4
2128       00000004      OFST:	set	4
2131                     ; 561 		double x=a;
2133  0002 1e09          	ldw	x,(OFST+5,sp)
2134  0004 1f03          	ldw	(OFST-1,sp),x
2135  0006 1e07          	ldw	x,(OFST+3,sp)
2136  0008 1f01          	ldw	(OFST-3,sp),x
2138                     ; 562 		if (b==1) return a;
2140  000a 1e0b          	ldw	x,(OFST+7,sp)
2141  000c a30001        	cpw	x,#1
2142  000f 2613          	jrne	L1521
2145  0011 96            	ldw	x,sp
2146  0012 1c0007        	addw	x,#OFST+3
2149  0015 2016          	jra	L661
2150  0017               L7421:
2151                     ; 566 			x *= a;
2153  0017 1c0007        	addw	x,#OFST+3
2154  001a cd0000        	call	c_ltor
2156  001d 96            	ldw	x,sp
2157  001e 5c            	incw	x
2158  001f cd0000        	call	c_fgmul
2161  0022 1e0b          	ldw	x,(OFST+7,sp)
2162  0024               L1521:
2163                     ; 564 		while (b--) 
2165  0024 5a            	decw	x
2166  0025 1f0b          	ldw	(OFST+7,sp),x
2167  0027 96            	ldw	x,sp
2168  0028 26ed          	jrne	L7421
2169                     ; 569 		return x;
2171  002a 1c0001        	addw	x,#OFST-3
2174  002d               L661:
2175  002d cd0000        	call	c_ltor
2177  0030 5b04          	addw	sp,#4
2178  0032 81            	ret	
2203                     ; 572 int mcpinit(void)
2203                     ; 573 {
2204                     .text:	section	.text,new
2205  0000               _mcpinit:
2209                     ; 575 		buff[0] = (uint8_t) 0b00011100;
2211  0000 351c0020      	mov	_buff,#28
2212                     ; 576 		if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 2,0) ) 
2214  0004 5f            	clrw	x
2215  0005 89            	pushw	x
2216  0006 ae0002        	ldw	x,#2
2217  0009 89            	pushw	x
2218  000a ae0020        	ldw	x,#_buff
2219  000d 89            	pushw	x
2220  000e a668          	ld	a,#104
2221  0010 cd0000        	call	_I2C_writenbyte
2223  0013 5b06          	addw	sp,#6
2224  0015 5d            	tnzw	x
2225  0016 2606          	jrne	L5621
2226                     ; 578 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
2228  0018 72125211      	bset	21009,#1
2229                     ; 579 			return 0;
2231  001c 5f            	clrw	x
2234  001d 81            	ret	
2235  001e               L5621:
2236                     ; 583 		return 1;
2239  001e ae0001        	ldw	x,#1
2242  0021 81            	ret	
2245                     	bsct
2246  0028               _esr_stage:
2247  0028 00            	dc.b	0
2248  0029               _esr_time:
2249  0029 00            	dc.b	0
2250  002a               _esr_u1:
2251  002a 00000000      	dc.l	0
2356                     	switch	.const
2357  006c               L002:
2358  006c 00000100      	dc.l	256
2359  0070               L202:
2360  0070 00000008      	dc.l	8
2361  0074               L602:
2362  0074 000000c8      	dc.l	200
2363  0078               L012:
2364  0078 000000c9      	dc.l	201
2365  007c               L212:
2366  007c 0001adb0      	dc.l	110000
2367  0080               L412:
2368  0080 00011800      	dc.l	71680
2369                     ; 593 int mcpdata(void)
2369                     ; 594 {
2370                     .text:	section	.text,new
2371  0000               _mcpdata:
2373  0000 5214          	subw	sp,#20
2374       00000014      OFST:	set	20
2377                     ; 599 		if (! I2C_readnbyte((uint8_t)MCPaddr, buff, 4,0) ) return 0;		
2379  0002 5f            	clrw	x
2380  0003 89            	pushw	x
2381  0004 ae0004        	ldw	x,#4
2382  0007 89            	pushw	x
2383  0008 ae0020        	ldw	x,#_buff
2384  000b 89            	pushw	x
2385  000c a668          	ld	a,#104
2386  000e cd0000        	call	_I2C_readnbyte
2388  0011 5b06          	addw	sp,#6
2389  0013 5d            	tnzw	x
2392  0014 2603cc0331    	jreq	LC010
2393                     ; 601 		tmcpT = ((long)buff[0]<<24) + ((long)buff[1]<<16) + ((long)buff[2]<<8);
2395  0019 b622          	ld	a,_buff+2
2396  001b 5f            	clrw	x
2397  001c 97            	ld	xl,a
2398  001d 90ae0100      	ldw	y,#256
2399  0021 cd0000        	call	c_umul
2401  0024 96            	ldw	x,sp
2402  0025 1c0005        	addw	x,#OFST-15
2403  0028 cd0000        	call	c_rtol
2406  002b 452103        	mov	c_lreg+3,_buff+1
2407  002e 3f02          	clr	c_lreg+2
2408  0030 3f01          	clr	c_lreg+1
2409  0032 3f00          	clr	c_lreg
2410  0034 a610          	ld	a,#16
2411  0036 cd0000        	call	c_llsh
2413  0039 96            	ldw	x,sp
2414  003a 5c            	incw	x
2415  003b cd0000        	call	c_rtol
2418  003e 452003        	mov	c_lreg+3,_buff
2419  0041 3f02          	clr	c_lreg+2
2420  0043 3f01          	clr	c_lreg+1
2421  0045 3f00          	clr	c_lreg
2422  0047 a618          	ld	a,#24
2423  0049 cd0000        	call	c_llsh
2425  004c 96            	ldw	x,sp
2426  004d 5c            	incw	x
2427  004e cd0000        	call	c_ladd
2429  0051 96            	ldw	x,sp
2430  0052 1c0005        	addw	x,#OFST-15
2431  0055 cd042d        	call	LC013
2433                     ; 602 		tmcpT/=256;
2435  0058 cd0000        	call	c_ltor
2437  005b ae006c        	ldw	x,#L002
2438  005e cd0000        	call	c_ldiv
2440  0061 ae0000        	ldw	x,#_tmcpT
2441  0064 cd0000        	call	c_rtol
2443                     ; 604 		e = (double) tmcpT/64;//512; //* 15.625/8000;//в миливольтах
2445  0067 cd0000        	call	c_ltor
2447  006a cd0000        	call	c_ltof
2449  006d ae009c        	ldw	x,#L3431
2450  0070 cd0000        	call	c_fdiv
2452  0073 96            	ldw	x,sp
2453  0074 1c0011        	addw	x,#OFST-3
2454  0077 cd0000        	call	c_rtol
2457                     ; 606 		if (rezhim==6) {
2459  007a b617          	ld	a,_rezhim
2460  007c a106          	cp	a,#6
2461  007e 2638          	jrne	L7431
2462                     ; 610 			if (tmcpT<0) tmcpT=-tmcpT;
2464  0080 720f000006    	btjf	_tmcpT,#7,L1531
2467  0085 ae0000        	ldw	x,#_tmcpT
2468  0088 cd0000        	call	c_lgneg
2470  008b               L1531:
2471                     ; 612 			r = tmcpT*10/8;//10000/64/125//r=u/i
2473  008b ae0000        	ldw	x,#_tmcpT
2474  008e cd0000        	call	c_ltor
2476  0091 a60a          	ld	a,#10
2477  0093 cd0000        	call	c_smul
2479  0096 ae0070        	ldw	x,#L202
2480  0099 cd0000        	call	c_ldiv
2482  009c 96            	ldw	x,sp
2483  009d 1c000b        	addw	x,#OFST-9
2484  00a0 cd0000        	call	c_rtol
2487                     ; 617 			if (r > 999) r=999;
2489  00a3 96            	ldw	x,sp
2490  00a4 cd0421        	call	LC012
2492  00a7 2f08          	jrslt	L3531
2495  00a9 ae03e7        	ldw	x,#999
2496  00ac 1f0d          	ldw	(OFST-7,sp),x
2497  00ae 5f            	clrw	x
2498  00af 1f0b          	ldw	(OFST-9,sp),x
2500  00b1               L3531:
2501                     ; 618 			shownumber(r);
2503  00b1 1e0d          	ldw	x,(OFST-7,sp)
2504  00b3 cd0000        	call	_shownumber
2506  00b6 b617          	ld	a,_rezhim
2507  00b8               L7431:
2508                     ; 621 		if (rezhim==5) {
2510  00b8 a105          	cp	a,#5
2511  00ba 2703cc01d3    	jrne	L5531
2512                     ; 624 			if (tmcpT<0) tmcpT=-tmcpT;
2514  00bf 720f000006    	btjf	_tmcpT,#7,L7531
2517  00c4 ae0000        	ldw	x,#_tmcpT
2518  00c7 cd0000        	call	c_lgneg
2520  00ca               L7531:
2521                     ; 626 			if (esr_stage) sleeptime=60;
2523  00ca b628          	ld	a,_esr_stage
2524  00cc 2705          	jreq	L1631
2527  00ce ae003c        	ldw	x,#60
2528  00d1 bf13          	ldw	_sleeptime,x
2529  00d3               L1631:
2530                     ; 628 			if ((esr_stage==0)&&(tmcpT< 200)) {
2532  00d3 b628          	ld	a,_esr_stage
2533  00d5 2612          	jrne	L3631
2535  00d7 cd0415        	call	LC011
2537  00da 2e0d          	jrsge	L3631
2538                     ; 629 				esr_stage=0;
2540  00dc 3f28          	clr	_esr_stage
2541                     ; 630 				ind[0]=4;
2543  00de 35040001      	mov	_ind,#4
2544                     ; 631 				ind[1]=0;
2546  00e2 3f02          	clr	_ind+1
2547                     ; 632 				ind[2]=0;
2549  00e4 3f03          	clr	_ind+2
2551  00e6 cc01d3        	jra	L5531
2552  00e9               L3631:
2553                     ; 634 			else if (esr_stage==0) {
2555  00e9 b628          	ld	a,_esr_stage
2556  00eb 260f          	jrne	L7631
2557                     ; 635 				esr_time = 20;
2559  00ed 35140029      	mov	_esr_time,#20
2560                     ; 636 				esr_stage=1;
2562  00f1 35010028      	mov	_esr_stage,#1
2563                     ; 637 				ind[0]=1;
2565  00f5 35010001      	mov	_ind,#1
2567  00f9 cc01d3        	jra	L5531
2568  00fc               L7631:
2569                     ; 639 			else if ((esr_stage==1)&&(esr_time)) {
2571  00fc 4a            	dec	a
2572  00fd 2618          	jrne	L3731
2574  00ff b629          	ld	a,_esr_time
2575  0101 2714          	jreq	L3731
2576                     ; 640 				ind[1]=esr_time/10;
2578  0103 5f            	clrw	x
2579  0104 97            	ld	xl,a
2580  0105 a60a          	ld	a,#10
2581  0107 62            	div	x,a
2582  0108 9f            	ld	a,xl
2583  0109 b702          	ld	_ind+1,a
2584                     ; 641 				ind[2]=esr_time-ind[1]*10;
2586  010b a60a          	ld	a,#10
2587  010d 42            	mul	x,a
2588  010e 9f            	ld	a,xl
2589  010f b029          	sub	a,_esr_time
2590  0111 40            	neg	a
2591  0112 b703          	ld	_ind+2,a
2593  0114 cc01d3        	jra	L5531
2594  0117               L3731:
2595                     ; 643 			else if ((esr_stage==1)&&(esr_time==0)) {
2597  0117 b628          	ld	a,_esr_stage
2598  0119 a101          	cp	a,#1
2599  011b 261f          	jrne	L7731
2601  011d 3d29          	tnz	_esr_time
2602  011f 261b          	jrne	L7731
2603                     ; 644 				esr_stage=2;
2605  0121 35020028      	mov	_esr_stage,#2
2606                     ; 645 				u1 = tmcpT;
2608  0125 be02          	ldw	x,_tmcpT+2
2609  0127 bf0a          	ldw	_u1+2,x
2610  0129 be00          	ldw	x,_tmcpT
2611  012b bf08          	ldw	_u1,x
2612                     ; 646 				esr_u1=tmcpT;
2614  012d be02          	ldw	x,_tmcpT+2
2615  012f bf2c          	ldw	_esr_u1+2,x
2616  0131 be00          	ldw	x,_tmcpT
2617  0133 bf2a          	ldw	_esr_u1,x
2618                     ; 647 				ind[0]=2;
2620  0135 35020001      	mov	_ind,#2
2622  0139 cc01d3        	jra	L5531
2623  013c               L7731:
2624                     ; 649 			else if ((esr_stage==2)&&(tmcpT <200)) {
2626  013c a102          	cp	a,#2
2627  013e 2614          	jrne	L3041
2629  0140 cd0415        	call	LC011
2631  0143 2e0f          	jrsge	L3041
2632                     ; 650 				esr_stage=3;
2634  0145 35030028      	mov	_esr_stage,#3
2635                     ; 651 				esr_time = 5;
2637  0149 35050029      	mov	_esr_time,#5
2638                     ; 652 				ind[0]=3;
2640  014d 35030001      	mov	_ind,#3
2642  0151 cc01d3        	jra	L5531
2643  0154               L3041:
2644                     ; 654 			else if ((esr_stage==3)&&(tmcpT >200)) {
2646  0154 b628          	ld	a,_esr_stage
2647  0156 a103          	cp	a,#3
2648  0158 261c          	jrne	L7041
2650  015a ae0000        	ldw	x,#_tmcpT
2651  015d cd0000        	call	c_ltor
2653  0160 ae0078        	ldw	x,#L012
2654  0163 cd0000        	call	c_lcmp
2656  0166 2f0e          	jrslt	L7041
2657                     ; 655 				esr_stage=4;
2659  0168 35040028      	mov	_esr_stage,#4
2660                     ; 656 				esr_time = 5;
2662  016c 35050029      	mov	_esr_time,#5
2663                     ; 657 				ind[0]=3;
2665  0170 35030001      	mov	_ind,#3
2667  0174 205d          	jra	L5531
2668  0176               L7041:
2669                     ; 663 			else if ((esr_stage==4)&&(esr_time==0)) {
2671  0176 b628          	ld	a,_esr_stage
2672  0178 a104          	cp	a,#4
2673  017a 2612          	jrne	L3141
2675  017c 3d29          	tnz	_esr_time
2676  017e 260e          	jrne	L3141
2677                     ; 665 				u2 = tmcpT;
2679  0180 be02          	ldw	x,_tmcpT+2
2680  0182 bf06          	ldw	_u2+2,x
2681  0184 be00          	ldw	x,_tmcpT
2682  0186 bf04          	ldw	_u2,x
2683                     ; 666 				esr_stage=5;					
2685  0188 35050028      	mov	_esr_stage,#5
2687  018c 2045          	jra	L5531
2688  018e               L3141:
2689                     ; 669 			else if ((esr_stage==5)&&(tmcpT <200)) {
2691  018e a105          	cp	a,#5
2692  0190 2609          	jrne	L7141
2694  0192 cd0415        	call	LC011
2696  0195 2e04          	jrsge	L7141
2697                     ; 670 				esr_stage=0;
2699  0197 3f28          	clr	_esr_stage
2701  0199 2038          	jra	L5531
2702  019b               L7141:
2703                     ; 672 			else if ((esr_stage==5)) {
2705  019b b628          	ld	a,_esr_stage
2706  019d a105          	cp	a,#5
2707  019f 2632          	jrne	L5531
2708                     ; 675 				r= (u1-u2)*1000*110/64/112/10;
2710  01a1 ae0008        	ldw	x,#_u1
2711  01a4 cd0000        	call	c_ltor
2713  01a7 ae0004        	ldw	x,#_u2
2714  01aa cd0000        	call	c_lsub
2716  01ad ae007c        	ldw	x,#L212
2717  01b0 cd0000        	call	c_lmul
2719  01b3 ae0080        	ldw	x,#L412
2720  01b6 cd0000        	call	c_ldiv
2722  01b9 96            	ldw	x,sp
2723  01ba 1c000b        	addw	x,#OFST-9
2724  01bd cd0000        	call	c_rtol
2727                     ; 680 				if (r > 999) r=999;
2729  01c0 96            	ldw	x,sp
2730  01c1 cd0421        	call	LC012
2732  01c4 2f08          	jrslt	L5241
2735  01c6 ae03e7        	ldw	x,#999
2736  01c9 1f0d          	ldw	(OFST-7,sp),x
2737  01cb 5f            	clrw	x
2738  01cc 1f0b          	ldw	(OFST-9,sp),x
2740  01ce               L5241:
2741                     ; 681 				shownumber(r);
2743  01ce 1e0d          	ldw	x,(OFST-7,sp)
2744  01d0 cd0000        	call	_shownumber
2746  01d3               L5531:
2747                     ; 685 		if ((rezhim==3) || (rezhim==4)) {
2749  01d3 b617          	ld	a,_rezhim
2750  01d5 a103          	cp	a,#3
2751  01d7 2707          	jreq	L1341
2753  01d9 a104          	cp	a,#4
2754  01db 2703cc02f8    	jrne	L7241
2755  01e0               L1341:
2756                     ; 687 			u8 mant=0;
2758                     ; 688 			u8 big=0;
2760  01e0 0f09          	clr	(OFST-11,sp)
2762                     ; 690 			e /= 1000;
2764  01e2 ae03e8        	ldw	x,#1000
2765  01e5 cd0000        	call	c_itof
2767  01e8 96            	ldw	x,sp
2768  01e9 1c0011        	addw	x,#OFST-3
2769  01ec cd0000        	call	c_fgdiv
2772                     ; 691 			if (rezhim==3) e /= 2.4;//
2774  01ef b617          	ld	a,_rezhim
2775  01f1 a103          	cp	a,#3
2776  01f3 260f          	jrne	L3341
2779  01f5 ae0098        	ldw	x,#L1441
2780  01f8 cd0000        	call	c_ltor
2782  01fb 96            	ldw	x,sp
2783  01fc 1c0011        	addw	x,#OFST-3
2784  01ff cd0000        	call	c_fgdiv
2788  0202 201a          	jra	L5441
2789  0204               L3341:
2790                     ; 692 			else e = e * 103. / 3.;
2792  0204 96            	ldw	x,sp
2793  0205 1c0011        	addw	x,#OFST-3
2794  0208 cd0000        	call	c_ltor
2796  020b ae0094        	ldw	x,#L3541
2797  020e cd0000        	call	c_fmul
2799  0211 ae0090        	ldw	x,#L3641
2800  0214 cd0000        	call	c_fdiv
2802  0217 96            	ldw	x,sp
2803  0218 1c0011        	addw	x,#OFST-3
2804  021b cd0000        	call	c_rtol
2807  021e               L5441:
2808                     ; 694 			if (e<0) e=-e;
2810  021e 7b11          	ld	a,(OFST-3,sp)
2811  0220 2a07          	jrpl	L7641
2814  0222 96            	ldw	x,sp
2815  0223 1c0011        	addw	x,#OFST-3
2816  0226 cd0000        	call	c_fgneg
2819  0229               L7641:
2820                     ; 696 			if (e>1) {
2822  0229 a601          	ld	a,#1
2823  022b cd0000        	call	c_ctof
2825  022e 96            	ldw	x,sp
2826  022f 1c0005        	addw	x,#OFST-15
2827  0232 cd0000        	call	c_rtol
2830  0235 96            	ldw	x,sp
2831  0236 1c0011        	addw	x,#OFST-3
2832  0239 cd0000        	call	c_ltor
2834  023c 96            	ldw	x,sp
2835  023d 1c0005        	addw	x,#OFST-15
2836  0240 cd0000        	call	c_fcmp
2838  0243 2d08          	jrsle	L1741
2839                     ; 697 				big=1;
2841  0245 a601          	ld	a,#1
2842  0247 6b09          	ld	(OFST-11,sp),a
2844                     ; 698 				tchk[2]=0;
2846  0249 3f06          	clr	_tchk+2
2848  024b 2004          	jra	L3741
2849  024d               L1741:
2850                     ; 699 			}	else tchk[2]=1;
2852  024d 35010006      	mov	_tchk+2,#1
2853  0251               L3741:
2854                     ; 701 			if (rezhim==3) tchk[0]=1;
2856  0251 b617          	ld	a,_rezhim
2857  0253 a103          	cp	a,#3
2858  0255 2606          	jrne	L5741
2861  0257 35010004      	mov	_tchk,#1
2863  025b 2002          	jra	L7741
2864  025d               L5741:
2865                     ; 702 			else  tchk[0]=0;
2867  025d 3f04          	clr	_tchk
2868  025f               L7741:
2869                     ; 704 			tchk[1]=1;
2871  025f 35010005      	mov	_tchk+1,#1
2872                     ; 709 			for (mant=0;mant<10;mant++){
2874  0263 0f0a          	clr	(OFST-10,sp)
2876  0265               L1051:
2877                     ; 710 				if ((e >= 1) && (e <= 9)) break;				
2879  0265 a601          	ld	a,#1
2880  0267 cd0000        	call	c_ctof
2882  026a 96            	ldw	x,sp
2883  026b 1c0005        	addw	x,#OFST-15
2884  026e cd0000        	call	c_rtol
2887  0271 96            	ldw	x,sp
2888  0272 1c0011        	addw	x,#OFST-3
2889  0275 cd0000        	call	c_ltor
2891  0278 96            	ldw	x,sp
2892  0279 1c0005        	addw	x,#OFST-15
2893  027c cd0000        	call	c_fcmp
2895  027f 2f1c          	jrslt	L7051
2897  0281 a609          	ld	a,#9
2898  0283 cd0000        	call	c_ctof
2900  0286 96            	ldw	x,sp
2901  0287 1c0005        	addw	x,#OFST-15
2902  028a cd0000        	call	c_rtol
2905  028d 96            	ldw	x,sp
2906  028e 1c0011        	addw	x,#OFST-3
2907  0291 cd0000        	call	c_ltor
2909  0294 96            	ldw	x,sp
2910  0295 1c0005        	addw	x,#OFST-15
2911  0298 cd0000        	call	c_fcmp
2913  029b 2d26          	jrsle	L5051
2916  029d               L7051:
2917                     ; 712 				if (big) {
2919  029d 7b09          	ld	a,(OFST-11,sp)
2920  029f 270e          	jreq	L1151
2921                     ; 713 					e/=10;
2923  02a1 a60a          	ld	a,#10
2924  02a3 cd0000        	call	c_ctof
2926  02a6 96            	ldw	x,sp
2927  02a7 1c0011        	addw	x,#OFST-3
2928  02aa cd0000        	call	c_fgdiv
2932  02ad 200c          	jra	L3151
2933  02af               L1151:
2934                     ; 715 					e*=10;
2936  02af a60a          	ld	a,#10
2937  02b1 cd0000        	call	c_ctof
2939  02b4 96            	ldw	x,sp
2940  02b5 1c0011        	addw	x,#OFST-3
2941  02b8 cd0000        	call	c_fgmul
2944  02bb               L3151:
2945                     ; 709 			for (mant=0;mant<10;mant++){
2947  02bb 0c0a          	inc	(OFST-10,sp)
2951  02bd 7b0a          	ld	a,(OFST-10,sp)
2952  02bf a10a          	cp	a,#10
2953  02c1 25a2          	jrult	L1051
2954  02c3               L5051:
2955                     ; 718 			ind[2] = mant;
2957  02c3 7b0a          	ld	a,(OFST-10,sp)
2958  02c5 b703          	ld	_ind+2,a
2959                     ; 719 			ind[0] = (u8)e;
2961  02c7 96            	ldw	x,sp
2962  02c8 1c0011        	addw	x,#OFST-3
2963  02cb cd0000        	call	c_ltor
2965  02ce cd0000        	call	c_ftol
2967  02d1 b603          	ld	a,c_lreg+3
2968  02d3 b701          	ld	_ind,a
2969                     ; 720 			ind[1] = (u8)(e*10)-ind[0]*10;
2971  02d5 97            	ld	xl,a
2972  02d6 a60a          	ld	a,#10
2973  02d8 42            	mul	x,a
2974  02d9 9f            	ld	a,xl
2975  02da 6b08          	ld	(OFST-12,sp),a
2977  02dc 96            	ldw	x,sp
2978  02dd 1c0011        	addw	x,#OFST-3
2979  02e0 cd0000        	call	c_ltor
2981  02e3 ae008c        	ldw	x,#L1251
2982  02e6 cd0000        	call	c_fmul
2984  02e9 cd0000        	call	c_ftol
2986  02ec b603          	ld	a,c_lreg+3
2987  02ee 1008          	sub	a,(OFST-12,sp)
2988  02f0 b702          	ld	_ind+1,a
2989                     ; 721 			return 1;
2991  02f2               LC009:
2993  02f2 ae0001        	ldw	x,#1
2995  02f5               L432:
2997  02f5 5b14          	addw	sp,#20
2998  02f7 81            	ret	
2999  02f8               L7241:
3000                     ; 724 		if (e <-5) return 0;	
3002  02f8 aefffb        	ldw	x,#65531
3003  02fb cd0000        	call	c_itof
3005  02fe 96            	ldw	x,sp
3006  02ff 1c0005        	addw	x,#OFST-15
3007  0302 cd0000        	call	c_rtol
3010  0305 96            	ldw	x,sp
3011  0306 1c0011        	addw	x,#OFST-3
3012  0309 cd0000        	call	c_ltor
3014  030c 96            	ldw	x,sp
3015  030d 1c0005        	addw	x,#OFST-15
3016  0310 cd0000        	call	c_fcmp
3020  0313 2f1c          	jrslt	LC010
3021                     ; 725 		if (e >30) return 0; //720gradusov
3023  0315 a61e          	ld	a,#30
3024  0317 cd0000        	call	c_ctof
3026  031a 96            	ldw	x,sp
3027  031b 1c0005        	addw	x,#OFST-15
3028  031e cd0000        	call	c_rtol
3031  0321 96            	ldw	x,sp
3032  0322 1c0011        	addw	x,#OFST-3
3033  0325 cd0000        	call	c_ltor
3035  0328 96            	ldw	x,sp
3036  0329 1c0005        	addw	x,#OFST-15
3037  032c cd0000        	call	c_fcmp
3039  032f 2d03          	jrsle	L7251
3042  0331               LC010:
3045  0331 5f            	clrw	x
3047  0332 20c1          	jra	L432
3048  0334               L7251:
3049                     ; 727 		t=0;
3051  0334 5f            	clrw	x
3052  0335 1f0d          	ldw	(OFST-7,sp),x
3053  0337 1f0b          	ldw	(OFST-9,sp),x
3055                     ; 731 		if (e>20) 
3057  0339 a614          	ld	a,#20
3058  033b cd0000        	call	c_ctof
3060  033e 96            	ldw	x,sp
3061  033f 1c0005        	addw	x,#OFST-15
3062  0342 cd0000        	call	c_rtol
3065  0345 96            	ldw	x,sp
3066  0346 1c0011        	addw	x,#OFST-3
3067  0349 cd0000        	call	c_ltor
3069  034c 96            	ldw	x,sp
3070  034d 1c0005        	addw	x,#OFST-15
3071  0350 cd0000        	call	c_fcmp
3073  0353 2d69          	jrsle	L1351
3074                     ; 733 			t=t+cKf[0];
3076  0355 ce0046        	ldw	x,L712+2
3077  0358 1f0d          	ldw	(OFST-7,sp),x
3078  035a ce0044        	ldw	x,L712
3079  035d 1f0b          	ldw	(OFST-9,sp),x
3081                     ; 734 			for (i=0;i<6;i++) 
3083  035f 5f            	clrw	x
3084  0360 1f0f          	ldw	(OFST-5,sp),x
3086  0362               L3351:
3087                     ; 736 				t=t + (cKf[i+1])*mypow(e,(i+1));
3089  0362 5c            	incw	x
3090  0363 89            	pushw	x
3091  0364 1e15          	ldw	x,(OFST+1,sp)
3092  0366 89            	pushw	x
3093  0367 1e15          	ldw	x,(OFST+1,sp)
3094  0369 89            	pushw	x
3095  036a cd0000        	call	_mypow
3097  036d 5b06          	addw	sp,#6
3098  036f 96            	ldw	x,sp
3099  0370 1c0005        	addw	x,#OFST-15
3100  0373 cd0000        	call	c_rtol
3103  0376 1e0f          	ldw	x,(OFST-5,sp)
3104  0378 58            	sllw	x
3105  0379 58            	sllw	x
3106  037a 1c0048        	addw	x,#_cKf+4
3107  037d cd0000        	call	c_ltor
3109  0380 96            	ldw	x,sp
3110  0381 1c0005        	addw	x,#OFST-15
3111  0384 cd0000        	call	c_fmul
3113  0387 96            	ldw	x,sp
3114  0388 1c000b        	addw	x,#OFST-9
3115  038b cd0000        	call	c_fgadd
3118                     ; 734 			for (i=0;i<6;i++) 
3120  038e 1e0f          	ldw	x,(OFST-5,sp)
3121  0390 5c            	incw	x
3122  0391 1f0f          	ldw	(OFST-5,sp),x
3126  0393 a30006        	cpw	x,#6
3127  0396 2fca          	jrslt	L3351
3129  0398               L1451:
3130                     ; 744 		t*=100;
3132  0398 a664          	ld	a,#100
3133  039a cd0000        	call	c_ctof
3135  039d 96            	ldw	x,sp
3136  039e 1c000b        	addw	x,#OFST-9
3137  03a1 cd0000        	call	c_fgmul
3140                     ; 745 		tmcpT = (long) t + bmeT;
3142  03a4 96            	ldw	x,sp
3143  03a5 1c000b        	addw	x,#OFST-9
3144  03a8 cd0000        	call	c_ltor
3146  03ab cd0000        	call	c_ftol
3148  03ae ae0014        	ldw	x,#_bmeT
3149  03b1 ad7a          	call	LC013
3151                     ; 746 		mcpT = tmcpT;
3153  03b3 be02          	ldw	x,_tmcpT+2
3154  03b5 bf1a          	ldw	_mcpT+2,x
3155  03b7 be00          	ldw	x,_tmcpT
3156  03b9 bf18          	ldw	_mcpT,x
3157                     ; 750 		return 1;
3159  03bb cc02f2        	jp	LC009
3160  03be               L1351:
3161                     ; 739 			for (i=0;i<((e>0)? 9 : 8);i++) 
3163  03be 5f            	clrw	x
3165  03bf 203f          	jra	L7451
3166  03c1               L3451:
3167                     ; 741 				t=t + ((e>0)?cK[i]:cKm[i])*mypow(e,i+1);
3169  03c1 1e0f          	ldw	x,(OFST-5,sp)
3170  03c3 5c            	incw	x
3171  03c4 89            	pushw	x
3172  03c5 1e15          	ldw	x,(OFST+1,sp)
3173  03c7 89            	pushw	x
3174  03c8 1e15          	ldw	x,(OFST+1,sp)
3175  03ca 89            	pushw	x
3176  03cb cd0000        	call	_mypow
3178  03ce 5b06          	addw	sp,#6
3179  03d0 96            	ldw	x,sp
3180  03d1 1c0005        	addw	x,#OFST-15
3181  03d4 cd0000        	call	c_rtol
3184  03d7 9c            	rvf	
3185  03d8 7b11          	ld	a,(OFST-3,sp)
3186  03da 2d09          	jrsle	L422
3187  03dc 1e0f          	ldw	x,(OFST-5,sp)
3188  03de 58            	sllw	x
3189  03df 58            	sllw	x
3190  03e0 1c0000        	addw	x,#_cK
3192  03e3 2007          	jra	L622
3193  03e5               L422:
3194  03e5 1e0f          	ldw	x,(OFST-5,sp)
3195  03e7 58            	sllw	x
3196  03e8 58            	sllw	x
3197  03e9 1c0024        	addw	x,#_cKm
3199  03ec               L622:
3200  03ec cd0000        	call	c_ltor
3201  03ef 96            	ldw	x,sp
3202  03f0 1c0005        	addw	x,#OFST-15
3203  03f3 cd0000        	call	c_fmul
3205  03f6 96            	ldw	x,sp
3206  03f7 1c000b        	addw	x,#OFST-9
3207  03fa cd0000        	call	c_fgadd
3210                     ; 739 			for (i=0;i<((e>0)? 9 : 8);i++) 
3212  03fd 1e0f          	ldw	x,(OFST-5,sp)
3213  03ff 5c            	incw	x
3214  0400               L7451:
3215  0400 1f0f          	ldw	(OFST-5,sp),x
3219  0402 9c            	rvf	
3220  0403 7b11          	ld	a,(OFST-3,sp)
3221  0405 2d05          	jrsle	L032
3222  0407 ae0009        	ldw	x,#9
3223  040a 2003          	jra	L232
3224  040c               L032:
3225  040c ae0008        	ldw	x,#8
3226  040f               L232:
3227  040f 130f          	cpw	x,(OFST-5,sp)
3228  0411 2cae          	jrsgt	L3451
3229  0413 2083          	jra	L1451
3230  0415               LC011:
3231  0415 ae0000        	ldw	x,#_tmcpT
3232  0418 cd0000        	call	c_ltor
3234  041b ae0074        	ldw	x,#L602
3235  041e cc0000        	jp	c_lcmp
3236  0421               LC012:
3237  0421 1c000b        	addw	x,#OFST-9
3238  0424 cd0000        	call	c_ltor
3240  0427 ae0060        	ldw	x,#L42
3241  042a cc0000        	jp	c_lcmp
3242  042d               LC013:
3243  042d cd0000        	call	c_ladd
3245  0430 ae0000        	ldw	x,#_tmcpT
3246  0433 cc0000        	jp	c_rtol
3249                     	bsct
3250  002e               _readytosleep:
3251  002e 00            	dc.b	0
3282                     ; 755 u8 sleep(void) {
3283                     .text:	section	.text,new
3284  0000               _sleep:
3288                     ; 758 	readytosleep = 1;
3290  0000 3501002e      	mov	_readytosleep,#1
3291                     ; 762 	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_IN_PU_NO_IT);
3293  0004 4b40          	push	#64
3294  0006 4b7c          	push	#124
3295  0008 ae500f        	ldw	x,#20495
3296  000b cd0000        	call	_GPIO_Init
3298  000e 85            	popw	x
3299                     ; 763 	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_IN_PU_NO_IT);
3301  000f 4b40          	push	#64
3302  0011 4b02          	push	#2
3303  0013 ae5000        	ldw	x,#20480
3304  0016 cd0000        	call	_GPIO_Init
3306  0019 85            	popw	x
3307                     ; 764 	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_IN_PU_NO_IT);	
3309  001a 4b40          	push	#64
3310  001c 4bf8          	push	#248
3311  001e ae500a        	ldw	x,#20490
3312  0021 cd0000        	call	_GPIO_Init
3314  0024 35010020      	mov	_buff,#1
3315  0028 35010021      	mov	_buff+1,#1
3316  002c 85            	popw	x
3317                     ; 768 	buff[0] = (uint8_t) 0b1;//config reg
3319                     ; 769 	buff[1] = (uint8_t) 0b1;//shutdown
3321                     ; 770 	if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
3323  002d 5f            	clrw	x
3324  002e 89            	pushw	x
3325  002f ae0002        	ldw	x,#2
3326  0032 89            	pushw	x
3327  0033 ae0020        	ldw	x,#_buff
3328  0036 89            	pushw	x
3329  0037 a648          	ld	a,#72
3330  0039 cd0000        	call	_I2C_writenbyte
3332  003c 5b06          	addw	sp,#6
3333  003e 5d            	tnzw	x
3334  003f 2602          	jrne	L3651
3335                     ; 772 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
3337  0041 2072          	jp	LC014
3338  0043               L3651:
3339                     ; 777 	buff[0] = (uint8_t) 0b0;//config reg
3342  0043 3f20          	clr	_buff
3343                     ; 778 	buff[1] = (uint8_t) 0b01000001;//low byte
3345  0045 35410021      	mov	_buff+1,#65
3346                     ; 779 	buff[2] = (uint8_t) 0b0;//high byte - always 0
3348  0049 3f22          	clr	_buff+2
3349                     ; 780 	if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
3351  004b 5f            	clrw	x
3352  004c 89            	pushw	x
3353  004d ae0003        	ldw	x,#3
3354  0050 89            	pushw	x
3355  0051 ae0020        	ldw	x,#_buff
3356  0054 89            	pushw	x
3357  0055 a610          	ld	a,#16
3358  0057 cd0000        	call	_I2C_writenbyte
3360  005a 5b06          	addw	sp,#6
3361  005c 5d            	tnzw	x
3362  005d 2602          	jrne	L5651
3363                     ; 782 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
3365  005f 2054          	jp	LC014
3366  0061               L5651:
3367                     ; 788 	buff[0] = (uint8_t) 0b10001100;//one shot and sleep
3370  0061 358c0020      	mov	_buff,#140
3371                     ; 789 	if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 1,0) ) 
3373  0065 5f            	clrw	x
3374  0066 89            	pushw	x
3375  0067 5c            	incw	x
3376  0068 89            	pushw	x
3377  0069 ae0020        	ldw	x,#_buff
3378  006c 89            	pushw	x
3379  006d a668          	ld	a,#104
3380  006f cd0000        	call	_I2C_writenbyte
3382  0072 5b06          	addw	sp,#6
3383  0074 5d            	tnzw	x
3384  0075 2602          	jrne	L7651
3385                     ; 791 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
3387  0077 203c          	jp	LC014
3388  0079               L7651:
3389                     ; 795 	Delay(10);//need for end i2c!
3392  0079 ae000a        	ldw	x,#10
3393  007c cd0000        	call	_Delay
3395                     ; 797 	halt();
3398  007f 8e            	halt	
3400                     ; 799 	Delay(100);
3403  0080 ae0064        	ldw	x,#100
3404  0083 cd0000        	call	_Delay
3406                     ; 801 	kn[0] = 0;	
3408  0086 3f35          	clr	_kn
3409                     ; 803 	nctinit();
3411  0088 cd0000        	call	_nctinit
3413                     ; 804 	mcpinit();
3415  008b cd0000        	call	_mcpinit
3417                     ; 805 	uvinit();
3419  008e cd0000        	call	_uvinit
3421                     ; 808 	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_OUT_PP_LOW_SLOW);
3423  0091 4bc0          	push	#192
3424  0093 4b7c          	push	#124
3425  0095 ae500f        	ldw	x,#20495
3426  0098 cd0000        	call	_GPIO_Init
3428  009b 85            	popw	x
3429                     ; 809 	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_OUT_PP_LOW_SLOW);
3431  009c 4bc0          	push	#192
3432  009e 4b02          	push	#2
3433  00a0 ae5000        	ldw	x,#20480
3434  00a3 cd0000        	call	_GPIO_Init
3436  00a6 85            	popw	x
3437                     ; 810 	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_OUT_PP_LOW_SLOW);	
3439  00a7 4bc0          	push	#192
3440  00a9 4bf8          	push	#248
3441  00ab ae500a        	ldw	x,#20490
3442  00ae cd0000        	call	_GPIO_Init
3444  00b1 3f2e          	clr	_readytosleep
3445  00b3 85            	popw	x
3446                     ; 814 	readytosleep = 0;
3448                     ; 818 	return;
3451  00b4 81            	ret	
3452  00b5               LC014:
3453  00b5 72125211      	bset	21009,#1
3454                     ; 792 		return 0;
3456  00b9 4f            	clr	a
3459  00ba 81            	ret	
3495                     ; 849 void cifra(u8 num){
3496                     .text:	section	.text,new
3497  0000               _cifra:
3499  0000 88            	push	a
3500       00000000      OFST:	set	0
3503                     ; 850 	ALLOFF
3505  0001 4bf8          	push	#248
3506  0003 ae500a        	ldw	x,#20490
3507  0006 cd0000        	call	_GPIO_WriteHigh
3509  0009 84            	pop	a
3512  000a 4b34          	push	#52
3513  000c ae500f        	ldw	x,#20495
3514  000f cd0000        	call	_GPIO_WriteHigh
3516  0012 84            	pop	a
3517                     ; 852 	if (num==0) {
3519  0013 7b01          	ld	a,(OFST+1,sp)
3520  0015 260e          	jrne	L7061
3521                     ; 853 		AON;BON;CON;DON;EON;FON;
3523  0017 cd00a1        	call	LC015
3526  001a cd00a5        	call	LC016
3529  001d cd00d1        	call	LC021
3532  0020 cd00b9        	call	LC018
3533  0023 7b01          	ld	a,(OFST+1,sp)
3534  0025               L7061:
3535                     ; 855 	if (num==1) {
3537  0025 a101          	cp	a,#1
3538  0027 2605          	jrne	L1161
3539                     ; 856 		BON;CON;
3541  0029 cd00c3        	call	LC019
3542  002c 7b01          	ld	a,(OFST+1,sp)
3543  002e               L1161:
3544                     ; 858 	if (num==2) {
3546  002e a102          	cp	a,#2
3547  0030 260f          	jrne	L3161
3548                     ; 859 		AON;BON;GON;EON;DON;
3550  0032 cd00c7        	call	LC020
3553  0035 cd00e5        	call	LC023
3556  0038 ad75          	call	LC017
3559  003a cd00d1        	call	LC021
3562  003d ad66          	call	LC016
3563  003f 7b01          	ld	a,(OFST+1,sp)
3564  0041               L3161:
3565                     ; 861 	if (num==3) {
3567  0041 a103          	cp	a,#3
3568  0043 2608          	jrne	L5161
3569                     ; 862 		AON;BON;CON;DON;GON;
3571  0045 ad5a          	call	LC015
3574  0047 ad5c          	call	LC016
3577  0049 ad64          	call	LC017
3578  004b 7b01          	ld	a,(OFST+1,sp)
3579  004d               L5161:
3580                     ; 864 	if (num==4) {
3582  004d a104          	cp	a,#4
3583  004f 2608          	jrne	L7161
3584                     ; 865 		FON;GON;BON;CON;
3586  0051 ad66          	call	LC018
3589  0053 ad5a          	call	LC017
3592  0055 ad6c          	call	LC019
3593  0057 7b01          	ld	a,(OFST+1,sp)
3594  0059               L7161:
3595                     ; 867 	if (num==5) {
3597  0059 a105          	cp	a,#5
3598  005b 260c          	jrne	L1261
3599                     ; 868 		AON;FON;GON;CON;DON;
3601  005d ad68          	call	LC020
3604  005f ad58          	call	LC018
3607  0061 ad4c          	call	LC017
3610  0063 ad76          	call	LC022
3613  0065 ad3e          	call	LC016
3614  0067 7b01          	ld	a,(OFST+1,sp)
3615  0069               L1261:
3616                     ; 870 	if (num==6) {
3618  0069 a106          	cp	a,#6
3619  006b 260e          	jrne	L3261
3620                     ; 871 		AON;EON;FON;GON;CON;DON;
3622  006d ad58          	call	LC020
3625  006f ad60          	call	LC021
3628  0071 ad46          	call	LC018
3631  0073 ad3a          	call	LC017
3634  0075 ad64          	call	LC022
3637  0077 ad2c          	call	LC016
3638  0079 7b01          	ld	a,(OFST+1,sp)
3639  007b               L3261:
3640                     ; 873 	if (num==7) {
3642  007b a107          	cp	a,#7
3643  007d 2604          	jrne	L5261
3644                     ; 874 		AON;BON;CON;
3646  007f ad20          	call	LC015
3647  0081 7b01          	ld	a,(OFST+1,sp)
3648  0083               L5261:
3649                     ; 876 	if (num==8) {
3651  0083 a108          	cp	a,#8
3652  0085 260c          	jrne	L7261
3653                     ; 877 		AON;BON;CON;GON;DON;EON;FON;
3655  0087 ad18          	call	LC015
3658  0089 ad24          	call	LC017
3661  008b ad18          	call	LC016
3664  008d ad42          	call	LC021
3667  008f ad28          	call	LC018
3668  0091 7b01          	ld	a,(OFST+1,sp)
3669  0093               L7261:
3670                     ; 879 	if (num==9) {
3672  0093 a109          	cp	a,#9
3673  0095 2608          	jrne	L1361
3674                     ; 880 		AON;BON;CON;GON;DON;FON;
3676  0097 ad08          	call	LC015
3679  0099 ad14          	call	LC017
3682  009b ad08          	call	LC016
3685  009d ad1a          	call	LC018
3686  009f               L1361:
3687                     ; 883 }
3690  009f 84            	pop	a
3691  00a0 81            	ret	
3692  00a1               LC015:
3693  00a1 ad24          	call	LC020
3694                     ; 853 		AON;BON;CON;DON;EON;FON;
3696  00a3 201e          	jp	LC019
3697  00a5               LC016:
3698  00a5 4b40          	push	#64
3699  00a7 ae500a        	ldw	x,#20490
3700  00aa cd0000        	call	_GPIO_WriteLow
3702  00ad 84            	pop	a
3703  00ae 81            	ret	
3704  00af               LC017:
3705  00af 4b08          	push	#8
3706  00b1 ae500a        	ldw	x,#20490
3707  00b4 cd0000        	call	_GPIO_WriteLow
3709  00b7 84            	pop	a
3710  00b8 81            	ret	
3711  00b9               LC018:
3712  00b9 4b10          	push	#16
3713  00bb ae500f        	ldw	x,#20495
3714  00be cd0000        	call	_GPIO_WriteLow
3716  00c1 84            	pop	a
3717  00c2 81            	ret	
3718  00c3               LC019:
3719  00c3 ad20          	call	LC023
3722  00c5 2014          	jp	LC022
3723  00c7               LC020:
3724  00c7 4b20          	push	#32
3725  00c9 ae500f        	ldw	x,#20495
3726  00cc cd0000        	call	_GPIO_WriteLow
3728  00cf 84            	pop	a
3729  00d0 81            	ret	
3730  00d1               LC021:
3731  00d1 4b80          	push	#128
3732  00d3 ae500a        	ldw	x,#20490
3733  00d6 cd0000        	call	_GPIO_WriteLow
3735  00d9 84            	pop	a
3736  00da 81            	ret	
3737  00db               LC022:
3738  00db 4b10          	push	#16
3739  00dd ae500a        	ldw	x,#20490
3740  00e0 cd0000        	call	_GPIO_WriteLow
3742  00e3 84            	pop	a
3743  00e4 81            	ret	
3744  00e5               LC023:
3745  00e5 4b04          	push	#4
3746  00e7 ae500f        	ldw	x,#20495
3747  00ea cd0000        	call	_GPIO_WriteLow
3749  00ed 84            	pop	a
3750  00ee 81            	ret	
3814                     ; 888 void addnum(u8 index, u8 pin1,u8 pin2) {
3815                     .text:	section	.text,new
3816  0000               _addnum:
3818  0000 89            	pushw	x
3819  0001 88            	push	a
3820       00000001      OFST:	set	1
3823                     ; 891 	num = ind[index];
3825  0002 9e            	ld	a,xh
3826  0003 5f            	clrw	x
3827  0004 97            	ld	xl,a
3828  0005 e601          	ld	a,(_ind,x)
3829  0007 6b01          	ld	(OFST+0,sp),a
3831                     ; 893 	if (tchk[index]) {
3833  0009 5f            	clrw	x
3834  000a 7b02          	ld	a,(OFST+1,sp)
3835  000c 97            	ld	xl,a
3836  000d e604          	ld	a,(_tchk,x)
3837  000f 2706          	jreq	L1171
3838                     ; 894 		com[3] |= pin2;
3840  0011 b6bd          	ld	a,_com+3
3841  0013 1a06          	or	a,(OFST+5,sp)
3842  0015 b7bd          	ld	_com+3,a
3843  0017               L1171:
3844                     ; 897 	switch (num) {
3846  0017 7b01          	ld	a,(OFST+0,sp)
3848                     ; 974 				break;
3849  0019 2721          	jreq	L3361
3850  001b 4a            	dec	a
3851  001c 2729          	jreq	L5361
3852  001e 4a            	dec	a
3853  001f 272c          	jreq	L7361
3854  0021 4a            	dec	a
3855  0022 273d          	jreq	L1461
3856  0024 4a            	dec	a
3857  0025 2746          	jreq	L3461
3858  0027 4a            	dec	a
3859  0028 2759          	jreq	L5461
3860  002a 4a            	dec	a
3861  002b 2760          	jreq	L7461
3862  002d 4a            	dec	a
3863  002e 276f          	jreq	L1561
3864  0030 4a            	dec	a
3865  0031 2774          	jreq	L3561
3866  0033 4a            	dec	a
3867  0034 2603cc00b7    	jreq	L5561
3868  0039 cc00d3        	jra	L5171
3869  003c               L3361:
3870                     ; 898 		case 0:
3870                     ; 899 				//p1 - com0 com2     com3
3870                     ; 900 				//p2 - com0 com2 com1 
3870                     ; 901 				
3870                     ; 902 				com[0] |= pin1|pin2;
3872  003c 7b03          	ld	a,(OFST+2,sp)
3873  003e 1a06          	or	a,(OFST+5,sp)
3874  0040 cd00d6        	call	LC030
3875  0043 1a06          	or	a,(OFST+5,sp)
3876                     ; 904 				com[2] |= pin1|pin2;
3877                     ; 905 				com[3] |= pin1;
3878                     ; 906 				break;
3880  0045 204e          	jp	LC027
3881  0047               L5361:
3882                     ; 907 		case 1:
3882                     ; 908 				//p2 - com1 com2
3882                     ; 909 				com[1] |= pin2;
3885  0047 b6bb          	ld	a,_com+1
3886  0049 1a06          	or	a,(OFST+5,sp)
3887                     ; 910 				com[2] |= pin2;
3888                     ; 911 				break;
3890  004b 202c          	jp	LC028
3891  004d               L7361:
3892                     ; 912 		case 2:
3892                     ; 913 				//p1 - com1 com2 com3
3892                     ; 914 				//p2 - com0 com1
3892                     ; 915 				com[0] |= pin2;
3894  004d b6ba          	ld	a,_com
3895  004f 1a06          	or	a,(OFST+5,sp)
3896  0051 b7ba          	ld	_com,a
3897                     ; 916 				com[1] |= pin1|pin2;
3899  0053 7b03          	ld	a,(OFST+2,sp)
3900  0055 1a06          	or	a,(OFST+5,sp)
3901  0057 babb          	or	a,_com+1
3902  0059 b7bb          	ld	_com+1,a
3903                     ; 917 				com[2] |= pin1;
3905  005b b6bc          	ld	a,_com+2
3906  005d 1a03          	or	a,(OFST+2,sp)
3907                     ; 918 				com[3] |= pin1;
3908                     ; 919 				break;
3910  005f 206a          	jp	LC024
3911  0061               L1461:
3912                     ; 920 		case 3:
3912                     ; 921 				//p1 -      com1     com3
3912                     ; 922 				//p2 - com0 com1 com2
3912                     ; 923 				com[0] |= pin2;
3914  0061 b6ba          	ld	a,_com
3915  0063 1a06          	or	a,(OFST+5,sp)
3916  0065 b7ba          	ld	_com,a
3917                     ; 924 				com[1] |= pin1|pin2;
3919  0067 7b03          	ld	a,(OFST+2,sp)
3920  0069 1a06          	or	a,(OFST+5,sp)
3921                     ; 925 				com[2] |= pin2;
3922                     ; 926 				com[3] |= pin1;
3923                     ; 927 				break;
3925  006b 2056          	jp	LC026
3926  006d               L3461:
3927                     ; 928 		case 4:
3927                     ; 929 				//p1 - com0 com1
3927                     ; 930 				//p2 -      com1 com2
3927                     ; 931 				com[0] |= pin1;
3929  006d b6ba          	ld	a,_com
3930  006f 1a03          	or	a,(OFST+2,sp)
3931  0071 b7ba          	ld	_com,a
3932                     ; 932 				com[1] |= pin1|pin2;
3934  0073 7b03          	ld	a,(OFST+2,sp)
3935  0075 1a06          	or	a,(OFST+5,sp)
3936  0077 babb          	or	a,_com+1
3937                     ; 933 				com[2]|= pin2;
3939  0079               LC028:
3940  0079 b7bb          	ld	_com+1,a
3943  007b b6bc          	ld	a,_com+2
3944  007d 1a06          	or	a,(OFST+5,sp)
3945  007f b7bc          	ld	_com+2,a
3946                     ; 934 				break;
3948  0081 2050          	jra	L5171
3949  0083               L5461:
3950                     ; 935 		case 5:
3950                     ; 936 				//p1 - com0 com1     com3
3950                     ; 937 				//p2 - com0      com2
3950                     ; 938 				com[0] |= pin1|pin2;
3952  0083 7b03          	ld	a,(OFST+2,sp)
3953  0085 1a06          	or	a,(OFST+5,sp)
3954  0087 ad4d          	call	LC030
3955  0089 1a03          	or	a,(OFST+2,sp)
3956                     ; 940 				com[2] |= pin2;
3957                     ; 941 				com[3] |= pin1;
3958                     ; 942 				break;
3960  008b 2038          	jp	LC025
3961  008d               L7461:
3962                     ; 943 		case 6:
3962                     ; 944 				//p1 - com0 com1 com2    com3
3962                     ; 945 				//p2 - com0      com2
3962                     ; 946 				com[0] |= pin1|pin2;
3964  008d 7b03          	ld	a,(OFST+2,sp)
3965  008f 1a06          	or	a,(OFST+5,sp)
3966  0091 ad43          	call	LC030
3967  0093 1a03          	or	a,(OFST+2,sp)
3968                     ; 948 				com[2] |= pin1|pin2;
3970  0095               LC027:
3971  0095 b7bb          	ld	_com+1,a
3974  0097 7b03          	ld	a,(OFST+2,sp)
3975  0099 1a06          	or	a,(OFST+5,sp)
3976  009b babc          	or	a,_com+2
3977                     ; 949 				com[3] |= pin1;
3978                     ; 950 				break;
3980  009d 202c          	jp	LC024
3981  009f               L1561:
3982                     ; 951 		case 7:
3982                     ; 952 				//p2 - com1 com2
3982                     ; 953 				com[0] |= pin2;
3984  009f b6ba          	ld	a,_com
3985  00a1 1a06          	or	a,(OFST+5,sp)
3986  00a3 b7ba          	ld	_com,a
3987                     ; 954 				com[1] |= pin2;
3988                     ; 955 				com[2] |= pin2;
3989                     ; 956 				break;
3991  00a5 20a0          	jp	L5361
3992  00a7               L3561:
3993                     ; 957 		case 8:
3993                     ; 958 				//p1 - com0 com2     com3
3993                     ; 959 				//p2 - com0 com2 com1 
3993                     ; 960 				
3993                     ; 961 				com[0] |= pin1|pin2;
3995  00a7 7b03          	ld	a,(OFST+2,sp)
3996  00a9 1a06          	or	a,(OFST+5,sp)
3997  00ab baba          	or	a,_com
3998  00ad b7ba          	ld	_com,a
3999                     ; 962 				com[1] |= pin2|pin1;
4001  00af 7b06          	ld	a,(OFST+5,sp)
4002  00b1 1a03          	or	a,(OFST+2,sp)
4003  00b3 babb          	or	a,_com+1
4004                     ; 963 				com[2] |= pin1|pin2;
4005                     ; 964 				com[3] |= pin1;
4006                     ; 965 				break;
4008  00b5 20de          	jp	LC027
4009  00b7               L5561:
4010                     ; 966 		case 9:
4010                     ; 967 				//p1 - com0 com2     com3
4010                     ; 968 				//p2 - com0 com2 com1 
4010                     ; 969 				
4010                     ; 970 				com[0] |= pin1|pin2;
4012  00b7 7b03          	ld	a,(OFST+2,sp)
4013  00b9 1a06          	or	a,(OFST+5,sp)
4014  00bb baba          	or	a,_com
4015  00bd b7ba          	ld	_com,a
4016                     ; 971 				com[1] |= pin2|pin1;
4018  00bf 7b06          	ld	a,(OFST+5,sp)
4019  00c1 1a03          	or	a,(OFST+2,sp)
4020  00c3               LC026:
4021  00c3 babb          	or	a,_com+1
4022                     ; 972 				com[2] |= pin2;
4024  00c5               LC025:
4025  00c5 b7bb          	ld	_com+1,a
4028  00c7 b6bc          	ld	a,_com+2
4029  00c9 1a06          	or	a,(OFST+5,sp)
4030                     ; 973 				com[3] |= pin1;
4032  00cb               LC024:
4033  00cb b7bc          	ld	_com+2,a
4040  00cd b6bd          	ld	a,_com+3
4041  00cf 1a03          	or	a,(OFST+2,sp)
4042  00d1 b7bd          	ld	_com+3,a
4043                     ; 974 				break;
4045  00d3               L5171:
4046                     ; 977 }	
4049  00d3 5b03          	addw	sp,#3
4050  00d5 81            	ret	
4051  00d6               LC030:
4052  00d6 baba          	or	a,_com
4053  00d8 b7ba          	ld	_com,a
4054                     ; 947 				com[1] |= pin1;
4056  00da b6bb          	ld	a,_com+1
4057  00dc 81            	ret	
4126                     ; 1004 void calclcd(void) {
4127                     .text:	section	.text,new
4128  0000               _calclcd:
4130  0000 5204          	subw	sp,#4
4131       00000004      OFST:	set	4
4134                     ; 1019 	if (timeshowrezhim) {
4136  0002 be15          	ldw	x,_timeshowrezhim
4137  0004 2760          	jreq	L1571
4138                     ; 1021 		if (rezhim==0) {
4140  0006 b617          	ld	a,_rezhim
4141  0008 260a          	jrne	L3571
4142                     ; 1022 			ind[0]=1;
4144  000a 35010001      	mov	_ind,#1
4145                     ; 1023 			ind[1]=0;
4147  000e b702          	ld	_ind+1,a
4148                     ; 1024 			ind[2]=1;
4150  0010 35010003      	mov	_ind+2,#1
4151  0014               L3571:
4152                     ; 1026 		if (rezhim==1) {
4154  0014 a101          	cp	a,#1
4155  0016 260a          	jrne	L5571
4156                     ; 1027 			ind[0]=1;
4158  0018 35010001      	mov	_ind,#1
4159                     ; 1028 			ind[1]=0;
4161  001c 3f02          	clr	_ind+1
4162                     ; 1029 			ind[2]=2;
4164  001e 35020003      	mov	_ind+2,#2
4165  0022               L5571:
4166                     ; 1031 		if (rezhim==2) {
4168  0022 a102          	cp	a,#2
4169  0024 2608          	jrne	L7571
4170                     ; 1032 			ind[0]=2;
4172  0026 35020001      	mov	_ind,#2
4173                     ; 1033 			ind[1]=0;
4175  002a 3f02          	clr	_ind+1
4176                     ; 1034 			ind[2]=0;
4178  002c 3f03          	clr	_ind+2
4179  002e               L7571:
4180                     ; 1036 		if (rezhim==3) {
4182  002e a103          	cp	a,#3
4183  0030 260a          	jrne	L1671
4184                     ; 1037 			ind[0]=3;
4186  0032 35030001      	mov	_ind,#3
4187                     ; 1038 			ind[1]=0;
4189  0036 3f02          	clr	_ind+1
4190                     ; 1039 			ind[2]=1;
4192  0038 35010003      	mov	_ind+2,#1
4193  003c               L1671:
4194                     ; 1041 		if (rezhim==4) {
4196  003c a104          	cp	a,#4
4197  003e 260a          	jrne	L3671
4198                     ; 1042 			ind[0]=3;
4200  0040 35030001      	mov	_ind,#3
4201                     ; 1043 			ind[1]=0;
4203  0044 3f02          	clr	_ind+1
4204                     ; 1044 			ind[2]=2;
4206  0046 35020003      	mov	_ind+2,#2
4207  004a               L3671:
4208                     ; 1046 		if (rezhim==5) {
4210  004a a105          	cp	a,#5
4211  004c 260a          	jrne	L5671
4212                     ; 1047 			ind[0]=4;
4214  004e 35040001      	mov	_ind,#4
4215                     ; 1048 			ind[1]=0;
4217  0052 3f02          	clr	_ind+1
4218                     ; 1049 			ind[2]=1;
4220  0054 35010003      	mov	_ind+2,#1
4221  0058               L5671:
4222                     ; 1051 		if (rezhim==6) {
4224  0058 a106          	cp	a,#6
4225  005a 260a          	jrne	L1571
4226                     ; 1052 			ind[0]=4;
4228  005c 35040001      	mov	_ind,#4
4229                     ; 1053 			ind[1]=0;
4231  0060 3f02          	clr	_ind+1
4232                     ; 1054 			ind[2]=2;
4234  0062 35020003      	mov	_ind+2,#2
4235  0066               L1571:
4236                     ; 1060 	for (i=0;i<4;i++) com[i]=0;
4238  0066 4f            	clr	a
4239  0067 6b04          	ld	(OFST+0,sp),a
4241  0069               L1771:
4244  0069 5f            	clrw	x
4245  006a 97            	ld	xl,a
4246  006b 6fba          	clr	(_com,x)
4249  006d 0c04          	inc	(OFST+0,sp)
4253  006f 7b04          	ld	a,(OFST+0,sp)
4254  0071 a104          	cp	a,#4
4255  0073 25f4          	jrult	L1771
4256                     ; 1064 	addnum(0, GPIO_PIN_1,GPIO_PIN_2);
4258  0075 4b04          	push	#4
4259  0077 ae0002        	ldw	x,#2
4260  007a cd0000        	call	_addnum
4262  007d 84            	pop	a
4263                     ; 1066 	addnum(1, GPIO_PIN_3,GPIO_PIN_4);
4265  007e 4b10          	push	#16
4266  0080 ae0108        	ldw	x,#264
4267  0083 cd0000        	call	_addnum
4269  0086 84            	pop	a
4270                     ; 1068 	addnum(2, GPIO_PIN_5,GPIO_PIN_6);
4272  0087 4b40          	push	#64
4273  0089 ae0220        	ldw	x,#544
4274  008c cd0000        	call	_addnum
4276  008f 84            	pop	a
4277                     ; 1071 	for (i=0;i<16;i++) {
4279  0090 4f            	clr	a
4280  0091 6b04          	ld	(OFST+0,sp),a
4282  0093               L7771:
4283                     ; 1072 		lcdm[16+i].porta_odr = GPIOA->ODR & (~(ALL_PORTA));
4285  0093 cd038b        	call	LC032
4286  0096 c65000        	ld	a,20480
4287  0099 a4fd          	and	a,#253
4288  009b e767          	ld	(_lcdm+49,x),a
4289                     ; 1073 		lcdm[16+i].portd_odr = GPIOD->ODR & (~(ALL_PORTD));
4291  009d c6500f        	ld	a,20495
4292  00a0 a483          	and	a,#131
4293  00a2 e768          	ld	(_lcdm+50,x),a
4294                     ; 1074 		lcdm[16+i].portc_odr = GPIOC->ODR & (~(ALL_PORTC));
4296  00a4 c6500a        	ld	a,20490
4297  00a7 a407          	and	a,#7
4298  00a9 e766          	ld	(_lcdm+48,x),a
4299                     ; 1071 	for (i=0;i<16;i++) {
4301  00ab 0c04          	inc	(OFST+0,sp)
4305  00ad 7b04          	ld	a,(OFST+0,sp)
4306  00af a110          	cp	a,#16
4307  00b1 25e0          	jrult	L7771
4308                     ; 1077 	for (i=0;i<4;i++) {
4310  00b3 4f            	clr	a
4311  00b4 6b04          	ld	(OFST+0,sp),a
4313  00b6               L5002:
4314                     ; 1079 		lcdm[16+i*4].porta_odr |= lcdpins[i].porta;
4316  00b6 cd038b        	call	LC032
4317  00b9 e697          	ld	a,(_lcdpins+1,x)
4318  00bb 6b01          	ld	(OFST-3,sp),a
4320  00bd 7b04          	ld	a,(OFST+0,sp)
4321  00bf cd0380        	call	LC031
4323  00c2 e667          	ld	a,(_lcdm+49,x)
4324  00c4 1a01          	or	a,(OFST-3,sp)
4325  00c6 e767          	ld	(_lcdm+49,x),a
4326                     ; 1080 		lcdm[16+i*4].portd_odr |= lcdpins[i].portd;
4328  00c8 7b04          	ld	a,(OFST+0,sp)
4329  00ca cd038b        	call	LC032
4330  00cd e698          	ld	a,(_lcdpins+2,x)
4331  00cf 6b01          	ld	(OFST-3,sp),a
4333  00d1 7b04          	ld	a,(OFST+0,sp)
4334  00d3 cd0380        	call	LC031
4336  00d6 e668          	ld	a,(_lcdm+50,x)
4337  00d8 1a01          	or	a,(OFST-3,sp)
4338  00da e768          	ld	(_lcdm+50,x),a
4339                     ; 1081 		lcdm[16+i*4].portc_odr |= lcdpins[i].portc;
4341  00dc 7b04          	ld	a,(OFST+0,sp)
4342  00de cd038b        	call	LC032
4343  00e1 e696          	ld	a,(_lcdpins,x)
4344  00e3 6b01          	ld	(OFST-3,sp),a
4346  00e5 7b04          	ld	a,(OFST+0,sp)
4347  00e7 cd0380        	call	LC031
4349  00ea e666          	ld	a,(_lcdm+48,x)
4350  00ec 1a01          	or	a,(OFST-3,sp)
4351  00ee e766          	ld	(_lcdm+48,x),a
4352                     ; 1083 		lcdm[16+i*4+1].porta_odr |= lcdpins[i].porta;
4354  00f0 7b04          	ld	a,(OFST+0,sp)
4355  00f2 cd038b        	call	LC032
4356  00f5 e697          	ld	a,(_lcdpins+1,x)
4357  00f7 6b01          	ld	(OFST-3,sp),a
4359  00f9 7b04          	ld	a,(OFST+0,sp)
4360  00fb cd0380        	call	LC031
4362  00fe e66a          	ld	a,(_lcdm+52,x)
4363  0100 1a01          	or	a,(OFST-3,sp)
4364  0102 e76a          	ld	(_lcdm+52,x),a
4365                     ; 1084 		lcdm[16+i*4+1].portd_odr |= lcdpins[i].portd;
4367  0104 7b04          	ld	a,(OFST+0,sp)
4368  0106 cd038b        	call	LC032
4369  0109 e698          	ld	a,(_lcdpins+2,x)
4370  010b 6b01          	ld	(OFST-3,sp),a
4372  010d 7b04          	ld	a,(OFST+0,sp)
4373  010f cd0380        	call	LC031
4375  0112 e66b          	ld	a,(_lcdm+53,x)
4376  0114 1a01          	or	a,(OFST-3,sp)
4377  0116 e76b          	ld	(_lcdm+53,x),a
4378                     ; 1085 		lcdm[16+i*4+1].portc_odr |= lcdpins[i].portc;
4380  0118 7b04          	ld	a,(OFST+0,sp)
4381  011a cd038b        	call	LC032
4382  011d e696          	ld	a,(_lcdpins,x)
4383  011f 6b01          	ld	(OFST-3,sp),a
4385  0121 7b04          	ld	a,(OFST+0,sp)
4386  0123 cd0380        	call	LC031
4388  0126 e669          	ld	a,(_lcdm+51,x)
4389  0128 1a01          	or	a,(OFST-3,sp)
4390  012a e769          	ld	(_lcdm+51,x),a
4391                     ; 1087 		for (j=0;j<4;j++) {
4393  012c 0f03          	clr	(OFST-1,sp)
4395  012e               L3102:
4396                     ; 1088 			if (i==j) continue;
4398  012e 7b04          	ld	a,(OFST+0,sp)
4399  0130 1103          	cp	a,(OFST-1,sp)
4400  0132 2778          	jreq	L5102
4403                     ; 1090 			lcdm[16+i*4].porta_odr |= lcdpins[j].porta;
4405  0134 7b03          	ld	a,(OFST-1,sp)
4406  0136 cd038b        	call	LC032
4407  0139 e697          	ld	a,(_lcdpins+1,x)
4408  013b 6b01          	ld	(OFST-3,sp),a
4410  013d 7b04          	ld	a,(OFST+0,sp)
4411  013f cd0380        	call	LC031
4413  0142 e667          	ld	a,(_lcdm+49,x)
4414  0144 1a01          	or	a,(OFST-3,sp)
4415  0146 e767          	ld	(_lcdm+49,x),a
4416                     ; 1091 			lcdm[16+i*4].portd_odr |= lcdpins[j].portd;
4418  0148 7b03          	ld	a,(OFST-1,sp)
4419  014a cd038b        	call	LC032
4420  014d e698          	ld	a,(_lcdpins+2,x)
4421  014f 6b01          	ld	(OFST-3,sp),a
4423  0151 7b04          	ld	a,(OFST+0,sp)
4424  0153 cd0380        	call	LC031
4426  0156 e668          	ld	a,(_lcdm+50,x)
4427  0158 1a01          	or	a,(OFST-3,sp)
4428  015a e768          	ld	(_lcdm+50,x),a
4429                     ; 1092 			lcdm[16+i*4].portc_odr |= lcdpins[j].portc;
4431  015c 7b03          	ld	a,(OFST-1,sp)
4432  015e cd038b        	call	LC032
4433  0161 e696          	ld	a,(_lcdpins,x)
4434  0163 6b01          	ld	(OFST-3,sp),a
4436  0165 7b04          	ld	a,(OFST+0,sp)
4437  0167 cd0380        	call	LC031
4439  016a e666          	ld	a,(_lcdm+48,x)
4440  016c 1a01          	or	a,(OFST-3,sp)
4441  016e e766          	ld	(_lcdm+48,x),a
4442                     ; 1094 			lcdm[16+i*4+2].porta_odr |= lcdpins[j].porta;
4444  0170 7b03          	ld	a,(OFST-1,sp)
4445  0172 cd038b        	call	LC032
4446  0175 e697          	ld	a,(_lcdpins+1,x)
4447  0177 6b01          	ld	(OFST-3,sp),a
4449  0179 7b04          	ld	a,(OFST+0,sp)
4450  017b cd0380        	call	LC031
4452  017e e66d          	ld	a,(_lcdm+55,x)
4453  0180 1a01          	or	a,(OFST-3,sp)
4454  0182 e76d          	ld	(_lcdm+55,x),a
4455                     ; 1095 			lcdm[16+i*4+2].portd_odr |= lcdpins[j].portd;
4457  0184 7b03          	ld	a,(OFST-1,sp)
4458  0186 cd038b        	call	LC032
4459  0189 e698          	ld	a,(_lcdpins+2,x)
4460  018b 6b01          	ld	(OFST-3,sp),a
4462  018d 7b04          	ld	a,(OFST+0,sp)
4463  018f cd0380        	call	LC031
4465  0192 e66e          	ld	a,(_lcdm+56,x)
4466  0194 1a01          	or	a,(OFST-3,sp)
4467  0196 e76e          	ld	(_lcdm+56,x),a
4468                     ; 1096 			lcdm[16+i*4+2].portc_odr |= lcdpins[j].portc;
4470  0198 7b03          	ld	a,(OFST-1,sp)
4471  019a cd038b        	call	LC032
4472  019d e696          	ld	a,(_lcdpins,x)
4473  019f 6b01          	ld	(OFST-3,sp),a
4475  01a1 7b04          	ld	a,(OFST+0,sp)
4476  01a3 cd0380        	call	LC031
4478  01a6 e66c          	ld	a,(_lcdm+54,x)
4479  01a8 1a01          	or	a,(OFST-3,sp)
4480  01aa e76c          	ld	(_lcdm+54,x),a
4481  01ac               L5102:
4482                     ; 1087 		for (j=0;j<4;j++) {
4484  01ac 0c03          	inc	(OFST-1,sp)
4488  01ae 7b03          	ld	a,(OFST-1,sp)
4489  01b0 a104          	cp	a,#4
4490  01b2 2403cc012e    	jrult	L3102
4491                     ; 1099 		for (j=4;j<11;j++) {
4493  01b7 a604          	ld	a,#4
4494  01b9 6b03          	ld	(OFST-1,sp),a
4496  01bb               L3202:
4497                     ; 1101 			lcdm[16+i*4].porta_odr |= lcdpins[j].porta;
4499  01bb cd038b        	call	LC032
4500  01be e697          	ld	a,(_lcdpins+1,x)
4501  01c0 6b01          	ld	(OFST-3,sp),a
4503  01c2 7b04          	ld	a,(OFST+0,sp)
4504  01c4 cd0380        	call	LC031
4506  01c7 e667          	ld	a,(_lcdm+49,x)
4507  01c9 1a01          	or	a,(OFST-3,sp)
4508  01cb e767          	ld	(_lcdm+49,x),a
4509                     ; 1102 			lcdm[16+i*4].portd_odr |= lcdpins[j].portd;
4511  01cd 7b03          	ld	a,(OFST-1,sp)
4512  01cf cd038b        	call	LC032
4513  01d2 e698          	ld	a,(_lcdpins+2,x)
4514  01d4 6b01          	ld	(OFST-3,sp),a
4516  01d6 7b04          	ld	a,(OFST+0,sp)
4517  01d8 cd0380        	call	LC031
4519  01db e668          	ld	a,(_lcdm+50,x)
4520  01dd 1a01          	or	a,(OFST-3,sp)
4521  01df e768          	ld	(_lcdm+50,x),a
4522                     ; 1103 			lcdm[16+i*4].portc_odr |= lcdpins[j].portc;
4524  01e1 7b03          	ld	a,(OFST-1,sp)
4525  01e3 cd038b        	call	LC032
4526  01e6 e696          	ld	a,(_lcdpins,x)
4527  01e8 6b01          	ld	(OFST-3,sp),a
4529  01ea 7b04          	ld	a,(OFST+0,sp)
4530  01ec cd0380        	call	LC031
4532  01ef e666          	ld	a,(_lcdm+48,x)
4533  01f1 1a01          	or	a,(OFST-3,sp)
4534  01f3 e766          	ld	(_lcdm+48,x),a
4535                     ; 1105 			lcdm[16+i*4+1].porta_odr |= lcdpins[j].porta;
4537  01f5 7b03          	ld	a,(OFST-1,sp)
4538  01f7 cd038b        	call	LC032
4539  01fa e697          	ld	a,(_lcdpins+1,x)
4540  01fc 6b01          	ld	(OFST-3,sp),a
4542  01fe 7b04          	ld	a,(OFST+0,sp)
4543  0200 cd0380        	call	LC031
4545  0203 e66a          	ld	a,(_lcdm+52,x)
4546  0205 1a01          	or	a,(OFST-3,sp)
4547  0207 e76a          	ld	(_lcdm+52,x),a
4548                     ; 1106 			lcdm[16+i*4+1].portd_odr |= lcdpins[j].portd;
4550  0209 7b03          	ld	a,(OFST-1,sp)
4551  020b cd038b        	call	LC032
4552  020e e698          	ld	a,(_lcdpins+2,x)
4553  0210 6b01          	ld	(OFST-3,sp),a
4555  0212 7b04          	ld	a,(OFST+0,sp)
4556  0214 cd0380        	call	LC031
4558  0217 e66b          	ld	a,(_lcdm+53,x)
4559  0219 1a01          	or	a,(OFST-3,sp)
4560  021b e76b          	ld	(_lcdm+53,x),a
4561                     ; 1107 			lcdm[16+i*4+1].portc_odr |= lcdpins[j].portc;
4563  021d 7b03          	ld	a,(OFST-1,sp)
4564  021f cd038b        	call	LC032
4565  0222 e696          	ld	a,(_lcdpins,x)
4566  0224 6b01          	ld	(OFST-3,sp),a
4568  0226 7b04          	ld	a,(OFST+0,sp)
4569  0228 cd0380        	call	LC031
4571  022b e669          	ld	a,(_lcdm+51,x)
4572  022d 1a01          	or	a,(OFST-3,sp)
4573  022f e769          	ld	(_lcdm+51,x),a
4574                     ; 1099 		for (j=4;j<11;j++) {
4576  0231 0c03          	inc	(OFST-1,sp)
4580  0233 7b03          	ld	a,(OFST-1,sp)
4581  0235 a10b          	cp	a,#11
4582  0237 2582          	jrult	L3202
4583                     ; 1077 	for (i=0;i<4;i++) {
4585  0239 0c04          	inc	(OFST+0,sp)
4589  023b 7b04          	ld	a,(OFST+0,sp)
4590  023d a104          	cp	a,#4
4591  023f 2403cc00b6    	jrult	L5002
4592                     ; 1111 	for (i=0;i<4;i++) {
4594  0244 4f            	clr	a
4595  0245 6b04          	ld	(OFST+0,sp),a
4597  0247               L1302:
4598                     ; 1112 		if (com[i]) {		
4600  0247 5f            	clrw	x
4601  0248 97            	ld	xl,a
4602  0249 e6ba          	ld	a,(_com,x)
4603  024b 2603cc0353    	jreq	L7302
4604                     ; 1114 			pin = 1;
4606  0250 a601          	ld	a,#1
4607  0252 6b02          	ld	(OFST-2,sp),a
4609                     ; 1116 			for (j=0;j<7;j++) {
4611  0254 0f03          	clr	(OFST-1,sp)
4613  0256               L1402:
4614                     ; 1117 				if (com[i] & pin) {
4616  0256 7b04          	ld	a,(OFST+0,sp)
4617  0258 5f            	clrw	x
4618  0259 97            	ld	xl,a
4619  025a e6ba          	ld	a,(_com,x)
4620  025c 1502          	bcp	a,(OFST-2,sp)
4621  025e 2603cc0346    	jreq	L7402
4622                     ; 1118 					lcdm[16+i*4+0].porta_odr &= ~lcdpins[j+4].porta;
4624  0263 7b04          	ld	a,(OFST+0,sp)
4625  0265 cd0380        	call	LC031
4627  0268 89            	pushw	x
4628  0269 7b05          	ld	a,(OFST+1,sp)
4629  026b cd038b        	call	LC032
4630  026e e6a3          	ld	a,(_lcdpins+13,x)
4631  0270 85            	popw	x
4632  0271 43            	cpl	a
4633  0272 e467          	and	a,(_lcdm+49,x)
4634  0274 e767          	ld	(_lcdm+49,x),a
4635                     ; 1119 					lcdm[16+i*4+1].porta_odr &= ~lcdpins[j+4].porta;
4637  0276 7b04          	ld	a,(OFST+0,sp)
4638  0278 cd0380        	call	LC031
4640  027b 89            	pushw	x
4641  027c 7b05          	ld	a,(OFST+1,sp)
4642  027e cd038b        	call	LC032
4643  0281 e6a3          	ld	a,(_lcdpins+13,x)
4644  0283 85            	popw	x
4645  0284 43            	cpl	a
4646  0285 e46a          	and	a,(_lcdm+52,x)
4647  0287 e76a          	ld	(_lcdm+52,x),a
4648                     ; 1120 					lcdm[16+i*4+2].porta_odr |= lcdpins[j+4].porta;
4650  0289 7b03          	ld	a,(OFST-1,sp)
4651  028b cd038b        	call	LC032
4652  028e e6a3          	ld	a,(_lcdpins+13,x)
4653  0290 6b01          	ld	(OFST-3,sp),a
4655  0292 7b04          	ld	a,(OFST+0,sp)
4656  0294 cd0380        	call	LC031
4658  0297 e66d          	ld	a,(_lcdm+55,x)
4659  0299 1a01          	or	a,(OFST-3,sp)
4660  029b e76d          	ld	(_lcdm+55,x),a
4661                     ; 1121 					lcdm[16+i*4+3].porta_odr |= lcdpins[j+4].porta;
4663  029d 7b03          	ld	a,(OFST-1,sp)
4664  029f cd038b        	call	LC032
4665  02a2 e6a3          	ld	a,(_lcdpins+13,x)
4666  02a4 6b01          	ld	(OFST-3,sp),a
4668  02a6 7b04          	ld	a,(OFST+0,sp)
4669  02a8 cd0380        	call	LC031
4671  02ab e670          	ld	a,(_lcdm+58,x)
4672  02ad 1a01          	or	a,(OFST-3,sp)
4673  02af e770          	ld	(_lcdm+58,x),a
4674                     ; 1123 					lcdm[16+i*4+0].portd_odr &= ~lcdpins[j+4].portd;
4676  02b1 7b04          	ld	a,(OFST+0,sp)
4677  02b3 cd0380        	call	LC031
4679  02b6 89            	pushw	x
4680  02b7 7b05          	ld	a,(OFST+1,sp)
4681  02b9 cd038b        	call	LC032
4682  02bc e6a4          	ld	a,(_lcdpins+14,x)
4683  02be 85            	popw	x
4684  02bf 43            	cpl	a
4685  02c0 e468          	and	a,(_lcdm+50,x)
4686  02c2 e768          	ld	(_lcdm+50,x),a
4687                     ; 1124 					lcdm[16+i*4+1].portd_odr &= ~lcdpins[j+4].portd;
4689  02c4 7b04          	ld	a,(OFST+0,sp)
4690  02c6 cd0380        	call	LC031
4692  02c9 89            	pushw	x
4693  02ca 7b05          	ld	a,(OFST+1,sp)
4694  02cc cd038b        	call	LC032
4695  02cf e6a4          	ld	a,(_lcdpins+14,x)
4696  02d1 85            	popw	x
4697  02d2 43            	cpl	a
4698  02d3 e46b          	and	a,(_lcdm+53,x)
4699  02d5 e76b          	ld	(_lcdm+53,x),a
4700                     ; 1125 					lcdm[16+i*4+2].portd_odr |= lcdpins[j+4].portd;
4702  02d7 7b03          	ld	a,(OFST-1,sp)
4703  02d9 cd038b        	call	LC032
4704  02dc e6a4          	ld	a,(_lcdpins+14,x)
4705  02de 6b01          	ld	(OFST-3,sp),a
4707  02e0 7b04          	ld	a,(OFST+0,sp)
4708  02e2 cd0380        	call	LC031
4710  02e5 e66e          	ld	a,(_lcdm+56,x)
4711  02e7 1a01          	or	a,(OFST-3,sp)
4712  02e9 e76e          	ld	(_lcdm+56,x),a
4713                     ; 1126 					lcdm[16+i*4+3].portd_odr |= lcdpins[j+4].portd;
4715  02eb 7b03          	ld	a,(OFST-1,sp)
4716  02ed cd038b        	call	LC032
4717  02f0 e6a4          	ld	a,(_lcdpins+14,x)
4718  02f2 6b01          	ld	(OFST-3,sp),a
4720  02f4 7b04          	ld	a,(OFST+0,sp)
4721  02f6 cd0380        	call	LC031
4723  02f9 e671          	ld	a,(_lcdm+59,x)
4724  02fb 1a01          	or	a,(OFST-3,sp)
4725  02fd e771          	ld	(_lcdm+59,x),a
4726                     ; 1128 					lcdm[16+i*4+0].portc_odr &= ~lcdpins[j+4].portc;
4728  02ff 7b04          	ld	a,(OFST+0,sp)
4729  0301 ad7d          	call	LC031
4731  0303 89            	pushw	x
4732  0304 7b05          	ld	a,(OFST+1,sp)
4733  0306 cd038b        	call	LC032
4734  0309 e6a2          	ld	a,(_lcdpins+12,x)
4735  030b 85            	popw	x
4736  030c 43            	cpl	a
4737  030d e466          	and	a,(_lcdm+48,x)
4738  030f e766          	ld	(_lcdm+48,x),a
4739                     ; 1129 					lcdm[16+i*4+1].portc_odr &= ~lcdpins[j+4].portc;
4741  0311 7b04          	ld	a,(OFST+0,sp)
4742  0313 ad6b          	call	LC031
4744  0315 89            	pushw	x
4745  0316 7b05          	ld	a,(OFST+1,sp)
4746  0318 ad71          	call	LC032
4747  031a e6a2          	ld	a,(_lcdpins+12,x)
4748  031c 85            	popw	x
4749  031d 43            	cpl	a
4750  031e e469          	and	a,(_lcdm+51,x)
4751  0320 e769          	ld	(_lcdm+51,x),a
4752                     ; 1130 					lcdm[16+i*4+2].portc_odr |= lcdpins[j+4].portc;
4754  0322 7b03          	ld	a,(OFST-1,sp)
4755  0324 ad65          	call	LC032
4756  0326 e6a2          	ld	a,(_lcdpins+12,x)
4757  0328 6b01          	ld	(OFST-3,sp),a
4759  032a 7b04          	ld	a,(OFST+0,sp)
4760  032c ad52          	call	LC031
4762  032e e66c          	ld	a,(_lcdm+54,x)
4763  0330 1a01          	or	a,(OFST-3,sp)
4764  0332 e76c          	ld	(_lcdm+54,x),a
4765                     ; 1131 					lcdm[16+i*4+3].portc_odr |= lcdpins[j+4].portc;
4767  0334 7b03          	ld	a,(OFST-1,sp)
4768  0336 ad53          	call	LC032
4769  0338 e6a2          	ld	a,(_lcdpins+12,x)
4770  033a 6b01          	ld	(OFST-3,sp),a
4772  033c 7b04          	ld	a,(OFST+0,sp)
4773  033e ad40          	call	LC031
4775  0340 e66f          	ld	a,(_lcdm+57,x)
4776  0342 1a01          	or	a,(OFST-3,sp)
4777  0344 e76f          	ld	(_lcdm+57,x),a
4778  0346               L7402:
4779                     ; 1133 				pin = pin << 1;
4781  0346 0802          	sll	(OFST-2,sp)
4783                     ; 1116 			for (j=0;j<7;j++) {
4785  0348 0c03          	inc	(OFST-1,sp)
4789  034a 7b03          	ld	a,(OFST-1,sp)
4790  034c a107          	cp	a,#7
4791  034e 2403cc0256    	jrult	L1402
4792  0353               L7302:
4793                     ; 1111 	for (i=0;i<4;i++) {
4795  0353 0c04          	inc	(OFST+0,sp)
4799  0355 7b04          	ld	a,(OFST+0,sp)
4800  0357 a104          	cp	a,#4
4801  0359 2403cc0247    	jrult	L1302
4802                     ; 1138 	blockcopylcd=1;
4804  035e 35010000      	mov	_blockcopylcd,#1
4805                     ; 1139 	for (i=0;i<16;i++) {
4807  0362 4f            	clr	a
4808  0363 6b04          	ld	(OFST+0,sp),a
4810  0365               L1502:
4811                     ; 1140 		lcdm[i].porta_odr = lcdm[16+i].porta_odr;
4813  0365 ad24          	call	LC032
4814  0367 e667          	ld	a,(_lcdm+49,x)
4815  0369 e737          	ld	(_lcdm+1,x),a
4816                     ; 1141 		lcdm[i].portd_odr = lcdm[16+i].portd_odr;
4818  036b e668          	ld	a,(_lcdm+50,x)
4819  036d e738          	ld	(_lcdm+2,x),a
4820                     ; 1142 		lcdm[i].portc_odr = lcdm[16+i].portc_odr;					
4822  036f e666          	ld	a,(_lcdm+48,x)
4823  0371 e736          	ld	(_lcdm,x),a
4824                     ; 1139 	for (i=0;i<16;i++) {
4826  0373 0c04          	inc	(OFST+0,sp)
4830  0375 7b04          	ld	a,(OFST+0,sp)
4831  0377 a110          	cp	a,#16
4832  0379 25ea          	jrult	L1502
4833                     ; 1145 	blockcopylcd=0;
4835  037b 3f00          	clr	_blockcopylcd
4836                     ; 1146 }
4839  037d 5b04          	addw	sp,#4
4840  037f 81            	ret	
4841  0380               LC031:
4842  0380 97            	ld	xl,a
4843  0381 a604          	ld	a,#4
4844  0383 42            	mul	x,a
4845  0384 90ae0003      	ldw	y,#3
4846  0388 cc0000        	jp	c_imul
4847  038b               LC032:
4848  038b 97            	ld	xl,a
4849  038c a603          	ld	a,#3
4850  038e 42            	mul	x,a
4851  038f 81            	ret	
4920                     	switch	.const
4921  0084               L625:
4922  0084 0000000a      	dc.l	10
4923  0088               L245:
4924  0088 00002710      	dc.l	10000
4925                     ; 1284 void main(void)
4925                     ; 1285 {
4926                     .text:	section	.text,new
4927  0000               _main:
4929  0000 89            	pushw	x
4930       00000002      OFST:	set	2
4933                     ; 1295 	CLK->PCKENR1 = CLK_PCKENR1_TIM2+CLK_PCKENR1_I2C;	CLK->PCKENR2 = 0b11110011;
4935  0001 352150c7      	mov	20679,#33
4938  0005 35f350ca      	mov	20682,#243
4939                     ; 1296 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);//2mgh энергосбережение
4941  0009 a618          	ld	a,#24
4942  000b cd0000        	call	_CLK_HSIPrescalerConfig
4944                     ; 1298 	GPIO_Init(GPIOD,ALL_PORTD,GPIO_MODE_OUT_PP_LOW_SLOW);
4946  000e 4bc0          	push	#192
4947  0010 4b7c          	push	#124
4948  0012 ae500f        	ldw	x,#20495
4949  0015 cd0000        	call	_GPIO_Init
4951  0018 85            	popw	x
4952                     ; 1299 	GPIO_Init(GPIOA,ALL_PORTA,GPIO_MODE_OUT_PP_LOW_SLOW);
4954  0019 4bc0          	push	#192
4955  001b 4b02          	push	#2
4956  001d ae5000        	ldw	x,#20480
4957  0020 cd0000        	call	_GPIO_Init
4959  0023 85            	popw	x
4960                     ; 1300 	GPIO_Init(GPIOC,ALL_PORTC,GPIO_MODE_OUT_PP_LOW_SLOW);	
4962  0024 4bc0          	push	#192
4963  0026 4bf8          	push	#248
4964  0028 ae500a        	ldw	x,#20490
4965  002b cd0000        	call	_GPIO_Init
4967  002e 85            	popw	x
4968                     ; 1302 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOA,EXTI_SENSITIVITY_FALL_ONLY);
4970  002f ae0002        	ldw	x,#2
4971  0032 cd0000        	call	_EXTI_SetExtIntSensitivity
4973                     ; 1303 	GPIO_Init(GPIOA,GPIO_PIN_2,GPIO_MODE_IN_PU_IT);//кнопка!
4975  0035 4b60          	push	#96
4976  0037 4b04          	push	#4
4977  0039 ae5000        	ldw	x,#20480
4978  003c cd0000        	call	_GPIO_Init
4980  003f 85            	popw	x
4981                     ; 1305   I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);
4983  0040 4b07          	push	#7
4984  0042 4b00          	push	#0
4985  0044 4b01          	push	#1
4986  0046 4b00          	push	#0
4987  0048 ae00a0        	ldw	x,#160
4988  004b 89            	pushw	x
4989  004c ae86a0        	ldw	x,#34464
4990  004f 89            	pushw	x
4991  0050 ae0001        	ldw	x,#1
4992  0053 89            	pushw	x
4993  0054 cd0000        	call	_I2C_Init
4995  0057 5b0a          	addw	sp,#10
4996                     ; 1319 	for (i=0;i<12;i++) {
4998  0059 5f            	clrw	x
4999  005a 1f01          	ldw	(OFST-1,sp),x
5001  005c               L5702:
5002                     ; 1320 		lcdpins[i].porta = 0;
5004  005c 90ae0003      	ldw	y,#3
5005  0060 cd0000        	call	c_imul
5007  0063 6f97          	clr	(_lcdpins+1,x)
5008                     ; 1321 		lcdpins[i].portd = 0;
5010  0065 90ae0003      	ldw	y,#3
5011  0069 1e01          	ldw	x,(OFST-1,sp)
5012  006b cd0000        	call	c_imul
5014  006e 6f98          	clr	(_lcdpins+2,x)
5015                     ; 1322 		lcdpins[i].portc = 0;
5017  0070 90ae0003      	ldw	y,#3
5018  0074 1e01          	ldw	x,(OFST-1,sp)
5019  0076 cd0000        	call	c_imul
5021  0079 6f96          	clr	(_lcdpins,x)
5022                     ; 1319 	for (i=0;i<12;i++) {
5024  007b 1e01          	ldw	x,(OFST-1,sp)
5025  007d 5c            	incw	x
5026  007e 1f01          	ldw	(OFST-1,sp),x
5030  0080 a3000c        	cpw	x,#12
5031  0083 25d7          	jrult	L5702
5032                     ; 1325 	lcdpins[0].portd = GPIO_PIN_6;
5034  0085 35400098      	mov	_lcdpins+2,#64
5035                     ; 1326 	lcdpins[1].portd = GPIO_PIN_5;
5037  0089 3520009b      	mov	_lcdpins+5,#32
5038                     ; 1327 	lcdpins[2].portc = GPIO_PIN_7;
5040  008d 3580009c      	mov	_lcdpins+6,#128
5041                     ; 1328 	lcdpins[3].portc = GPIO_PIN_6;
5043  0091 3540009f      	mov	_lcdpins+9,#64
5044                     ; 1330 	lcdpins[4].portd = GPIO_PIN_4;
5046  0095 351000a4      	mov	_lcdpins+14,#16
5047                     ; 1331 	lcdpins[5].portc = GPIO_PIN_5;
5049  0099 352000a5      	mov	_lcdpins+15,#32
5050                     ; 1332 	lcdpins[6].portc = GPIO_PIN_4;
5052  009d 351000a8      	mov	_lcdpins+18,#16
5053                     ; 1333 	lcdpins[7].portc = GPIO_PIN_3;
5055  00a1 350800ab      	mov	_lcdpins+21,#8
5056                     ; 1334 	lcdpins[8].porta = GPIO_PIN_1;
5058  00a5 350200af      	mov	_lcdpins+25,#2
5059                     ; 1335 	lcdpins[9].portd = GPIO_PIN_3;
5061  00a9 350800b3      	mov	_lcdpins+29,#8
5062                     ; 1336 	lcdpins[10].portd = GPIO_PIN_2;	
5064  00ad 350400b6      	mov	_lcdpins+32,#4
5065                     ; 1339 	ind[0] = 0;
5067  00b1 3f01          	clr	_ind
5068                     ; 1340 	ind[1] = 0;
5070  00b3 3f02          	clr	_ind+1
5071                     ; 1341 	ind[2] = 0;
5073  00b5 3f03          	clr	_ind+2
5074                     ; 1343 	calclcd();
5076  00b7 cd0000        	call	_calclcd
5078                     ; 1347 	TIM2_TimeBaseInit(TIM2_PRESCALER_8, 124);//2000Hz  124  249
5080  00ba ae007c        	ldw	x,#124
5081  00bd 89            	pushw	x
5082  00be a603          	ld	a,#3
5083  00c0 cd0000        	call	_TIM2_TimeBaseInit
5085  00c3 85            	popw	x
5086                     ; 1348   TIM2_ClearFlag(TIM2_FLAG_UPDATE);
5088  00c4 ae0001        	ldw	x,#1
5089  00c7 cd0000        	call	_TIM2_ClearFlag
5091                     ; 1349 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
5093  00ca ae0101        	ldw	x,#257
5094  00cd cd0000        	call	_TIM2_ITConfig
5096                     ; 1350   TIM2->IER |= (uint8_t)TIM2_IT_UPDATE;
5098  00d0 72105303      	bset	21251,#0
5099                     ; 1352 	TIM2_Cmd(ENABLE);
5101  00d4 a601          	ld	a,#1
5102  00d6 cd0000        	call	_TIM2_Cmd
5104                     ; 1370 	enableInterrupts();
5107  00d9 9a            	rim	
5109                     ; 1375 	Delay(100);
5112  00da ae0064        	ldw	x,#100
5113  00dd cd0000        	call	_Delay
5115                     ; 1377 	bmeT=0;
5117  00e0 5f            	clrw	x
5118  00e1 bf16          	ldw	_bmeT+2,x
5119  00e3 bf14          	ldw	_bmeT,x
5120                     ; 1380 	I2C_Cmd( ENABLE);
5122  00e5 a601          	ld	a,#1
5123  00e7 cd0000        	call	_I2C_Cmd
5125                     ; 1384 	mcpinit();
5127  00ea cd0000        	call	_mcpinit
5129                     ; 1385 	uvinit();
5131  00ed cd0000        	call	_uvinit
5133                     ; 1386 	nctinit();
5135  00f0 cd0000        	call	_nctinit
5137                     ; 1395 	kn[0] = KNONE;
5139  00f3 35040035      	mov	_kn,#4
5140  00f7               L3012:
5141                     ; 1399 		if (kn[0] == KNONE) {
5143  00f7 b635          	ld	a,_kn
5144  00f9 a104          	cp	a,#4
5145  00fb 2652          	jrne	L7012
5146                     ; 1400 			sleeptime = 60;
5148  00fd ae003c        	ldw	x,#60
5149  0100 bf13          	ldw	_sleeptime,x
5150                     ; 1401 			kn[0]=0;
5152  0102 3f35          	clr	_kn
5153                     ; 1402 			rezhim++;
5155  0104 3c17          	inc	_rezhim
5156                     ; 1403 			if (rezhim>6) rezhim = 0;
5158  0106 b617          	ld	a,_rezhim
5159  0108 a107          	cp	a,#7
5160  010a 2502          	jrult	L1112
5163  010c 3f17          	clr	_rezhim
5164  010e               L1112:
5165                     ; 1405 			tchk[0]=0;
5167  010e 3f04          	clr	_tchk
5168                     ; 1406 			tchk[1]=0;
5170  0110 3f05          	clr	_tchk+1
5171                     ; 1407 			tchk[2]=0;
5173  0112 3f06          	clr	_tchk+2
5174                     ; 1409 			if (rezhim==0) {
5176  0114 b617          	ld	a,_rezhim
5177  0116 2607          	jrne	L3112
5178                     ; 1410 				tchk[1]=1;
5180  0118 35010005      	mov	_tchk+1,#1
5181                     ; 1411 				timenct=0;
5183  011c 5f            	clrw	x
5184  011d bf0d          	ldw	_timenct,x
5185  011f               L3112:
5186                     ; 1414 			if (rezhim==1) {
5188  011f a101          	cp	a,#1
5189  0121 2609          	jrne	L5112
5190                     ; 1415 				tchk[2]=1;
5192  0123 35010006      	mov	_tchk+2,#1
5193                     ; 1416 				timemcp =0;
5195  0127 5f            	clrw	x
5196  0128 bf0f          	ldw	_timemcp,x
5197                     ; 1417 				timenct =0;
5199  012a bf0d          	ldw	_timenct,x
5200  012c               L5112:
5201                     ; 1420 			if (rezhim==2) {
5203  012c a102          	cp	a,#2
5204  012e 2607          	jrne	L7112
5205                     ; 1421 				tchk[0]=1;
5207  0130 35010004      	mov	_tchk,#1
5208                     ; 1422 				ind[0]=10;
5210  0134 cd0225        	call	LC034
5211  0137               L7112:
5212                     ; 1426 			if (rezhim==3) {
5214  0137 a103          	cp	a,#3
5215  0139 2607          	jrne	L1212
5216                     ; 1427 				tchk[2]=1;
5218  013b 35010006      	mov	_tchk+2,#1
5219                     ; 1428 				ind[0]=10;
5221  013f cd0225        	call	LC034
5222  0142               L1212:
5223                     ; 1433 			if (rezhim==5) esr_stage=0;
5225  0142 a105          	cp	a,#5
5226  0144 2602          	jrne	L3212
5229  0146 3f28          	clr	_esr_stage
5230  0148               L3212:
5231                     ; 1435 			timeshowrezhim = 2000; //show rezhim!
5233  0148 ae07d0        	ldw	x,#2000
5234  014b bf15          	ldw	_timeshowrezhim,x
5236  014d 2006          	jra	L5212
5237  014f               L7012:
5238                     ; 1437 		else if (kn[0]>KNONE) kn[0]=0;
5240  014f a105          	cp	a,#5
5241  0151 2502          	jrult	L5212
5244  0153 3f35          	clr	_kn
5245  0155               L5212:
5246                     ; 1441 		if (timenct==0) {
5248  0155 be0d          	ldw	x,_timenct
5249  0157 261b          	jrne	L1312
5250                     ; 1442 			nctdata();
5252  0159 cd0000        	call	_nctdata
5254                     ; 1443 			timenct = 500;
5256  015c ae01f4        	ldw	x,#500
5257  015f bf0d          	ldw	_timenct,x
5258                     ; 1444 			if (rezhim==0) {
5260  0161 b617          	ld	a,_rezhim
5261  0163 260f          	jrne	L1312
5262                     ; 1445 				shownumber(bmeT/10);
5264  0165 ae0014        	ldw	x,#_bmeT
5265  0168 cd0000        	call	c_ltor
5267  016b ae0084        	ldw	x,#L625
5268  016e cd021d        	call	LC033
5270                     ; 1446 				calclcd();
5272  0171 cd0000        	call	_calclcd
5274  0174               L1312:
5275                     ; 1450 		if (rezhim == 2) {
5277  0174 b617          	ld	a,_rezhim
5278  0176 a102          	cp	a,#2
5279  0178 2623          	jrne	L5312
5280                     ; 1451 			if (timeuv==0) {
5282  017a be11          	ldw	x,_timeuv
5283  017c 261f          	jrne	L5312
5284                     ; 1452 				timeuv=410;
5286  017e ae019a        	ldw	x,#410
5287  0181 bf11          	ldw	_timeuv,x
5288                     ; 1453 				uvdata();
5290  0183 cd0000        	call	_uvdata
5292                     ; 1462 				uindexMax = uindex;
5294  0186 be1e          	ldw	x,_uindex
5295  0188 bf1c          	ldw	_uindexMax,x
5296                     ; 1464 				tchk[0]=0;
5298  018a 3f04          	clr	_tchk
5299                     ; 1465 				tchk[1]=1;
5301  018c 35010005      	mov	_tchk+1,#1
5302                     ; 1466 				tchk[2]=0;
5304  0190 3f06          	clr	_tchk+2
5305                     ; 1467 				shownumber(uindexMax/10);
5307  0192 a60a          	ld	a,#10
5308  0194 62            	div	x,a
5309  0195 cd0000        	call	_shownumber
5311                     ; 1494 				calclcd();
5313  0198 cd0000        	call	_calclcd
5315  019b b617          	ld	a,_rezhim
5316  019d               L5312:
5317                     ; 1500 		if ((rezhim == 1) && (timemcp==0) )  {
5319  019d a101          	cp	a,#1
5320  019f 264f          	jrne	L1412
5322  01a1 be0f          	ldw	x,_timemcp
5323  01a3 264b          	jrne	L1412
5324                     ; 1501 			if (mcpdata()==0){
5326  01a5 cd0000        	call	_mcpdata
5328  01a8 5d            	tnzw	x
5329  01a9 2605          	jrne	L3412
5330                     ; 1503 				mcpT = 0;
5332  01ab 5f            	clrw	x
5333  01ac bf1a          	ldw	_mcpT+2,x
5334  01ae bf18          	ldw	_mcpT,x
5335  01b0               L3412:
5336                     ; 1505 			if (mcpT>9999) {
5338  01b0 ae0018        	ldw	x,#_mcpT
5339  01b3 cd0000        	call	c_ltor
5341  01b6 ae0088        	ldw	x,#L245
5342  01b9 cd0000        	call	c_lcmp
5344  01bc 2f15          	jrslt	L5412
5345                     ; 1506 				shownumber(mcpT/100);
5347  01be ae0018        	ldw	x,#_mcpT
5348  01c1 cd0000        	call	c_ltor
5350  01c4 ae0068        	ldw	x,#L231
5351  01c7 ad54          	call	LC033
5353                     ; 1507 				tchk[0]=0;
5355  01c9 3f04          	clr	_tchk
5356                     ; 1508 				tchk[1]=0;
5358  01cb 3f05          	clr	_tchk+1
5359                     ; 1509 				tchk[2]=1;
5361  01cd 35010006      	mov	_tchk+2,#1
5363  01d1 2013          	jra	L7412
5364  01d3               L5412:
5365                     ; 1514 				tchk[0]=0;
5367  01d3 3f04          	clr	_tchk
5368                     ; 1515 				tchk[1]=1;
5370  01d5 35010005      	mov	_tchk+1,#1
5371                     ; 1516 				tchk[2]=0;
5373  01d9 3f06          	clr	_tchk+2
5374                     ; 1517 				shownumber(mcpT/10);
5376  01db ae0018        	ldw	x,#_mcpT
5377  01de cd0000        	call	c_ltor
5379  01e1 ae0084        	ldw	x,#L625
5380  01e4 ad37          	call	LC033
5382  01e6               L7412:
5383                     ; 1520 			calclcd();
5385  01e6 cd0000        	call	_calclcd
5387                     ; 1521 			timemcp=500;
5389  01e9 ae01f4        	ldw	x,#500
5390  01ec bf0f          	ldw	_timemcp,x
5391  01ee b617          	ld	a,_rezhim
5392  01f0               L1412:
5393                     ; 1524 		if ((rezhim >= 3) && (timemcp==0) )  {
5395  01f0 a103          	cp	a,#3
5396  01f2 2517          	jrult	L1512
5398  01f4 be0f          	ldw	x,_timemcp
5399  01f6 2613          	jrne	L1512
5400                     ; 1525 			if (mcpdata()==0){
5402  01f8 cd0000        	call	_mcpdata
5404  01fb 5d            	tnzw	x
5405  01fc 2605          	jrne	L3512
5406                     ; 1527 				mcpT = 0;
5408  01fe 5f            	clrw	x
5409  01ff bf1a          	ldw	_mcpT+2,x
5410  0201 bf18          	ldw	_mcpT,x
5411  0203               L3512:
5412                     ; 1530 			calclcd();
5414  0203 cd0000        	call	_calclcd
5416                     ; 1531 			timemcp=500;
5418  0206 ae01f4        	ldw	x,#500
5419  0209 bf0f          	ldw	_timemcp,x
5420  020b               L1512:
5421                     ; 1534 		if (sleeptime==0) {
5423  020b be13          	ldw	x,_sleeptime
5424  020d 2703cc00f7    	jrne	L3012
5425                     ; 1535 			sleep();
5427  0212 cd0000        	call	_sleep
5429                     ; 1536 			sleeptime=60;
5431  0215 ae003c        	ldw	x,#60
5432  0218 bf13          	ldw	_sleeptime,x
5433  021a cc00f7        	jra	L3012
5434  021d               LC033:
5435  021d cd0000        	call	c_ldiv
5437  0220 be02          	ldw	x,c_lreg+2
5438  0222 cc0000        	jp	_shownumber
5439  0225               LC034:
5440  0225 350a0001      	mov	_ind,#10
5441                     ; 1429 				ind[1]=10;
5443  0229 350a0002      	mov	_ind+1,#10
5444                     ; 1430 				ind[2]=10;
5446  022d 350a0003      	mov	_ind+2,#10
5447  0231 81            	ret	
5512                     ; 1566 uint32_t LSIMeasurment(void)
5512                     ; 1567 {
5513                     .text:	section	.text,new
5514  0000               _LSIMeasurment:
5516  0000 520c          	subw	sp,#12
5517       0000000c      OFST:	set	12
5520                     ; 1569   uint32_t lsi_freq_hz = 0x0;
5522                     ; 1570   uint32_t fmaster = 0x0;
5524                     ; 1571   uint16_t ICValue1 = 0x0;
5526                     ; 1572   uint16_t ICValue2 = 0x0;
5528                     ; 1575   fmaster = CLK_GetClockFreq();
5530  0002 cd0000        	call	_CLK_GetClockFreq
5532  0005 96            	ldw	x,sp
5533  0006 1c0009        	addw	x,#OFST-3
5534  0009 cd0000        	call	c_rtol
5537                     ; 1578   AWU->CSR |= AWU_CSR_MSR;
5539  000c 721050f0      	bset	20720,#0
5540                     ; 1590 	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5542  0010 7211525c      	bres	21084,#0
5543                     ; 1593   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
5543                     ; 1594                           (uint8_t)(( (TIM1_ICSELECTION_DIRECTTI)) | ((uint8_t)( 0 << 4))));
5545  0014 c65258        	ld	a,21080
5546  0017 a40c          	and	a,#12
5547  0019 aa01          	or	a,#1
5548  001b c75258        	ld	21080,a
5549                     ; 1595 	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
5551  001e 7213525c      	bres	21084,#1
5552                     ; 1596 	TIM1->CCER1 |=  TIM1_CCER1_CC1E;
5554  0022 7210525c      	bset	21084,#0
5555                     ; 1600 	TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
5555                     ; 1601                           | (uint8_t)TIM1_ICPSC_DIV8);
5557  0026 c65258        	ld	a,21080
5558  0029 aa0c          	or	a,#12
5559  002b c75258        	ld	21080,a
5560                     ; 1605 	TIM1->CR1 |= TIM1_CR1_CEN;
5562  002e 72105250      	bset	21072,#0
5564  0032               L3122:
5565                     ; 1608   while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
5567  0032 72035255fb    	btjf	21077,#1,L3122
5568                     ; 1610   ICValue1 = TIM1_GetCapture1();
5570  0037 cd0000        	call	_TIM1_GetCapture1
5572  003a 1f05          	ldw	(OFST-7,sp),x
5574                     ; 1611   TIM1_ClearFlag(TIM1_FLAG_CC1);
5576  003c ae0002        	ldw	x,#2
5577  003f cd0000        	call	_TIM1_ClearFlag
5580  0042               L1222:
5581                     ; 1614   while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
5583  0042 72035255fb    	btjf	21077,#1,L1222
5584                     ; 1616   ICValue2 = TIM1_GetCapture1();
5586  0047 cd0000        	call	_TIM1_GetCapture1
5588  004a 1f07          	ldw	(OFST-5,sp),x
5590                     ; 1617   TIM1_ClearFlag(TIM1_FLAG_CC1);
5592  004c ae0002        	ldw	x,#2
5593  004f cd0000        	call	_TIM1_ClearFlag
5595                     ; 1620   TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5597  0052 7211525c      	bres	21084,#0
5598                     ; 1622   TIM1_Cmd(DISABLE);
5600  0056 4f            	clr	a
5601  0057 cd0000        	call	_TIM1_Cmd
5603                     ; 1653   lsi_freq_hz = (8 * fmaster) / (ICValue2 - ICValue1);
5605  005a 1e07          	ldw	x,(OFST-5,sp)
5606  005c 72f005        	subw	x,(OFST-7,sp)
5607  005f cd0000        	call	c_uitolx
5609  0062 96            	ldw	x,sp
5610  0063 5c            	incw	x
5611  0064 cd0000        	call	c_rtol
5614  0067 96            	ldw	x,sp
5615  0068 1c0009        	addw	x,#OFST-3
5616  006b cd0000        	call	c_ltor
5618  006e a603          	ld	a,#3
5619  0070 cd0000        	call	c_llsh
5621  0073 96            	ldw	x,sp
5622  0074 5c            	incw	x
5623  0075 cd0000        	call	c_ludv
5625  0078 96            	ldw	x,sp
5626  0079 1c0009        	addw	x,#OFST-3
5627  007c cd0000        	call	c_rtol
5630                     ; 1656   AWU->CSR &= (uint8_t)(~AWU_CSR_MSR);
5632  007f 721150f0      	bres	20720,#0
5633                     ; 1658  return (lsi_freq_hz);
5635  0083 96            	ldw	x,sp
5636  0084 1c0009        	addw	x,#OFST-3
5637  0087 cd0000        	call	c_ltor
5641  008a 5b0c          	addw	sp,#12
5642  008c 81            	ret	
5645                     	bsct
5646  002f               _timedelay:
5647  002f 0000          	dc.w	0
5680                     ; 1663 void Delay(u16 nCount)
5680                     ; 1664 {
5681                     .text:	section	.text,new
5682  0000               _Delay:
5686                     ; 1666     timedelay = nCount;
5688  0000 bf2f          	ldw	_timedelay,x
5690  0002               L7422:
5691                     ; 1668 		while (timedelay);
5693  0002 be2f          	ldw	x,_timedelay
5694  0004 26fc          	jrne	L7422
5695                     ; 1669 }
5698  0006 81            	ret	
5753                     ; 1671 void knint(u8 knum, u8 zn,u8 pin) {
5754                     .text:	section	.text,new
5755  0000               _knint:
5757  0000 89            	pushw	x
5758       00000000      OFST:	set	0
5761                     ; 1673 	if (knstatus[knum] && ((zn&pin) == 0)) {//кнопку нажали
5763  0001 9e            	ld	a,xh
5764  0002 5f            	clrw	x
5765  0003 97            	ld	xl,a
5766  0004 e634          	ld	a,(_knstatus,x)
5767  0006 2754          	jreq	L1032
5769  0008 7b02          	ld	a,(OFST+2,sp)
5770  000a 1505          	bcp	a,(OFST+5,sp)
5771  000c 264e          	jrne	L1032
5772                     ; 1674 		knstatus[knum] = zn&pin;
5774  000e 7b01          	ld	a,(OFST+1,sp)
5775  0010 5f            	clrw	x
5776  0011 97            	ld	xl,a
5777  0012 7b02          	ld	a,(OFST+2,sp)
5778  0014 1405          	and	a,(OFST+5,sp)
5779  0016 e734          	ld	(_knstatus,x),a
5780                     ; 1675 		if (kn[knum]>=KNONE) return; //еще не обработали предыдущее нажатие в основном цикле пропустим это нажатие
5782  0018 5f            	clrw	x
5783  0019 7b01          	ld	a,(OFST+1,sp)
5784  001b 97            	ld	xl,a
5785  001c e635          	ld	a,(_kn,x)
5786  001e a104          	cp	a,#4
5787  0020 2502          	jrult	L3032
5791  0022 85            	popw	x
5792  0023 81            	ret	
5793  0024               L3032:
5794                     ; 1677 		kn[knum]++;//колво нажатий плюс один
5796  0024 7b01          	ld	a,(OFST+1,sp)
5797  0026 5f            	clrw	x
5798  0027 97            	ld	xl,a
5799  0028 6c35          	inc	(_kn,x)
5800                     ; 1678 		if (kn[knum]==1) kntime[knum] = KNTIMELONG;//первый раз начнм замер времени
5802  002a ad7b          	call	LC036
5803  002c 4a            	dec	a
5804  002d 260b          	jrne	L5032
5807  002f 7b01          	ld	a,(OFST+1,sp)
5808  0031 5f            	clrw	x
5809  0032 97            	ld	xl,a
5810  0033 58            	sllw	x
5811  0034 90ae03e8      	ldw	y,#1000
5812  0038 ef32          	ldw	(_kntime,x),y
5813  003a               L5032:
5814                     ; 1680 		if (kn[knum]==2) {
5816  003a 7b01          	ld	a,(OFST+1,sp)
5817  003c ad69          	call	LC036
5818  003e a102          	cp	a,#2
5819  0040 261a          	jrne	L1032
5820                     ; 1681 			if (kntime[knum] > (KNTIMELONG-KNTIMETWO) ) kn[knum] = KNTWO;
5822  0042 7b01          	ld	a,(OFST+1,sp)
5823  0044 5f            	clrw	x
5824  0045 97            	ld	xl,a
5825  0046 58            	sllw	x
5826  0047 9093          	ldw	y,x
5827  0049 90ee32        	ldw	y,(_kntime,y)
5828  004c 90a302bd      	cpw	y,#701
5829  0050 5f            	clrw	x
5830  0051 97            	ld	xl,a
5831  0052 2504          	jrult	L1132
5834  0054 a606          	ld	a,#6
5836  0056 2002          	jp	LC035
5837  0058               L1132:
5838                     ; 1682 			else kn[knum] = KNONE;
5840  0058 a604          	ld	a,#4
5841  005a               LC035:
5842  005a e735          	ld	(_kn,x),a
5843  005c               L1032:
5844                     ; 1686 	if ((kn[knum]==1) && (kntime[knum]==0)) kn[knum]=KNLONG;
5846  005c 7b01          	ld	a,(OFST+1,sp)
5847  005e ad47          	call	LC036
5848  0060 4a            	dec	a
5849  0061 2613          	jrne	L5132
5851  0063 7b01          	ld	a,(OFST+1,sp)
5852  0065 5f            	clrw	x
5853  0066 97            	ld	xl,a
5854  0067 58            	sllw	x
5855  0068 e633          	ld	a,(_kntime+1,x)
5856  006a ea32          	or	a,(_kntime,x)
5857  006c 2608          	jrne	L5132
5860  006e 7b01          	ld	a,(OFST+1,sp)
5861  0070 5f            	clrw	x
5862  0071 97            	ld	xl,a
5863  0072 a605          	ld	a,#5
5864  0074 e735          	ld	(_kn,x),a
5865  0076               L5132:
5866                     ; 1687 	if ((kn[knum]==1) && (kntime[knum]<(KNTIMELONG-KNTIMETWO)) && zn&pin) kn[knum]=KNONE;
5868  0076 7b01          	ld	a,(OFST+1,sp)
5869  0078 ad2d          	call	LC036
5870  007a 4a            	dec	a
5871  007b 261e          	jrne	L7132
5873  007d 7b01          	ld	a,(OFST+1,sp)
5874  007f 5f            	clrw	x
5875  0080 97            	ld	xl,a
5876  0081 58            	sllw	x
5877  0082 9093          	ldw	y,x
5878  0084 90ee32        	ldw	y,(_kntime,y)
5879  0087 90a302bc      	cpw	y,#700
5880  008b 240e          	jruge	L7132
5882  008d 7b02          	ld	a,(OFST+2,sp)
5883  008f 1505          	bcp	a,(OFST+5,sp)
5884  0091 2708          	jreq	L7132
5887  0093 7b01          	ld	a,(OFST+1,sp)
5888  0095 5f            	clrw	x
5889  0096 97            	ld	xl,a
5890  0097 a604          	ld	a,#4
5891  0099 e735          	ld	(_kn,x),a
5892  009b               L7132:
5893                     ; 1689 	knstatus[knum] = zn&pin;
5895  009b 7b01          	ld	a,(OFST+1,sp)
5896  009d 5f            	clrw	x
5897  009e 97            	ld	xl,a
5898  009f 7b02          	ld	a,(OFST+2,sp)
5899  00a1 1405          	and	a,(OFST+5,sp)
5900  00a3 e734          	ld	(_knstatus,x),a
5901                     ; 1691 }	 
5904  00a5 85            	popw	x
5905  00a6 81            	ret	
5906  00a7               LC036:
5907  00a7 5f            	clrw	x
5908  00a8 97            	ld	xl,a
5909  00a9 e635          	ld	a,(_kn,x)
5910  00ab 81            	ret	
5913                     	bsct
5914  0031               _timeuvmax:
5915  0031 0000          	dc.w	0
5916  0033               _timesec:
5917  0033 0000          	dc.w	0
5973                     ; 1697 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
5973                     ; 1698  {
5975                     .text:	section	.text,new
5976  0000               f_TIM4_UPD_OVF_IRQHandler:
5978  0000 8a            	push	cc
5979  0001 84            	pop	a
5980  0002 a4bf          	and	a,#191
5981  0004 88            	push	a
5982  0005 86            	pop	cc
5983       00000002      OFST:	set	2
5984  0006 3b0002        	push	c_x+2
5985  0009 be00          	ldw	x,c_x
5986  000b 89            	pushw	x
5987  000c 3b0002        	push	c_y+2
5988  000f be00          	ldw	x,c_y
5989  0011 89            	pushw	x
5990  0012 89            	pushw	x
5993                     ; 1702 	current_millis++;
5995  0013 ae0018        	ldw	x,#_current_millis
5996  0016 a601          	ld	a,#1
5997  0018 cd0000        	call	c_lgadc
5999                     ; 1704 	if (timedelay) timedelay--;
6001  001b be2f          	ldw	x,_timedelay
6002  001d 2703          	jreq	L3432
6005  001f 5a            	decw	x
6006  0020 bf2f          	ldw	_timedelay,x
6007  0022               L3432:
6008                     ; 1706 	if (timenct) timenct--;
6010  0022 be0d          	ldw	x,_timenct
6011  0024 2703          	jreq	L5432
6014  0026 5a            	decw	x
6015  0027 bf0d          	ldw	_timenct,x
6016  0029               L5432:
6017                     ; 1707 	if (timemcp) timemcp--;
6019  0029 be0f          	ldw	x,_timemcp
6020  002b 2703          	jreq	L7432
6023  002d 5a            	decw	x
6024  002e bf0f          	ldw	_timemcp,x
6025  0030               L7432:
6026                     ; 1708 	if (timeuv) timeuv--;
6028  0030 be11          	ldw	x,_timeuv
6029  0032 2703          	jreq	L1532
6032  0034 5a            	decw	x
6033  0035 bf11          	ldw	_timeuv,x
6034  0037               L1532:
6035                     ; 1709 	if (timesec) timesec--;
6037  0037 be33          	ldw	x,_timesec
6038  0039 2703          	jreq	L3532
6041  003b 5a            	decw	x
6042  003c bf33          	ldw	_timesec,x
6043  003e               L3532:
6044                     ; 1711 	if (timesec==0) {
6046  003e be33          	ldw	x,_timesec
6047  0040 260c          	jrne	L5532
6048                     ; 1712 		timesec=1000;
6050  0042 ae03e8        	ldw	x,#1000
6051  0045 bf33          	ldw	_timesec,x
6052                     ; 1714 		if(sleeptime) sleeptime--;
6054  0047 be13          	ldw	x,_sleeptime
6055  0049 2703          	jreq	L5532
6058  004b 5a            	decw	x
6059  004c bf13          	ldw	_sleeptime,x
6060  004e               L5532:
6061                     ; 1717 	if (timeuvmax) timeuvmax--;
6063  004e be31          	ldw	x,_timeuvmax
6064  0050 2705          	jreq	L1632
6067  0052 5a            	decw	x
6068  0053 bf31          	ldw	_timeuvmax,x
6070  0055 2008          	jra	L3632
6071  0057               L1632:
6072                     ; 1719 			timeuvmax=10000;
6074  0057 ae2710        	ldw	x,#10000
6075  005a bf31          	ldw	_timeuvmax,x
6076                     ; 1720 			uindexMax =0;
6078  005c 5f            	clrw	x
6079  005d bf1c          	ldw	_uindexMax,x
6080  005f               L3632:
6081                     ; 1727 		if(kndtime) kndtime--;
6083  005f b60c          	ld	a,_kndtime
6084  0061 2704          	jreq	LC037
6087  0063 3a0c          	dec	_kndtime
6088                     ; 1728 		if (kndtime==0) {
6090  0065 2616          	jrne	L7632
6091  0067               LC037:
6092                     ; 1730 			kndtime = KNDTIME;
6094  0067 3532000c      	mov	_kndtime,#50
6095                     ; 1732 			pd = GPIO_ReadInputData(GPIOA);
6097  006b ae5000        	ldw	x,#20480
6098  006e cd0000        	call	_GPIO_ReadInputData
6100  0071 6b01          	ld	(OFST-1,sp),a
6102                     ; 1733 			knint(0, pd, GPIO_PIN_2);
6104  0073 4b04          	push	#4
6105  0075 7b02          	ld	a,(OFST+0,sp)
6106  0077 5f            	clrw	x
6107  0078 97            	ld	xl,a
6108  0079 cd0000        	call	_knint
6110  007c 84            	pop	a
6111  007d               L7632:
6112                     ; 1735 		for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
6114  007d 0f02          	clr	(OFST+0,sp)
6116  007f               L1732:
6119  007f 7b02          	ld	a,(OFST+0,sp)
6120  0081 5f            	clrw	x
6121  0082 97            	ld	xl,a
6122  0083 58            	sllw	x
6123  0084 e633          	ld	a,(_kntime+1,x)
6124  0086 ea32          	or	a,(_kntime,x)
6125  0088 2708          	jreq	L7732
6128  008a 9093          	ldw	y,x
6129  008c ee32          	ldw	x,(_kntime,x)
6130  008e 5a            	decw	x
6131  008f 90ef32        	ldw	(_kntime,y),x
6132  0092               L7732:
6135  0092 0c02          	inc	(OFST+0,sp)
6139  0094 27e9          	jreq	L1732
6140                     ; 1738 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
6142  0096 a601          	ld	a,#1
6143  0098 cd0000        	call	_TIM4_ClearITPendingBit
6145                     ; 1740  }
6148  009b 5b02          	addw	sp,#2
6149  009d 85            	popw	x
6150  009e bf00          	ldw	c_y,x
6151  00a0 320002        	pop	c_y+2
6152  00a3 85            	popw	x
6153  00a4 bf00          	ldw	c_x,x
6154  00a6 320002        	pop	c_x+2
6155  00a9 80            	iret	
6157                     	bsct
6158  0035               _lcdframe:
6159  0035 00            	dc.b	0
6160  0036               _time2:
6161  0036 00            	dc.b	0
6232                     ; 1745  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
6232                     ; 1746  {
6233                     .text:	section	.text,new
6234  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
6236  0000 8a            	push	cc
6237  0001 84            	pop	a
6238  0002 a4bf          	and	a,#191
6239  0004 88            	push	a
6240  0005 86            	pop	cc
6241       00000001      OFST:	set	1
6242  0006 3b0002        	push	c_x+2
6243  0009 be00          	ldw	x,c_x
6244  000b 89            	pushw	x
6245  000c 3b0002        	push	c_y+2
6246  000f be00          	ldw	x,c_y
6247  0011 89            	pushw	x
6250                     ; 1755 	lcdframe++;
6252  0012 3c35          	inc	_lcdframe
6253  0014 88            	push	a
6254                     ; 1756 	if (lcdframe==75) lcdframe = 0;
6256  0015 b635          	ld	a,_lcdframe
6257  0017 a14b          	cp	a,#75
6258  0019 2603          	jrne	L7242
6261  001b 4f            	clr	a
6262  001c b735          	ld	_lcdframe,a
6263  001e               L7242:
6264                     ; 1757 	ind = lcdframe;	
6266  001e 6b01          	ld	(OFST+0,sp),a
6268                     ; 1766 	if (readytosleep==0) {
6270  0020 3d2e          	tnz	_readytosleep
6271  0022 2634          	jrne	L1342
6272                     ; 1767 		if ((ind < 16) && (blockcopylcd==0)) {
6274  0024 a110          	cp	a,#16
6275  0026 241c          	jruge	L3342
6277  0028 3d00          	tnz	_blockcopylcd
6278  002a 2618          	jrne	L3342
6279                     ; 1769 			GPIOA->ODR = lcdm[ind].porta_odr;
6281  002c 97            	ld	xl,a
6282  002d a603          	ld	a,#3
6283  002f 42            	mul	x,a
6284  0030 e637          	ld	a,(_lcdm+1,x)
6285  0032 c75000        	ld	20480,a
6286                     ; 1770 			GPIOD->ODR = lcdm[ind].portd_odr;
6288  0035 7b01          	ld	a,(OFST+0,sp)
6289  0037 97            	ld	xl,a
6290  0038 a603          	ld	a,#3
6291  003a 42            	mul	x,a
6292  003b e638          	ld	a,(_lcdm+2,x)
6293  003d c7500f        	ld	20495,a
6294                     ; 1771 			GPIOC->ODR = lcdm[ind].portc_odr;
6296  0040 e636          	ld	a,(_lcdm,x)
6298  0042 2011          	jpf	LC038
6299  0044               L3342:
6300                     ; 1774 				GPIOA->ODR &= ~(ALL_PORTA);
6302  0044 72135000      	bres	20480,#1
6303                     ; 1775 				GPIOD->ODR &= ~(ALL_PORTD);
6305  0048 c6500f        	ld	a,20495
6306  004b a483          	and	a,#131
6307  004d c7500f        	ld	20495,a
6308                     ; 1776 				GPIOC->ODR &= ~(ALL_PORTC);
6310  0050 c6500a        	ld	a,20490
6311  0053 a407          	and	a,#7
6312  0055               LC038:
6313  0055 c7500a        	ld	20490,a
6314  0058               L1342:
6315                     ; 1780 	if (timeshowrezhim) timeshowrezhim--;
6317  0058 be15          	ldw	x,_timeshowrezhim
6318  005a 2703          	jreq	L7342
6321  005c 5a            	decw	x
6322  005d bf15          	ldw	_timeshowrezhim,x
6323  005f               L7342:
6324                     ; 1782 	if (time2) time2--;
6326  005f b636          	ld	a,_time2
6327  0061 2708          	jreq	LC039
6330  0063 3a36          	dec	_time2
6331                     ; 1783 	if (time2==0) {
6333  0065 2704acf000f0  	jrne	L3442
6334  006b               LC039:
6335                     ; 1784 		time2=2;
6337  006b 35020036      	mov	_time2,#2
6338                     ; 1786 		if (timedelay) timedelay--;
6340  006f be2f          	ldw	x,_timedelay
6341  0071 2703          	jreq	L5442
6344  0073 5a            	decw	x
6345  0074 bf2f          	ldw	_timedelay,x
6346  0076               L5442:
6347                     ; 1788 		if (timenct) timenct--;
6349  0076 be0d          	ldw	x,_timenct
6350  0078 2703          	jreq	L7442
6353  007a 5a            	decw	x
6354  007b bf0d          	ldw	_timenct,x
6355  007d               L7442:
6356                     ; 1789 		if (timemcp) timemcp--;
6358  007d be0f          	ldw	x,_timemcp
6359  007f 2703          	jreq	L1542
6362  0081 5a            	decw	x
6363  0082 bf0f          	ldw	_timemcp,x
6364  0084               L1542:
6365                     ; 1790 		if (timeuv) timeuv--;
6367  0084 be11          	ldw	x,_timeuv
6368  0086 2703          	jreq	L3542
6371  0088 5a            	decw	x
6372  0089 bf11          	ldw	_timeuv,x
6373  008b               L3542:
6374                     ; 1793 		if (timesec) timesec--;
6376  008b be33          	ldw	x,_timesec
6377  008d 2703          	jreq	L5542
6380  008f 5a            	decw	x
6381  0090 bf33          	ldw	_timesec,x
6382  0092               L5542:
6383                     ; 1795 		if (timesec==0) {
6385  0092 be33          	ldw	x,_timesec
6386  0094 2612          	jrne	L7542
6387                     ; 1796 			timesec=1000;
6389  0096 ae03e8        	ldw	x,#1000
6390  0099 bf33          	ldw	_timesec,x
6391                     ; 1798 			if (esr_time) esr_time--;
6393  009b b629          	ld	a,_esr_time
6394  009d 2702          	jreq	L1642
6397  009f 3a29          	dec	_esr_time
6398  00a1               L1642:
6399                     ; 1800 			if(sleeptime) sleeptime--;
6401  00a1 be13          	ldw	x,_sleeptime
6402  00a3 2703          	jreq	L7542
6405  00a5 5a            	decw	x
6406  00a6 bf13          	ldw	_sleeptime,x
6407  00a8               L7542:
6408                     ; 1804 		if (timeuvmax) timeuvmax--;
6410  00a8 be31          	ldw	x,_timeuvmax
6411  00aa 2705          	jreq	L5642
6414  00ac 5a            	decw	x
6415  00ad bf31          	ldw	_timeuvmax,x
6417  00af 2008          	jra	L7642
6418  00b1               L5642:
6419                     ; 1806 				timeuvmax=10000;
6421  00b1 ae2710        	ldw	x,#10000
6422  00b4 bf31          	ldw	_timeuvmax,x
6423                     ; 1807 				uindexMax =0;
6425  00b6 5f            	clrw	x
6426  00b7 bf1c          	ldw	_uindexMax,x
6427  00b9               L7642:
6428                     ; 1813 			if(kndtime) kndtime--;
6430  00b9 b60c          	ld	a,_kndtime
6431  00bb 2704          	jreq	LC040
6434  00bd 3a0c          	dec	_kndtime
6435                     ; 1814 			if (kndtime==0) {
6437  00bf 2616          	jrne	L3742
6438  00c1               LC040:
6439                     ; 1816 				kndtime = KNDTIME;
6441  00c1 3532000c      	mov	_kndtime,#50
6442                     ; 1818 				pd = GPIO_ReadInputData(GPIOA);
6444  00c5 ae5000        	ldw	x,#20480
6445  00c8 cd0000        	call	_GPIO_ReadInputData
6447  00cb 6b01          	ld	(OFST+0,sp),a
6449                     ; 1819 				knint(0, pd, GPIO_PIN_2);
6451  00cd 4b04          	push	#4
6452  00cf 7b02          	ld	a,(OFST+1,sp)
6453  00d1 5f            	clrw	x
6454  00d2 97            	ld	xl,a
6455  00d3 cd0000        	call	_knint
6457  00d6 84            	pop	a
6458  00d7               L3742:
6459                     ; 1821 			for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
6461  00d7 0f01          	clr	(OFST+0,sp)
6463  00d9               L5742:
6466  00d9 7b01          	ld	a,(OFST+0,sp)
6467  00db 5f            	clrw	x
6468  00dc 97            	ld	xl,a
6469  00dd 58            	sllw	x
6470  00de e633          	ld	a,(_kntime+1,x)
6471  00e0 ea32          	or	a,(_kntime,x)
6472  00e2 2708          	jreq	L3052
6475  00e4 9093          	ldw	y,x
6476  00e6 ee32          	ldw	x,(_kntime,x)
6477  00e8 5a            	decw	x
6478  00e9 90ef32        	ldw	(_kntime,y),x
6479  00ec               L3052:
6482  00ec 0c01          	inc	(OFST+0,sp)
6486  00ee 27e9          	jreq	L5742
6487  00f0               L3442:
6488                     ; 1829 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
6490  00f0 a601          	ld	a,#1
6491  00f2 cd0000        	call	_TIM2_ClearITPendingBit
6493                     ; 1830  }
6496  00f5 84            	pop	a
6497  00f6 85            	popw	x
6498  00f7 bf00          	ldw	c_y,x
6499  00f9 320002        	pop	c_y+2
6500  00fc 85            	popw	x
6501  00fd bf00          	ldw	c_x,x
6502  00ff 320002        	pop	c_x+2
6503  0102 80            	iret	
7078                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
7079                     	xdef	_time2
7080                     	xdef	_lcdframe
7081                     	xdef	f_TIM4_UPD_OVF_IRQHandler
7082                     	xdef	_timesec
7083                     	xdef	_timeuvmax
7084                     	xdef	_knint
7085                     	xdef	_timedelay
7086                     	xdef	_main
7087                     	xdef	_calclcd
7088                     	xdef	_addnum
7089                     	xdef	_cifra
7090                     	xdef	_sleep
7091                     	xdef	_readytosleep
7092                     	xdef	_mcpdata
7093                     	switch	.ubsct
7094  0000               _tmcpT:
7095  0000 00000000      	ds.b	4
7096                     	xdef	_tmcpT
7097                     	xdef	_esr_u1
7098                     	xdef	_esr_time
7099                     	xdef	_esr_stage
7100  0004               _u2:
7101  0004 00000000      	ds.b	4
7102                     	xdef	_u2
7103  0008               _u1:
7104  0008 00000000      	ds.b	4
7105                     	xdef	_u1
7106                     	xdef	_mcpinit
7107                     	xdef	_mypow
7108                     	xdef	_uvdata
7109  000c               _uvcomp2:
7110  000c 0000          	ds.b	2
7111                     	xdef	_uvcomp2
7112  000e               _uvcomp1:
7113  000e 0000          	ds.b	2
7114                     	xdef	_uvcomp1
7115  0010               _uvb:
7116  0010 0000          	ds.b	2
7117                     	xdef	_uvb
7118  0012               _uva:
7119  0012 0000          	ds.b	2
7120                     	xdef	_uva
7121                     	xdef	_readUVword
7122                     	xdef	_uvinit
7123                     	xdef	_nctdata
7124                     	xdef	_nctinit
7125                     	xdef	_I2C_readnbyte
7126                     	xdef	_I2C_writenbyte
7127                     	xdef	_shift_and_mul_utoa16
7128                     	xdef	_shownumber
7129  0014               _bmeT:
7130  0014 00000000      	ds.b	4
7131                     	xdef	_bmeT
7132  0018               _mcpT:
7133  0018 00000000      	ds.b	4
7134                     	xdef	_mcpT
7135                     	xdef	_cKf
7136                     	xdef	_cKm
7137                     	xdef	_cK
7138                     	xdef	_fansot
7139                     	xdef	_fandes
7140                     	xdef	_kn2old
7141                     	xdef	_kn1old
7142                     	xdef	_kn2
7143                     	xdef	_kn1
7144  001c               _uindexMax:
7145  001c 0000          	ds.b	2
7146                     	xdef	_uindexMax
7147  001e               _uindex:
7148  001e 0000          	ds.b	2
7149                     	xdef	_uindex
7150  0020               _buff:
7151  0020 000000000000  	ds.b	15
7152                     	xdef	_buff
7153  002f               _blueen:
7154  002f 00            	ds.b	1
7155                     	xdef	_blueen
7156                     	xdef	_current_millis
7157                     	xdef	_LSIMeasurment
7158                     	xdef	_Delay
7159  0030               _min:
7160  0030 00            	ds.b	1
7161                     	xdef	_min
7162  0031               _sec:
7163  0031 00            	ds.b	1
7164                     	xdef	_sec
7165                     	xdef	_rezhim
7166                     	xdef	_timeshowrezhim
7167                     	xdef	_sleeptime
7168                     	xdef	_timeuv
7169                     	xdef	_timemcp
7170                     	xdef	_timenct
7171                     	xdef	_kndtime
7172  0032               _kntime:
7173  0032 0000          	ds.b	2
7174                     	xdef	_kntime
7175  0034               _knstatus:
7176  0034 00            	ds.b	1
7177                     	xdef	_knstatus
7178  0035               _kn:
7179  0035 00            	ds.b	1
7180                     	xdef	_kn
7181                     	xdef	_sch
7182                     	xdef	_numind
7183                     	xdef	_tchk
7184                     	xdef	_ind
7185  0036               _lcdm:
7186  0036 000000000000  	ds.b	96
7187                     	xdef	_lcdm
7188  0096               _lcdpins:
7189  0096 000000000000  	ds.b	36
7190                     	xdef	_lcdpins
7191                     	xdef	_blockcopylcd
7192  00ba               _com:
7193  00ba 00000000      	ds.b	4
7194                     	xdef	_com
7195                     	xref	_TIM4_ClearITPendingBit
7196                     	xref	_TIM2_ClearITPendingBit
7197                     	xref	_TIM2_ClearFlag
7198                     	xref	_TIM2_ITConfig
7199                     	xref	_TIM2_Cmd
7200                     	xref	_TIM2_TimeBaseInit
7201                     	xref	_TIM1_ClearFlag
7202                     	xref	_TIM1_GetCapture1
7203                     	xref	_TIM1_Cmd
7204                     	xref	_I2C_GetFlagStatus
7205                     	xref	_I2C_CheckEvent
7206                     	xref	_I2C_Send7bitAddress
7207                     	xref	_I2C_ReceiveData
7208                     	xref	_I2C_AcknowledgeConfig
7209                     	xref	_I2C_GenerateSTOP
7210                     	xref	_I2C_Cmd
7211                     	xref	_I2C_Init
7212                     	xref	_GPIO_ReadInputData
7213                     	xref	_GPIO_WriteLow
7214                     	xref	_GPIO_WriteHigh
7215                     	xref	_GPIO_Init
7216                     	xref	_EXTI_SetExtIntSensitivity
7217                     	xref	_CLK_GetClockFreq
7218                     	xref	_CLK_HSIPrescalerConfig
7219                     	switch	.const
7220  008c               L1251:
7221  008c 41200000      	dc.w	16672,0
7222  0090               L3641:
7223  0090 40400000      	dc.w	16448,0
7224  0094               L3541:
7225  0094 42ce0000      	dc.w	17102,0
7226  0098               L1441:
7227  0098 40199999      	dc.w	16409,-26215
7228  009c               L3431:
7229  009c 42800000      	dc.w	17024,0
7230  00a0               L3121:
7231  00a0 40c00000      	dc.w	16576,0
7232  00a4               L3021:
7233  00a4 40000000      	dc.w	16384,0
7234  00a8               L3711:
7235  00a8 42c80000      	dc.w	17096,0
7236  00ac               L5511:
7237  00ac 3b29cdc4      	dc.w	15145,-12860
7238  00b0               L5411:
7239  00b0 3f4b7077      	dc.w	16203,28791
7240  00b4               L5311:
7241  00b4 40292574      	dc.w	16425,9588
7242  00b8               L5211:
7243  00b8 3abf7f06      	dc.w	15039,32518
7244  00bc               L5111:
7245  00bc 3f1f67e3      	dc.w	16159,26595
7246  00c0               L5011:
7247  00c0 3fdda28e      	dc.w	16349,-23922
7248                     	xref.b	c_lreg
7249                     	xref.b	c_x
7250                     	xref.b	c_y
7270                     	xref	c_lgadc
7271                     	xref	c_ludv
7272                     	xref	c_uitolx
7273                     	xref	c_imul
7274                     	xref	c_fgadd
7275                     	xref	c_ftol
7276                     	xref	c_fcmp
7277                     	xref	c_ctof
7278                     	xref	c_fgneg
7279                     	xref	c_fgdiv
7280                     	xref	c_itof
7281                     	xref	c_lsub
7282                     	xref	c_smul
7283                     	xref	c_lgneg
7284                     	xref	c_ltof
7285                     	xref	c_umul
7286                     	xref	c_llsh
7287                     	xref	c_fgmul
7288                     	xref	c_ftoi
7289                     	xref	c_fdiv
7290                     	xref	c_fadd
7291                     	xref	c_fsub
7292                     	xref	c_fmul
7293                     	xref	c_uitof
7294                     	xref	c_ldiv
7295                     	xref	c_lmul
7296                     	xref	c_lrsh
7297                     	xref	c_lor
7298                     	xref	c_itolx
7299                     	xref	c_lcmp
7300                     	xref	c_rtol
7301                     	xref	c_ladd
7302                     	xref	c_ltor
7303                     	end
