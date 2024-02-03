;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*              MODIFICAÇÕES PARA USO COM 12F675                   *
;*                FEITAS PELO PROF. MARDSON                        *
;*                     FEVEREIRO DE 2023                           *
;*                 BASEADO NO EXEMPLO DO LIVRO                     *
;*           Desbravando o PIC. David José de Souza                *
;*-----------------------------------------------------------------*
;*   MODELO PARA O PIC 12F675                                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINIÇÕES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p12f675.inc>	;ARQUIVO PADRÃO MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINAÇÃO DE MEMÓRIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINIÇÃO DE COMANDOS DE USUÁRIO PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAMÓRIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARIÁVEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20	;ENDEREÇO INICIAL DA MEMÓRIA DE
					;USUÁRIO
		W_TEMP		;REGISTRADORES TEMPORÁRIOS PARA USO
		STATUS_TEMP	;JUNTO ÀS INTERRUPÇÕES

		;COLOQUE AQUI SUAS NOVAS VARIÁVEIS
		;NÃO ESQUEÇA COMENTÁRIOS ESCLARECEDORES
		
		NOTA_REF ; MARCA A NOTA QUE ESTA SENDO TOCADA
		
	ENDC			;FIM DO BLOCO DE DEFINIÇÃO DE VARIÁVEIS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA
	
#DEFINE	NOTA_DO	NOTA_REF,0
#DEFINE	NOTA_RE	NOTA_REF,1
#DEFINE	NOTA_MI	NOTA_REF,2
#DEFINE	NOTA_FA	NOTA_REF,3
#DEFINE	NOTA_SOL NOTA_REF,4
#DEFINE	NOTA_LA	NOTA_REF,5
#DEFINE	NOTA_SI	NOTA_REF,6

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SAÍDAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDEREÇO INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    INÍCIO DA INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDEREÇO DE DESVIO DAS INTERRUPÇÕES. A PRIMEIRA TAREFA É SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERAÇÃO FUTURA

	ORG	0x04			;ENDEREÇO INICIAL DA INTERRUPÇÃO
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SERÃO ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUPÇÕES

INTERRUPCAO
	; 0,5 SEGUNDO = 8 us (PRESCALER) X 62500 (TMR1)
	; TMR1 = 65536 - 62500 = 3036 (00001011 11011100)
	; Porém, utilizando 3037 (00001011 11011101)
	; Obtive valores mais aproximados
	
	BTFSS PIR1, TMR1IF ; CHECA SE PASSOU OS 500 ms
	GOTO IDENTIFICAR_NOTA ; SE NÃO, CONTINUA TOCANDO A NOTA ATUAL DIRETO
	
	; SE SIM, RESETA O TIMER1
	MOVLW B'11011101'
	MOVWF TMR1L
	MOVLW B'00001011'
	MOVWF TMR1H
	
	BCF PIR1, TMR1IF
	
	RLF NOTA_REF, F ; PASSA PARA A PRÓXIMA NOTA
	BTFSC NOTA_REF, 7 ; CHECA SE CHEGOU AO FIM DA ESCALA
	GOTO RESETA_NOTA_REF ; SE SIM, REINICIA A ESCALA
	GOTO IDENTIFICAR_NOTA
	
RESETA_NOTA_REF
	MOVLW B'00000001'
	MOVWF NOTA_REF

IDENTIFICAR_NOTA
	; A identificação das notas musicais
	; É dada da seguinte configuração:
	; NOTA_REF - NOTA
	; 00000001 - DÓ
	; 00000010 - RÉ
	; 00000100 - MI
	; 00001000 - FÁ
	; 00010000 - SOL
	; 00100000 - LÁ
	; 01000000 - SÍ
		
	BTFSC NOTA_DO
	GOTO RESETA_TIMER_DO
	BTFSC NOTA_RE
	GOTO RESETA_TIMER_RE
	BTFSC NOTA_MI
	GOTO RESETA_TIMER_MI
	BTFSC NOTA_FA
	GOTO RESETA_TIMER_FA
	BTFSC NOTA_SOL
	GOTO RESETA_TIMER_SOL
	BTFSC NOTA_LA
	GOTO RESETA_TIMER_LA
	BTFSC NOTA_SI
	GOTO RESETA_TIMER_SI

RESETA_TIMER_DO
	; DÓ
	; 261,63 Hz approx = 3822 us
	; Duty cicle 50% = 1911 us
	; 1911 us approx = 8 us (PRESCALER) X 239 (TMR0)
	; TMR0 = 256 - 239
	; Após testes, 256 - 237,
	; Trouxe valores mais aproximados
	
	MOVLW .256-.237
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_RE
	; RÉ
	; 293,67 Hz approx = 3405 us
	; Duty cicle 50% = 1703 us
	; 1703 us approx = 8 us (PRESCALER) X 213 (TMR0)
	; TMR0 = 256 - 213
	; Após testes, 256 - 211,
	; Trouxe valores mais aproximados
	
	MOVLW .256-.211
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_MI
	; MI
	; 329,63 Hz approx = 3034 us
	; Duty cicle 50% = 1517 us
	; 1517 us approx = 8 us (PRESCALER) X 190 (TMR0)
	; TMR0 = 256 - 190
	; Após testes, 256 - 187
	; Trouxe valores mais aproximados
	
	MOVLW .256-.187
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_FA
	; FÁ
	; 349,23 Hz approx = 2863 us
	; Duty cicle 50% = 1432 us
	; 1432 us approx = 8 us (PRESCALER) X 179 (TMR0)
	; TMR0 = 256 - 179
	; Após testes, 256 - 176
	; Trouxe valores mais aproximados
	
	MOVLW .256-.176
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_SOL
	; SOL
	; 392 Hz approx = 2551 us
	; Duty cicle 50% = 1276 us
	; 1276 us approx = 8 us (PRESCALER) X 160 (TMR0)
	; TMR0 = 256 - 160
	; Após testes, 256 - 156
	; Trouxe valores mais aproximados
	
	MOVLW .256-.156
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_LA
	; LÁ
	; 440 Hz approx = 2273 us
	; Duty cicle 50% = 1137 us
	; 1137 us approx = 8 us (PRESCALER) X 142 (TMR0)
	; TMR0 = 256 - 142
	; Após testes, 256 - 139
	; Trouxe valores mais aproximados
	
	MOVLW .256-.139
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO

RESETA_TIMER_SI
	; SÍ
	; 493,89 Hz approx = 2025 us
	; Duty cicle 50% = 1013 us
	; 1013 us approx = 8 us (PRESCALER) X 127 (TMR0)
	; TMR0 = 256 - 127
	; Após testes, 256 - 123
	; Trouxe valores mais aproximados
	
	MOVLW .256-.123
	MOVWF TMR0
	BCF INTCON, T0IF
	GOTO INVERTE_PULSO
	
INVERTE_PULSO
	BTFSS GPIO, GP5 ; CHECA SE GP0 ESTÁ EM ESTADO ALTO
	GOTO SETA_GP5 ; SE NÃO, SETA GP0
	BCF GPIO, GP5 ; SE SIM, CLEAR GP0
	GOTO SAI_INT

SETA_GP5
	BSF GPIO, GP5
	GOTO SAI_INT

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SAÍDA DA INTERRUPÇÃO                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUPÇÃO

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRIÇÃO DE FUNCIONAMENTO
; E UM NOME COERENTE ÀS SUAS FUNÇÕES.
	
DESLIGA_INT
	BCF INTCON, GIE
	BCF GPIO, GP5
	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1
	MOVLW	B'00000001'	;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SAÍDAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'10000010'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'11100000'
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000001'
	MOVWF	PIE1		;ATIVA A INTERRUPCAO DO TIMER1
	BANK0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMP. ANALÓGICO
	MOVLW	B'00110001'
	MOVWF	T1CON		;ATIVA O TIMER1 E DEFINE O PRESCALER

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	; TIMER1 PARA OS 0,5s
	MOVLW	B'11011101'
	MOVWF	TMR1L
	MOVLW	B'00001011'
	MOVWF	TMR1H
	; TIMER0 PARA AS NOTAS MUSICAIS
	MOVLW	.256-.237
	MOVWF	TMR0
	; NOTA_REF PARA IDENTIFICAR E CICLAR ENTRE AS NOTAS
	MOVLW	B'00000001'
	MOVWF	NOTA_REF
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	BTFSC GPIO, GP0 ; CHECA SE GP0 ESTÁ DESLIGADO
	GOTO DESLIGA_INT ; SE NÃO, DESLIGA AS INTERRUPCOES E CLEAR GP5
	BSF INTCON, GIE
	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
