; ########## EXPERIMENT FOR PIC16F877  ############################

; FOR PIC 16F877         40 PIN DEVICE
; RESONATOR              10MHz
; WATCHDOG               DISABLED
; CODE PROTECTION        OFF


        TITLE "COUNT AND SEND TO PORTD" 

	    list 	p = 16f877
    	include	<p16f877.inc>



DELAY_ULT	EQU 	H'30'
DELAY_HI	EQU 	H'31'
DELAY_LO	EQU 	H'32'
COUNT		EQU		H'33'



	ORG 	H'00'
	NOP
	GOTO	START


;
; ********** THE ROUTINES START HERE *********
;
        ORG     0x20
START	
      BCF 	STATUS,RP0	;BANK 0
    	CLRF	PORTD 		  ;INITIALIZE PORTC BY CLEARING OUTPUT DATA LATCHES
    	BSF 	STATUS,RP0	;SELECT BANK1
    	MOVLW	0X00	 	    ;W REG =00
    	MOVWF	TRISD		    ;SET RD AS OUTPUTS
    	BCF 	STATUS,RP0	;BANK 0
    	CLRF    COUNT		  ;COUNT = 0

;**************************
MAIN   
      MOVF  COUNT,W		;GET COUNT
	    MOVWF	PORTD		  ;OUTPUT W REG TO PORTB
	    CALL	DELAY     ;DELAY
	    CALL	DELAY     ;DELAY
    	INCF  COUNT     ;COUNT = COUNT + 1
    	GOTO	MAIN

;************************************
;SUBROUTINES
;************************************
;
DELAY
	MOVLW	0X01
	MOVWF	DELAY_LO
	MOVLW	0X71
	MOVWF	DELAY_HI
	MOVLW	0XFF
	MOVWF	DELAY_ULT

BIG

OUTER

INNER
	INCFSZ	DELAY_LO
	GOTO	INNER
	INCFSZ	DELAY_HI
	GOTO	OUTER
	INCFSZ	DELAY_ULT
	GOTO	INNER

    RETURN


	END

