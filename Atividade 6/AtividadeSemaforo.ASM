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
		
		CONT_VERMELHO  ; CONTADOR PARA ATINGIR 2,0 NA SITUAÇÃO: SEMAFORO1(VERMELHO) e SEMAFORO2(VERDE)
		SEMAFORO       ; MARCA A COR QUE ESTÁ NO SEMAFORO 1
		CONT_VERDE     ; CONTADOR PARA ATINGIR 2,0 NA SITUAÇÃO: SEMAFORO1(VERDE)  e SEMAFORO2(VERMELHO)
		
	ENDC			;FIM DO BLOCO DE DEFINIÇÃO DE VARIÁVEIS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA
#DEFINE	SEM_VERDE	SEMAFORO,0
#DEFINE	SEM_AMARELO	SEMAFORO,1
#DEFINE	SEM_VERMELHO	SEMAFORO,2
#DEFINE	SEM_VERMELHO_AMARELO  SEMAFORO,3

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
	
	BTFSS PIR1, TMR1IF ; CHECA SE PASSOU OS 500 ms
	GOTO INTERRUPCAO ; SE NÃO, CONTINUA COM A MESMA COR
	
	; SE SIM, RESETA O TIMER1
	MOVLW B'11011011'
	MOVWF TMR1L
	MOVLW B'00001011'
	MOVWF TMR1H
	
	BCF PIR1, TMR1IF  ;limpa a flag
	
	MOVLW .1
	SUBWF CONT_VERDE, W ; verifica a operação Contador - Work
	BTFSC STATUS, C ; se contador < work , para
	GOTO IDENTIFICAR_COR
	
	MOVLW .1
	SUBWF CONT_VERMELHO, W ; verifica a operação Contador - Work
	BTFSC STATUS, C ; se contaador < work , para
	GOTO IDENTIFICAR_COR
	
	RLF SEMAFORO, F ; PASSA PARA A PRÓXIMA NOTA
	GOTO IDENTIFICAR_COR
	
RESETA_SEMAFORO
	MOVLW B'00000001'
	MOVWF SEMAFORO
	RETURN

IDENTIFICAR_COR
	; A identificação das cores do semáforo
	; É dada da seguinte configuração:
	; SEMAFORO 1 - COR DO SEMAFORO 
	; 00000001 - VERDE
	; 00000010 - AMARELO
	; 00000100 - VERMELHO
	; 00001000 - VERMELHO & AMARELO (Semáforo 2)
		
	BTFSC SEM_VERDE
	GOTO RESETA_VERDE
	BTFSC SEM_AMARELO
	GOTO RESETA_AMARELO
	BTFSC SEM_VERMELHO
	GOTO RESETA_VERMELHO
	BTFSC SEM_VERMELHO_AMARELO
	GOTO RESETA_VERMELHO_AMARELO
	
RESETA_VERDE
	; SEMAFORO 1
	BSF GPIO, GP0     ;VERDE LIGADO
	BCF GPIO, GP1
	
	BCF GPIO, GP2
	
	; SEMAFORO 2
	BCF GPIO, GP4
	BSF GPIO, GP5      ;VERMELHO LIGADO
	
	DECF CONT_VERDE
	GOTO SAI_INT
		
RESETA_AMARELO	
	; SEMAFORO 1
	BSF GPIO, GP0     ;VERDE LIGADO
	BCF GPIO, GP1
	
	BSF GPIO, GP2     ;AMARELO LIGADO
	
	; SEMAFORO 2
	BCF GPIO, GP3
	BCF GPIO, GP4
	BSF GPIO, GP5     ;VERMELHO LIGADO
	
	CALL AJUSTE_VERMELHO
	GOTO SAI_INT
	
RESETA_VERMELHO
	; SEMAFORO 1
	BCF GPIO, GP0
	BSF GPIO, GP1         ;VERMELHO LIGADO
	
	BCF GPIO, GP2
	
	; SEMAFORO 2
	BSF GPIO, GP4         ;VERDE LIGADO
	BCF GPIO, GP5
	
	DECF CONT_VERMELHO
	GOTO SAI_INT
	
RESETA_VERMELHO_AMARELO
	; SEMAFORO 1
	BCF GPIO, GP0
	BSF GPIO, GP1        ;VERMELHO LIGADO
	
	BSF GPIO, GP2        ;AMARELO LIGADO
	
	; SEMAFORO 2
	BSF GPIO, GP4        ;VERDE LIGADO
	BCF GPIO, GP5
	
	CALL AJUSTE_VERDE
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
	
AJUSTE_VERDE                 ; RESETA A QUANTIDADE DE VEZES QUE A COR VERDE IRÁ REPETIR          
	MOVLW .4
	MOVWF CONT_VERDE
	
	CALL RESETA_SEMAFORO ; SE SIM, REINICIA A ESCALA	
	RETURN
	
AJUSTE_VERMELHO              ; RESETA A QUANTIDADE DE VEZES QUE A COR VERMELHA IRÁ REPETIR   
	MOVLW .4
	MOVWF CONT_VERMELHO
	RLF SEMAFORO, F ; PASSA PARA A PRÓXIMA COR
	
	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1
	; SEMAFORO1: GP0(VERDE) e GP1(VERMELHO) | EM COMUM: GP2(AMARELO) | SEMAFORO2: GP4(VERDE) e GP5(VERMELHO)
	MOVLW	B'00000000'	;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SAÍDAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000000'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'11000000'
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
	; SEMAFORO PARA IDENTIFICAR E CICLAR ENTRE AS CORES
	MOVLW	B'00000001'
	MOVWF	SEMAFORO
	
	;INICIA COM SEMAFORO 1 NO VERDE | SEMAFORO 2 NO VERMELHO   
	BSF GPIO, GP0
	BSF GPIO, GP5
	
	;CONTADORES PARA QUANTIDADE x 0,5s
	MOVLW .3
	MOVWF CONT_VERDE
	MOVLW .0
	MOVWF CONT_VERMELHO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	
	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
