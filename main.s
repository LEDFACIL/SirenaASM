// Includes -------------------------------------------------------------------    

PROCESSOR 16F628A
#include <xc.inc>
    
// Fuses ----------------------------------------------------------------------   

  CONFIG  FOSC = INTOSCIO ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF      ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF     ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = OFF     ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
  CONFIG  BOREN = OFF     ; Brown-out Detect Enable bit (BOD disabled)
  CONFIG  LVP = OFF       ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
  CONFIG  CPD = ON        ; Data EE Memory Code Protection bit (Data memory code-protected)
  CONFIG  CP = ON         ; Flash Program Memory Code Protection bit (0000h to 07FFh code-protected)

// Macros ---------------------------------------------------------------------

bank0 macro         ; cambio de banco de memoria RAM a banco 0
    bcf STATUS, 5
    bcf STATUS, 6
    endm
  
bank1 macro         
    bsf STATUS, 5
    bcf STATUS, 6
    endm
    
// Variables ------------------------------------------------------------------
    
psect udata    ; "program section"
aux:           ; nombre de la variable  
    DS 1       ; espacio que se le reserva en Bytes 

massa:
    DS 1

referencia:
    DS 1

contador:
    DS 1
    
buchon:
    DS 1
    
// Vector reset ---------------------------------------------------------------
    
psect resetvector, class=CODE, delta=2
ORG 0x0000
resetvector:
    goto main    ; salta a la etiqueta "main"
    
// Programa principal --------------------------------------------------------- 
  
psect CODE, delta=2
main:
    bank0
    clrf PORTA        ; limpia (pone en 0) el puerto A
    clrf PORTB
    movlw 0x7         ; mueve un número "l"iteral al registro "w"
    movwf CMCON       ; mueve el contenido de "w" a un registro (CMCON)
    bank1
    movlw 00000110B
    movwf TRISB
    movlw 11110000B
    movwf TRISA    
    bank0

iniciando:    
    movlw 140
    movwf referencia
    clrf buchon

// Audiopenetrante ------------------------------------------------------------    
    
b_subida_audiopen:
    clrf contador 
    
    l_subida_audiopen:    
	movlw 00001000B   
	movwf PORTA           
	call consumo          ; llama a la subrutina "consumo"
	call consumo
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movlw 00000100B  
	movwf PORTA
	call consumo
	call consumo
	
	incf contador, f
	movlw 20
	subwf contador, W        ; le resta el contenido de "contador" a "W" 
	btfss STATUS, 2          ; salta si el resultado de la resta es 0
    goto l_subida_audiopen
        
	decf referencia, f
	movlw 53
	subwf referencia, W 
	btfss STATUS, 2
goto b_subida_audiopen
		
b_bajada_audiopen:
    clrf contador 
    
    l_bajada_audiopen:    
	movlw 0b00001000   
	movwf PORTA           
	call consumo	
	call consumo
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movlw 0b00000100  
	movwf PORTA
	call consumo
	call consumo
	
	incf contador, f
	movlw 20
	subwf contador, W
	btfss STATUS, 2  
    goto l_bajada_audiopen
        
	incf referencia, f
	movlw 140
	subwf referencia, W 
	btfss STATUS, 2    	
goto b_bajada_audiopen

incf buchon, f
movlw 2
subwf buchon, W
btfss STATUS, 2  
goto b_subida_audiopen

// Ululante -------------------------------------------------------------------
clrf buchon

b_subida_ululante:
    clrf contador ; 
    
    l_subida_ululante:    
	movlw 0b00001000   
	movwf PORTA           
	call consumo
	call consumo
	movlw 0b00000100  
	movwf PORTA
	call consumo
	call consumo	
            
	decf referencia, f
	movlw 53
	subwf referencia, W 
	btfss STATUS, 2  
goto b_subida_ululante
		
b_bajada_ululante:
    clrf contador ; 
    
    l_bajada_ululante:    
	movlw 0b00001000   
	movwf PORTA           
	call consumo	
	call consumo	
	movlw 0b00000100  
	movwf PORTA
	call consumo
	call consumo
	
	incf referencia, f
	movlw 139
	subwf referencia, W 
	btfss STATUS, 2    	
goto b_bajada_ululante

incf buchon, f
movlw 16
subwf buchon, W
btfss STATUS, 2  
goto b_subida_ululante
	
// Bitonal --------------------------------------------------------------------
clrf buchon
clearmassa1:
clrf massa

movlw 100
movwf referencia  	

bt1:
clrf contador
    
    bitonal_t1:    
	movlw 0b00001000   
	movwf PORTA           
	call consumo
	call consumo
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movlw 0b00000100  
	movwf PORTA
	call consumo
	call consumo	
	incf contador, f
	movlw 255
	subwf contador, W
	btfss STATUS, 2  
    goto bitonal_t1

incf massa, f
movlw 2
subwf massa, W
btfss STATUS, 2  
goto bt1     

clrf massa    
movlw 120
movwf referencia
    
bt2:
clrf contador    	
	
    bitonal_t2:    
	movlw 0b00001000   
	movwf PORTA           
	call consumo
	call consumo
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movlw 0b00000100  
	movwf PORTA
	call consumo
	call consumo
	
	incf contador, f
	movlw 214
	subwf contador, W
	btfss STATUS, 2
    goto bitonal_t2
    
incf massa, f
movlw 2
subwf massa, W
btfss STATUS, 2  
goto bt2     
	
incf buchon, f
movlw 4
subwf buchon, W
btfss STATUS, 2  
goto clearmassa1
goto iniciando   

// Subrutinas -----------------------------------------------------------------
    
consumo:
    movf referencia, W
    movwf aux
    bucle_consumo:
	decfsz aux, f   ; decrementa aux y salta si es cero
    goto bucle_consumo
return
    
END resetvector    


