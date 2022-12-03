;/*Copyright (C) 2022 Boyzo Ramirez Carlos|©-Archivo Historico Digitalizado Charlie Ramirez Animation Studios de Mexico
;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO-FACULTAD DE ESTUDIOS SUPERIORES ARAGON-INGENIERIA ELECTRICA ELECTRONICA.
;Lector Puerto B con Salida USART, Version A: 2022-12-02 20:19:36
;CODIGO BAJO "LICENCIA MIT". PARA CODIGO ABIERTO (OPEN SOURCE  https://opensource.org/licenses/MIT).
; T6USARTBRCA.asm
;
; Created: 2022-12-02 20:19:36
; Author : CharlieUSTCN1

		RJMP	start
		.ORG	0X28
		RJMP	TX
start:	LDI	R16,0XFF
		LDI	R17,0X08
		OUT	SPL,R16
		OUT	SPH,R17
		SBI	DDRD,1
		LDI	R18,0X0C
		LDI	R19,0X00
	
	;PBPUP   [AS IN]DDRB =0x00  PORTB=0XFF [PUP]
		OUT	DDRB,R19 ;PBIN
		OUT	PORTB,R16 ;BPUP
		IN	R23,PINB;READB
		OUT PORTD,R23;outD

		STS	UBRR0L,	R18
		STS	UBRR0H,	R19
		LDI	R20,0X22
		STS	UCSR0A,	R20
		LDI	R21,0X06
		STS	UCSR0C,	R21
		LDI	R22,0X48
		STS	UCSR0B,	R22
		SEI
		STS	UDR0,R23
wait:	RJMP wait

TX:		RCALL	seg
		IN	R23,PINB;READB
		STS	UDR0,R23
		RETI
seg:	ldi  r24, 6
    ldi  r25, 19
    ldi  r26, 174
L1: dec  r26
    brne L1
    dec  r25
    brne L1
    dec  r24
    brne L1
    rjmp PC+1

		RET