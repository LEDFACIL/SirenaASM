;------------------------------------------------------------
; Código assembler generado por Niple V6.6.2
; Proyecto: Sirena
; Autor: LASSO DAMIAN GUILLERMO
; Fecha: 25/10/2023
; PIC: 16F628A
; Velocidad de reloj: Int 4 Mhz
; Descripcion: 
;------------------------------------------------------------


 LIST    P=PIC16F628A


_INCRC_OSC_NOCLKOUT   equ  0x3FFC
_WDT_OFF              equ  0x3FFB
_PWRTE_ON             equ  0x3FF7
_MCLRE_OFF            equ  0x3FDF
_BODEN_OFF            equ  0x3FBF
_LVP_OFF              equ  0x3F7F
_CPD_OFF              equ  0x3F7F
_CP_OFF               equ  0x3FFF

 __config _INCRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF & _BODEN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF


;------------------------------------------------------------
;                  Declaración de Registros
;------------------------------------------------------------
w                     equ  0x0000
status                equ  0x0003
fsr                   equ  0x0004
porta                 equ  0x0005
portb                 equ  0x0006
pclath                equ  0x000a
cmcon                 equ  0x001f
_np_temp1             equ  0x0024
_np_temp2             equ  0x0025
_np_temp3             equ  0x0026
_np_temp4             equ  0x0027
aux                   equ  0x002e
aux2                  equ  0x002f
basura                equ  0x0030
tiempo                equ  0x0032
opcion                equ  0x0081
trisa                 equ  0x0085
trisb                 equ  0x0086


;------------------------------------------------------------
;                  Declaración de Bits
;------------------------------------------------------------
c                     equ  0   ;-
psa                   equ  3   ;-
rb7                   equ  7   ;-
rp0                   equ  5   ;-
rp1                   equ  6   ;-
to                    equ  4   ;-
z                     equ  2   ;-
banderin              equ  0   ;


;------------------------------------------------------------
;               Declaración de Registros EEPROM
;------------------------------------------------------------


;------------------------------------------------------------
;                        Inicio
;------------------------------------------------------------

   org 0x00
   bsf status,rp0                   ;cambiar a banco 1
   bcf opcion,psa
   goto paso2


;------------------------------------------------------------
;                      programa principal
;------------------------------------------------------------
paso2
   bcf status,rp0                   ;cambiar a banco 0
   bcf status,rp1
   clrf _np_temp1
   clrf _np_temp2
   clrf _np_temp3
   clrf _np_temp4
   clrf aux
   clrf aux2
   clrf basura
   clrf tiempo
   clrf porta
   movlw b'11110000'                ;configurar el puerto a como eeeessss
   bsf status,rp0                   ;cambiar a banco 1
   movwf trisa
   movlw b'00000111'                ;puerto a = e/s digital
   bcf status,rp0                   ;cambiar a banco 0
   movwf cmcon
   clrf portb
   movlw b'00000110'                ;configurar el puerto b como sssssees
   bsf status,rp0                   ;cambiar a banco 1
   movwf trisb
   bcf status,rp0                   ;cambiar a banco 0
   bsf portb,rb7
   movlw d'102'
   movwf tiempo
sube
   bcf status,rp0                   ;cambiar a banco 0
   bcf status,rp1
   movlw b'00000100'
   movwf porta
   call rutusr_001                  ;llamada a rutina usr_tempo

   movf aux2,w                      ;si aux2 = d'19'
   xorlw d'19'
   btfss status,z
   goto paso31
   clrf aux2
   bsf basura,banderin
paso13
   movlw b'00001000'
   movwf porta
   call rutusr_001                  ;llamada a rutina usr_tempo

   movf tiempo,w                    ;si tiempo = d'39'
   xorlw d'39'
   btfss status,z
   goto paso32
   clrf aux2
   bcf basura,banderin
baja
   bcf status,rp0                   ;cambiar a banco 0
   bcf status,rp1
   movlw b'00000100'
   movwf porta
   call rutusr_001                  ;llamada a rutina usr_tempo

   movf aux2,w                      ;si aux2 = d'19'
   xorlw d'19'
   btfss status,z
   goto paso37
   clrf aux2
   bsf basura,banderin
paso26
   movlw b'00001000'
   movwf porta
   call rutusr_001                  ;llamada a rutina usr_tempo

   movf tiempo,w                    ;si tiempo = d'102'
   xorlw d'102'
   btfss status,z
   goto paso38
   goto sube
paso31

   incf aux2,1
   goto paso13                      ;cierra el ciclo
paso32

   btfss basura,banderin            ;si el banderin = 10
   goto sube
   bcf basura,banderin

   movf tiempo,w
   btfss status,z
   decf tiempo,1
   movf tiempo,w
   goto sube
   goto sube
paso37

   incf aux2,1
   goto paso26                      ;cierra el ciclo
paso38

   btfss basura,banderin            ;si el banderin = 10
   goto baja
   bcf basura,banderin

   incf tiempo,1
   goto baja
   goto baja


;------------------------------------------------------------
;                  Declaración de Subrutinas
;------------------------------------------------------------

; usr_tempo
rutusr_001
   bcf status,rp0                   ;cambiar a banco 0
   bcf status,rp1
   clrf aux
rutusr_001_4

   movf aux,w                       ;si aux = tiempo
   xorwf tiempo,w
   btfss status,z
   goto rutusr_001_5
   goto rutusr_001_salir
rutusr_001_5

   incf aux,1
   goto rutusr_001_4                ;cierra el ciclo
   goto rutusr_001_5                ;cierra el ciclo
rutusr_001_salir

   bcf status,rp0                   ;cambiar a banco 0
   bcf status,rp1
   return


;------------------------------------------------------------
;                  DATOS EN MEMORIA EEPROM
;------------------------------------------------------------
   org  0x2100
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff
   data   0xff

 End