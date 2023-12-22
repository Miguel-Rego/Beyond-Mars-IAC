; *********************************************************************************
; * Grupo 56
; * Miguel Rego - 104119
; * Vicente Vasconcelos - 106950
; *********************************************************************************
; *********************************************************************************
; * Constantes
; *********************************************************************************
COMANDOS				EQU	6000H			; endereço de base dos comandos do MediaCenter
DEFINE_LINHA    		EQU COMANDOS + 0AH		; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU COMANDOS + 0CH		; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU COMANDOS + 12H		; endereço do comando para escrever um pixel
APAGA_AVISO     		EQU COMANDOS + 40H		; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 		EQU COMANDOS + 02H		; endereço do comando para apagar todos os pixels já desenhados
SEL_ECRÃ			EQU COMANDOS + 04H
MOSTRAR_ECRÃ		EQU COMANDOS + 06H
SELECIONA_CENARIO_FUNDO  EQU COMANDOS + 42H		; endereço do comando para selecionar uma imagem de fundo
MOSTRAR EQU COMANDOS + 06H
FUNDO_JOGO EQU 0
FUNDO_PAUSE EQU 1
FUNDO_ENERGIA EQU 2
FUNDO_COLISAO EQU 3
SELECIONA_VIDEO_FUNDO EQU COMANDOS + 48H		; encereço do comando para selecionar um vídeo de fundo
SELECIONA_LOOP_VIDEO EQU COMANDOS + 58H			; endereço do comando para pôr um vídeo previamente selecionado em loop
INICIA_VIDEO EQU COMANDOS + 5AH				; inicia o vídeo
TERMINA_VIDEO EQU COMANDOS + 66H
PARA_VIDEO EQU COMANDOS + 66H		; endereço do comando para interromper um vídeo
LINHA1        		EQU  27        	; linha da nave
LINHA2        		EQU  28        	; linha da nave
LINHA3        		EQU  29        	; linha da nave
LINHA4        		EQU  30        	; linha da nave
LINHA5        		EQU  31        	; linha da nave
TECLA_INICIO		EQU  10000001b		; tecla C
TECLA_sonda_FRONTAL	EQU 10000100b ;	tecla 2
TECLA_sonda_ESQUERDA	EQU 10000010b ; tecla 1
TECLA_sonda_DIREITA	EQU 10001000b ; tecla 3
TECLA_PAUSE		EQU 00010010b
TECLA_REINICIAR EQU 01000001b
COLUNA			EQU 26        	; coluna da nave
LARGURA			EQU	15			; largura do painel de instrumentos da nave
COR_PIXEL			EQU	0FF00H		; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
COR_PIXEL_VERDE		EQU 0F090H ; cor verde menos intenso
COR_PIXEL_VERDE_FORTE 	EQU 0F0F0H ; cor verde mais intenso
COR_PIXEL_AZUL		EQU 0F00CH ; cor azul
COR_PIXEL_OPACO EQU 00000H ; pixel opaco, para apagar pixels
COR_SONDA EQU 0FFBCH ; Cor rosa
STARTSCREEN EQU 1
INGAME EQU 2
PAUSADO EQU 3
MORTO EQU 4
MORTE_ENERGIA EQU 1
MORTE_COLISAO EQU 2
PAUSAR EQU 3
DESPAUSAR EQU 4
REINICIAR EQU 5
DISPLAYS EQU 0A000H ; endereço de displays de 7 segmentos (periférico POUT-1)
TEC_LIN EQU 0C000H ; endereço de linha do teclado (periférico POUT-2)
TEC_COL EQU 0E000H ; endereço das colunas do teclado (PIN periférico)
LINHA_TECLADO EQU 16; linha dos inputs dos DISPLAYS e de movimento do asteroide e da sonda
MASCARA EQU 0FH ; para isolar os 4 bits menos ponderados ao ler as colunas do teclado
TOCA_SOM				EQU COMANDOS + 5AH		; endereço do comando para tocar um som
COLUNA1_DROP_AST EQU 2
COLUNA2_DROP_AST EQU 29
COLUNA3_DROP_AST EQU 57
LINHA_AST1        		EQU  1        ; 1 linha do Asteroide
LINHA_AST2        		EQU  2        ; 2 linha do Asteroide
LINHA_AST3        		EQU  3        ; 3 linha do Asteroide
LINHA_AST4        		EQU  4        ; 4 linha do Asteroide
LINHA_AST5        		EQU  5        ; 5 linha do Asteroide
MIN_COLUNA		EQU  0		; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		EQU  63        ; número da coluna mais à direita que o objeto pode ocupar
DELAY			EQU	0A000H		; atraso para limitar a velocidade de movimento do asteroide
LARGURA_AST			EQU	5		; largura do asteroide
LINHA_SONDA	EQU 26				; Linhas originais da sonda
COLUNA_SONDA_ESQUERDA EQU 26 ;	coluna da sonda da esquerda
COLUNA_SONDA_FRONTAL EQU 33				; coluna da sonda frontal
COLUNA_SONDA_DIREITA EQU 39	;	coluna da sonda da direita				
ALTURA_SONDA EQU 1				; altura da sonda
ESCONDER    EQU 6008H
sonda_ESQUERDA EQU 3
sonda_FRONTAL EQU 4
sonda_DIREITA EQU 5
NUM_AST EQU 4
LIMITE_ECRÃ EQU 31

; #######################################################################
; * ZONA DE DADOS 
; #######################################################################
PLACE 		1000H
pilha:
	STACK 100H			; espaço reservado para a pilha 
						; 
SP_inicial:				;
						; 
						; 
    STACK 100H          ; 
sp_main:                ; 

    STACK 100H          ; espaco reservado para a stack do processo que trata do teclado
sp_teclado:

    STACK 100H          ; espaco reservado para a stack do processo que trata do controlo
sp_controlo:

    STACK 100H          ; espaco reservado para a stack do processo que trata da energia
sp_asteroide_1:

    STACK 100H          ; espaco reservado para a stack do processo que trata da energia
sp_asteroide_2:

    STACK 100H          ; espaco reservado para a stack do processo que trata da energia
sp_asteroide_3:

    STACK 100H          ; espaco reservado para a stack do processo que trata da energia
sp_asteroide_4:

    STACK 100H          ; espaco reservado para a stack do processo que trata da energia
sp_energia:

sp_asteroides:
	WORD sp_asteroide_1
	WORD sp_asteroide_2
	WORD sp_asteroide_3
	WORD sp_asteroide_4
							
DEF_ASTEROIDE_MINERAVEL:					; tabela que define o boneco (cor, largura, pixels)
	WORD		LARGURA_AST
	WORD		0, COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE, 0		; # # # definição dos pixels do asteroide	
	
DEF_ASTEROIDE2_MINERAVEL:
	WORD		LARGURA_AST
	WORD		COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE, COR_PIXEL_VERDE_FORTE		

	
DEF_ASTEROIDE_OPACO:					; tabela que define o asteroide transparente para remover os pixels e fazer movimentar o asteroide
	WORD		LARGURA_AST
	WORD		COR_PIXEL_OPACO, COR_PIXEL_OPACO, COR_PIXEL_OPACO, COR_PIXEL_OPACO, COR_PIXEL_OPACO		; # # #   as cores podem ser diferentes de pixel para pixel
	
DEF_ASTEROIDE_VERMELHO:
	WORD		LARGURA_AST
	WORD		COR_PIXEL, 0, COR_PIXEL, 0, COR_PIXEL
	
DEF_ASTEROIDE_VERMELHO2:
	WORD		LARGURA_AST
	WORD		0, COR_PIXEL, COR_PIXEL, COR_PIXEL, 0
	
DEF_ASTEROIDE_VERMELHO3:
	WORD		LARGURA_AST
	WORD		COR_PIXEL, COR_PIXEL, 0, COR_PIXEL, COR_PIXEL
	
DEF_ASTEROIDE_AZUL:
	WORD		LARGURA_AST
	WORD		0, COR_PIXEL_AZUL, 0, COR_PIXEL_AZUL, 0

DEF_ASTEROIDE_AZUL2:
	WORD		LARGURA_AST
	WORD		COR_PIXEL_AZUL, 0, COR_PIXEL_AZUL, 0, COR_PIXEL_AZUL
	
			
DEF_NAVE:					; tabela que define a nave
	WORD		LARGURA
	WORD		0, 0, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, COR_PIXEL, 0, 0		; # # #   as cores podem ser diferentes de pixel para pixel
	
DEF_NAVE2:
	WORD		LARGURA
	WORD		0, COR_PIXEL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL, 0		; # # #   as cores podem ser diferentes de pixel para pixel

DEF_NAVE3:
	WORD		LARGURA
	WORD		COR_PIXEL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL, COR_PIXEL_AZUL, COR_PIXEL_VERDE_FORTE, COR_PIXEL_AZUL, COR_PIXEL_VERDE_FORTE, COR_PIXEL_AZUL, COR_PIXEL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL		; # # #   as cores podem ser diferentes de pixel para pixel

DEF_NAVE4:
	WORD		LARGURA
	WORD		COR_PIXEL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE_FORTE, COR_PIXEL, COR_PIXEL_AZUL, COR_PIXEL_VERDE_FORTE, COR_PIXEL, COR_PIXEL_VERDE_FORTE, COR_PIXEL_AZUL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL		; # # #   as cores podem ser diferentes de pixel para pixel
	
DEF_NAVE5:
	WORD		LARGURA
	WORD		COR_PIXEL, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL_VERDE, COR_PIXEL		; # # #   as cores podem ser diferentes de pixel para pixel
	
DEF_SONDA1:				; tabela que define a sonda
	WORD ALTURA_SONDA
	WORD COR_SONDA
	
DEF_SONDA1_OPACO:
	WORD ALTURA_SONDA
	WORD COR_PIXEL_OPACO
	
estado:
	WORD	STARTSCREEN
	
	
lock_controlo:          ; variavel para controlar o processo controlo
    LOCK    0

lock_energia:			; variavel para controlar o processo de energia da nave
	LOCK 	0

lock_sonda_esquerda:			; variavel para controlar o processo dos sondas
	WORD 	0

lock_sonda_frontal:			; variavel para controlar o processo dos sondas
	WORD 	0

lock_sonda_direita:			; variavel para controlar o processo dos sondas
	WORD 	0


lock_asteroide:		;variavel para controlar o processo dos asteroides
	LOCK	0

lock_gere_asteroides:
	LOCK	0
	
; Tabela das rotinas de interrupção
tab:
	WORD rot_int_0			; rotina de atendimento da interrupção 0
	WORD rot_int_1			; rotina de atendimento da interrupção 1
	WORD rot_int_2			; rotina de atendimento da interrupção 2
	WORD rot_int_3			; rotina de atendimento da interrupção 3

evento_int:
	LOCK 0				; se 1, indica que a interrupção 0 ocorreu
	LOCK 0				; se 1, indica que a interrupção 1 ocorreu
	LOCK 0				; se 1, indica que a interrupção 2 ocorreu
	LOCK 0				; se 1, indica que a interrupção 3 ocorreu
                              
linha_asteroide:
	WORD 0				; linha em que o 1 asteroide está
	WORD 0				; linha em que o 2 asteroide barra está
	WORD 0				; linha em que o 2 asteroide está
	WORD 0				; linha em que o 2 asteroide está

contador:
	WORD 0				
                              
contador_atraso:
	WORD DELAY			; contador usado para gerar o atraso
	

	
; *********************************************************************************
; * Código - desenha_nave que cria a nave linha a linha
; *********************************************************************************
PLACE		0

main:
    MOV SP, sp_main             ; inicializar o stack pointer com o endereco 1200H
	MOV BTE, tab
startScreen:
    MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado
	MOV	R1, 1			; vídeo de fundo número 1
    MOV  [SELECIONA_VIDEO_FUNDO], R1	; seleciona o vídeo de fundo
	MOV [INICIA_VIDEO], R1
	MOV [SELECIONA_LOOP_VIDEO], R1 ; põe o vídeo em loop
	EI1
	EI2
	EI3
	EI
	JMP teclado
nave_main1:
	 MOV R1, 1
	 MOV [PARA_VIDEO], R1
	 MOV	R1, 0			; cenário de fundo número 0 
     MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado 
     MOV  [APAGA_ECRÃ], R1	; apaga todos os pixels já desenhados 
     MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	 MOV [SEL_ECRÃ], R1
	 MOV [MOSTRAR_ECRÃ], R1   
nave_main:    
posição_nave:
     MOV  R1, LINHA1			; linha da nave
     MOV  R2, COLUNA		; coluna da nave

desenha_nave:       		; desenha a nave a partir da tabela
	MOV	R4, DEF_NAVE		; endereço da tabela que define a nave
	MOV	R5, [R4]	; obtém a largura da nave
	ADD	R4, 2			; endereço da cor do 1º pixel 
desenha_pixels_nave:       		; desenha os pixels da nave a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da nave
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel 
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_nave      ;	 continua até percorrer toda a largura da nave
	 
posição_nave1:
     MOV  R1, LINHA2			; linha da nave
     MOV  R2, COLUNA		; coluna da nave

desenha_nave1:       		; desenha a nave a partir da tabela
	MOV	R4, DEF_NAVE2		; endereço da tabela que define a nave
	MOV	R5, [R4]	; obtém a largura do nave
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_nave1:       		; desenha os pixels do nave a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do nave
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_nave1      ;	 continua até percorrer toda a largura do objeto


posição_nave2:
     MOV  R1, LINHA3			; linha da nave
     MOV  R2, COLUNA		; coluna da nave

desenha_nave2:       		; desenha a nave a partir da tabela
	MOV	R4, DEF_NAVE3		; endereço da tabela que define a nave
	MOV	R5, [R4]	; obtém a largura da nave
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_nave2:       		; desenha os pixels da nave a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da nave
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_nave2      ;	 continua até percorrer toda a largura do objeto


posição_nave3:
     MOV  R1, LINHA4			; linha da nave
     MOV  R2, COLUNA		; coluna da nave

desenha_nave3:       		; desenha o nave a partir da tabela
	MOV	R4, DEF_NAVE4		; endereço da tabela que define a nave
	MOV	R5, [R4]	; obtém a largura da nave
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_nave3:       		; desenha os pixels do nave a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da nave
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_nave3      ;	 continua até percorrer toda a largura do objeto

posição_nave4:
     MOV  R1, LINHA5			; linha da nave
     MOV  R2, COLUNA		; coluna da nave

desenha_nave4:       		; desenha a nave a partir da tabela
	MOV	R4, DEF_NAVE5		; endereço da tabela que define a nave
	MOV	R5, [R4]	; obtém a largura da nave
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_nave4:       		; desenha os pixels da nave a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da nave
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_nave4      ;	 continua até percorrer toda a largura da nave
	 




; *********************************************************************************
; * Código que move o Asteroide, que cria linha a linha o Asteroide e o faz movimentar na diagonal quando se clica na Tecla "D"
; *********************************************************************************

inicioAST:
	MOV  SP, SP_inicial		; inicializa SP para a palavra a seguir
						; à última da pilha
	MOV	R7, 1			; valor a somar à coluna do asteroide para o movimentar
	MOV R8, 0 
	MOV R10, 0
	MOV R11, 0
     
	
	
mostra_boneco:
	CALL	cycle_colunas_drop1		; desenha o asteroide a partir da tabela


; *********************************************************************************
; *********************************************************************************	
	
ve_limites:
	MOV	R6, [R4]			; obtém a largura do asteroide
	JMP	loop_espera2		; se não é para movimentar o objeto, vai ler o teclado de novo

move_boneco:
	CALL	apaga_asteroide	; apaga o asteroide na sua posição corrente
	
coluna_seguinte:
	ADD R8, R7

	CALL	mostra_boneco		; vai desenhar o asteroide de novo


; **********************************************************************
; desenha_asteroide - Desenha um asteroide na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o Asteroide
;
; **********************************************************************
cycle_colunas_drop1:
	CMP R11, 0
	JNZ cycle_colunas_drop2
	MOV R9, COLUNA1_DROP_AST
	ADD R11, 1
	CALL  desenha_asteroide
	

cycle_colunas_drop2:
	CMP R11, 1
	JNZ cycle_colunas_drop3
	MOV R9, COLUNA2_DROP_AST
	ADD R11, 1
	CALL  desenha_asteroide_angulado
	
cycle_colunas_drop3:
	CMP R11, 2
	JNZ cycle_colunas_drop4
	MOV R9, COLUNA2_DROP_AST
	ADD R11, 1
	CALL  desenha_asteroide_frontal
	
cycle_colunas_drop4:
	CMP R11, 3
	JNZ cycle_colunas_drop5
	MOV R9, COLUNA2_DROP_AST
	ADD R11, 1
	CALL  desenha_asteroide

	
cycle_colunas_drop5:
	CMP R11, 4
	JNZ cycle_colunas_drop1
	MOV R9, COLUNA3_DROP_AST
	MOV R11, 0
	CALL  desenha_asteroide_angulado
	RET

desenha_asteroide:       		; desenha o asteroide
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, R9
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide      ;	 continua até percorrer toda a largura do objeto
	 
desenha_asteroide2:       		; desenha a 2 linha do asteroide
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, R9
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO2; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide2:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide2      ;	 continua até percorrer toda a largura do objeto

desenha_asteroide3:       		; desenha a 3 linha do asteroide
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO3		; endereço da tabela que define o asteroide
	MOV R2, R9
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide3:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide3      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide4:       		; desenha a 4 linha do asteroide
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO2		; endereço da tabela que define o asteroide
	MOV R2, R9
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide4:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide4      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide5:       		; desenha a 5 linha do asteroide
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO		; endereço da tabela que define o asteroide
	MOV R2, R9
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide5:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide5      ;	 continua até percorrer toda a largura do objeto
	 RET

	 
desenha_asteroide_frontal:       		; desenha o asteroide
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, R9
	MOV	R4, DEF_ASTEROIDE_VERMELHO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide_frontal      ;	 continua até percorrer toda a largura do objeto
	 
	 
desenha_asteroide2_frontal:       		; desenha a 2 linha do asteroide
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, R9
	MOV	R4, DEF_ASTEROIDE_VERMELHO2		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide2_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide2_frontal      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide3_frontal:       		; desenha a 3 linha do asteroide
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO3		; endereço da tabela que define o asteroide
	MOV R2, R9
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide3_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide3_frontal      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide4_frontal:       		; desenha a 4 linha do asteroide
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO2		; endereço da tabela que define o asteroide
	MOV R2, R9
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide4_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide4_frontal      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide5_frontal:       		; desenha a 5 linha do asteroide
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_VERMELHO		; endereço da tabela que define o asteroide
	MOV R2, R9
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide5_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide5_frontal      ;	 continua até percorrer toda a largura do objeto
	 RET

desenha_asteroide_angulado:       		; desenha o asteroide
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, R9
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE_MINERAVEL		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide_angulado      ;	 continua até percorrer toda a largura do objeto
	 
	 
desenha_asteroide2_angulado:       		; desenha a 2 linha do asteroide
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, R9
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE2_MINERAVEL		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide2_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide2_angulado      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide3_angulado:       		; desenha a 3 linha do asteroide
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE2_MINERAVEL		; endereço da tabela que define o asteroide
	MOV R2, R9
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide3_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide3_angulado	 ;	 continua até percorrer toda a largura do objeto


desenha_asteroide4_angulado:       		; desenha a 4 linha do asteroide
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE2_MINERAVEL		; endereço da tabela que define o asteroide
	MOV R2, R9
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide4_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide4_angulado      ;	 continua até percorrer toda a largura do objeto


desenha_asteroide5_angulado:       		; desenha a 5 linha do asteroide
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_MINERAVEL		; endereço da tabela que define o asteroide
	MOV R2, R9
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_asteroide5_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels_asteroide5_angulado      ;	 continua até percorrer toda a largura do objeto
	 RET
	
	
	
apaga_asteroide:
	CALL delay
	CALL delay
	CALL delay
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA1_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA1_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA1_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA1_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA1_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide_frontal_direita:
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide_frontal_direita      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2_frontal_direita:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3_frontal_direita:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4_frontal_direita:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4_frontal_direita     ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5_frontal_direita:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide_frontal:
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide_frontal      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2_frontal:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2_frontal      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3_frontal:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3_frontal      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4_frontal:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4_frontal      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5_frontal:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5_frontal      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide_angulado_frontal_direita:
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide_angulado_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide_angulado_frontal_direita      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2_angulado_frontal_direita:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA2_DROP_AST
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2_angulado_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2_angulado_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3_angulado_frontal_direita:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3_angulado_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3_angulado_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4_angulado_frontal_direita:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4_angulado_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4_angulado_frontal_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5_angulado_frontal_direita:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA2_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5_angulado_frontal_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5_angulado_frontal_direita      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide_angulado:
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA3_DROP_AST
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide_angulado      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2_angulado:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA3_DROP_AST
	SUB R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2_angulado      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3_angulado:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3_angulado      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4_angulado:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4_angulado      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5_angulado:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	SUB R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5_angulado:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5_angulado      ;	 continua até percorrer toda a largura do objeto
	 
apaga_asteroide_angulado_lateral_direita:
	MOV R1, LINHA_AST1
	ADD R1, R8
	MOV R2, COLUNA3_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide_angulado_lateral_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide_angulado_lateral_direita      ;	 continua até percorrer toda a largura do objeto

apaga_asteroide2_angulado_lateral_direita:       		
	MOV R1, LINHA_AST2
	ADD R1, R8
	MOV R2, COLUNA3_DROP_AST
	ADD R2, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide2_angulado_lateral_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide2_angulado_lateral_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide3_angulado_lateral_direita:       		
	MOV R1, LINHA_AST3
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide3_angulado_lateral_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide3_angulado_lateral_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide4_angulado_lateral_direita:       		
	MOV R1, LINHA_AST4
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide4_angulado_lateral_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide4_angulado_lateral_direita      ;	 continua até percorrer toda a largura do objeto


apaga_asteroide5_angulado_lateral_direita:       		; desenha o asteroide a partir da tabela
	MOV R1, LINHA_AST5
	ADD R1, R8
	MOV	R4, DEF_ASTEROIDE_OPACO		; endereço da tabela que define o asteroide
	MOV R2, COLUNA3_DROP_AST
	ADD R2, R8
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_asteroide5_angulado_lateral_direita:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels_asteroide5_angulado_lateral_direita      ;	 continua até percorrer toda a largura do objeto
	 RET
	 
; **********************************************************************
; ROT_INT_0 - 	Rotina de atendimento da interrupção 0
;			Assinala o evento na componente 0 da variável evento_int
; **********************************************************************
rot_int_0:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1			; assinala que houve uma interrupção 0
	MOV  [R0], R1			; na componente 0 da variável evento_int
	POP  R1
	POP  R0
	RFE

; **********************************************************************
; ROT_INT_1 - 	Rotina de atendimento da interrupção 1
;			Assinala o evento na componente 1 da variável evento_int
; **********************************************************************
rot_int_1:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1			; assinala que houve uma interrupção 0
	MOV  [R0+2], R1		; na componente 1 da variável evento_int
						; Usa-se 2 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE

; **********************************************************************
; ROT_INT_2 -	Rotina de atendimento da interrupção 2
;			Assinala o evento na componente 2 da variável evento_int
; **********************************************************************
rot_int_2:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1			; assinala que houve uma interrupção 0
	MOV  [R0+4], R1		; na componente 2 da variável evento_int
						; Usa-se 4 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE

; **********************************************************************
; ROT_INT_3 -	Rotina de atendimento da interrupção 3
;			Assinala o evento na componente 3 da variável evento_int
; **********************************************************************
rot_int_3:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1			; assinala que houve uma interrupção 0
	MOV  [R0+6], R1		; na componente 3 da variável evento_int
						; Usa-se 6 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE
	
; **********************************************************************
; SONDA - Desenha a sonda e faz ela subir com o clique "C"
; **********************************************************************
inicioSONDA:
	MOV R10, 0 ; R10 - Vetor de translação da sonda da esquerda
	MOV R11, 0 ; R10 - Vetor de translação da sonda da frontal
	MOV R5, 0 ; R10 -  Vetor de translação da sonda da direita
	JMP loop_espera2

     
	
	
mostra_sonda:
	CALL	cycle_colunas_drop1_sonda		; desenha o asteroide a partir da tabela


; *********************************************************************************
; *********************************************************************************	

move_sonda:
	CALL	apaga_sonda_esquerda	; apaga a sonda na sua posição corrente
	
coluna_sonda_seguinte_esquerda:
	ADD R10, R7
	
coluna_sonda_seguinte_frontal:
	ADD R11, R7
	
coluna_sonda_seguinte_direita:
	ADD R12, R7



	JMP ingame		; vai desenhar o asteroide de novo


; **********************************************************************
; desenha_asteroide - Desenha um asteroide na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o Asteroide
;
; **********************************************************************
cycle_colunas_drop1_sonda:
	MOV R9, COLUNA_SONDA_ESQUERDA
	MOV R4, [lock_sonda_esquerda]
	CMP R4, 0
	JNZ  desenha_sonda_esquerda
	JMP cycle_colunas_drop2_sonda
	
cycle_colunas_drop2_sonda:
	MOV R9, COLUNA_SONDA_FRONTAL
	MOV R4, [lock_sonda_frontal]
	CMP R4, 0
	JNZ  desenha_sonda_frontal
	JMP cycle_colunas_drop3_sonda
	
cycle_colunas_drop3_sonda:
	MOV R9, COLUNA_SONDA_DIREITA
	MOV R4, [lock_sonda_direita]
	CMP R4, 0
	JNZ  desenha_sonda_direita
	RET

cycle_apaga_colunas_drop1_sonda:
	MOV R9, COLUNA_SONDA_ESQUERDA
	MOV R4, [lock_sonda_esquerda]
	CMP R4, 0
	JNZ  apaga_sonda_esquerda
	JMP cycle_apaga_colunas_drop2_sonda
	
cycle_apaga_colunas_drop2_sonda:
	MOV R9, COLUNA_SONDA_FRONTAL
	MOV R4, [lock_sonda_frontal]
	CMP R4, 0
	JNZ  apaga_sonda_frontal
	JMP cycle_apaga_colunas_drop3_sonda
	
cycle_apaga_colunas_drop3_sonda:
	MOV R9, COLUNA_SONDA_DIREITA
	MOV R4, [lock_sonda_direita]
	CMP R4, 0
	JNZ  apaga_sonda_direita
	RET	

	
desenha_sonda_esquerda:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	CMP R1, 0
	JZ lockar_sonda_esquerda
	MOV R2, R9
	SUB R2, R10
	MOV	R4, DEF_SONDA1		; endereço da tabela que define a sonda
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_sonda_esquerda:       		; desenha os pixels da sonda a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da sonda
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
	 JMP cycle_colunas_drop2_sonda

desenha_sonda_frontal:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	CMP R1, 0
	JZ lockar_sonda_frontal
	MOV R2, R9
	MOV	R4, DEF_SONDA1		; endereço da tabela que define oa sonda
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_sonda_frontal:       		; desenha os pixels do asteroide a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do asteroide
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	 JMP cycle_colunas_drop3_sonda

	
desenha_sonda_direita:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	CMP R1, 0
	JZ lockar_sonda_direita
	MOV R2, R9
	ADD R2, R10
	MOV	R4, DEF_SONDA1		; endereço da tabela que define a sonda
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels_sonda_direita:       		; desenha os pixels da sonda a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da sonda
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	 RET
	 
apaga_sonda_esquerda:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	MOV R2, R9
	SUB R2, R10
	MOV	R4, DEF_SONDA1_OPACO		; endereço da tabela que define o asteroide
	MOV	R5, [R4]	; obtém a largura do asteroide
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_sonda_esquerda:       		; desenha os pixels da sonda a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da sonda
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	 JMP cycle_apaga_colunas_drop2_sonda

apaga_sonda_frontal:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	MOV R2, R9
	MOV	R4, DEF_SONDA1_OPACO		; endereço da tabela que define a sonda
	MOV	R5, [R4]	; obtém a largura da sonda
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_sonda_frontal:       		; desenha os pixels da sonda a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da sonda
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	 JMP cycle_apaga_colunas_drop3_sonda

	
apaga_sonda_direita:       		; desenha a sonda
	MOV R1, LINHA_SONDA
	SUB R1, R10
	MOV R2, R9
	ADD R2, R10
	MOV	R4, DEF_SONDA1_OPACO		; endereço da tabela que define a sonda
	MOV	R5, [R4]	; obtém a largura da sonda
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels_sonda_direita:       		; desenha os pixels da sonda a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel da sonda
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
	 RET	 


lockar_sonda_esquerda:
	MOV R4, 0
	MOV [lock_sonda_esquerda], R4
	RET
	
lockar_sonda_frontal:
	MOV R4, 0
	MOV [lock_sonda_frontal], R4
	RET

lockar_sonda_direita:
	MOV R4, 0
	MOV [lock_sonda_direita], R4
	RET





reset_movement:
	MOV R8, 0
	CALL nave_main

delay:
    PUSH R0
    MOV R0, DELAY
ciclo_delay:
    SUB R0, 1
    JNZ ciclo_delay
    POP R0
    RET
	
; **********************************************************************
; *	Código do teclado
; **********************************************************************
PROCESS sp_teclado
teclado:
    MOV SP, sp_teclado  ; re-inicializar o stack pointer
    MOV R2, MASCARA ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
    MOV R3, TEC_LIN     ; endereco do periferico de saida
    MOV R4, TEC_COL     ; endereco do periferico de entrada
espera_tecla:
    MOV  R5, LINHA_TECLADO ; comecar por testar a linha 4
loop_espera:
	MOV R0, [estado]    ; ler estado
	CMP R0, INGAME        ; estamos a jogar o jogo?
	JNZ loop_espera1
	CALL ingame
loop_espera1:
    MOV SP, sp_teclado  ; re-inicializar o stack pointer
    MOV R2, MASCARA ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
    MOV R3, TEC_LIN     ; endereco do periferico de saida
    MOV R4, TEC_COL     ; endereco do periferico de entrada
    MOV  R5, LINHA_TECLADO ; comecar por testar a linha 4
    SHR R5, 1           ; shift right
    CMP R5, 0           ; verificar se estamos a testar uma linha valida
    JZ  espera_tecla    ; reinicializar o valor da linha e recomecar o ciclo caso linha seja invalida
    MOVB [R3], R5       ; escrever no periferico de saida (linhas)
    MOVB R0, [R4]       ; ler do periferico de entrada (colunas)
    AND R0, R2          ; elimina bits para alem dos bits 0-3
    CMP R0, 0           ; ha tecla premida?
    JZ  loop_espera    ; se nenhuma tecla premida, repete
    MOV R9, R5          ; guardar a linha
    SHL R5, 4           ; coloca linha no nibble high
    OR  R5, R0          ; junta coluna (nibble low)
    MOV R0, [estado]    ; ler estado
    CMP R0, STARTSCREEN        ; estamos no title screen?
    JZ titlescreen
    CMP R0, INGAME        ; estamos a jogar o jogo?
	JZ ingame
titlescreen:
    ; premir c para comecar
    MOV R0, TECLA_INICIO      ; agora R0 tem as coordenadas da tecla que comeca
    CMP R5, R0          ; verifica se carregamos nessa tecla
	JNZ espera_tecla
	JZ prepare_ingame
prepare_ingame:
    MOV R0, INGAME    ; prepara argumento para o processo controlo
	MOV [estado], R0
    CALL nave_main1  ; efetuar a operacao caso tenha sido pressionada
ingame:
	MOV R2, LIMITE_ECRÃ	
	CMP R8, R2
	JZ reset_movement ; reinicia os asteroides para posição inicial
	CALL anima_asteroide
ingame_sonda:
	CALL unlock_sondas ; desbloqueia as sondas
	JMP ingame
anima_asteroide:
	CALL move_boneco
	RET
anima_sonda:
	CALL move_sonda
unlock_sondas:
	MOV R0, TECLA_sonda_ESQUERDA
	CMP R5, R0
	JZ check_sonda_esquerda
	MOV R0, TECLA_sonda_FRONTAL
	CMP R5, R0
	JZ check_sonda_frontal
	MOV R0, TECLA_sonda_DIREITA
	CMP R5, R0
	JZ check_sonda_direita
	RET
	
check_sonda_esquerda:
	MOV R4, [lock_sonda_esquerda]
	MOV R5, [R4]
	CMP R4, 0
	JZ unlock_sonda_esquerda 
	JMP check_sonda_frontal
	
check_sonda_frontal:
	MOV R4, [lock_sonda_frontal]
	MOV R5, [R4]
	CMP R4, 0
	JZ unlock_sonda_frontal
	JMP check_sonda_direita
	
check_sonda_direita:
	MOV R4, [lock_sonda_direita]
	MOV R5, [R4]
	CMP R4, 0
	JZ	unlock_sonda_direita
	RET
	
unlock_sonda_esquerda:
	MOV R4, 1
	MOV [lock_sonda_esquerda], R4
	CALL mostra_sonda
	RET

unlock_sonda_frontal:
	MOV R4, 1
	MOV [lock_sonda_frontal], R4
	CALL mostra_sonda
	RET

unlock_sonda_direita:
	MOV R4, 1
	MOV [lock_sonda_direita], R4
	CALL mostra_sonda
	RET

loop_espera2:
    MOV SP, sp_teclado  ; re-inicializar o stack pointer
    MOV R2, MASCARA ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
    MOV R3, TEC_LIN     ; endereco do periferico de saida
    MOV R4, TEC_COL     ; endereco do periferico de entrada
    MOV  R5, LINHA_TECLADO ; comecar por testar a linha 4
    SHR R5, 1           ; shift right
    CMP R5, 0           ; verificar se estamos a testar uma linha valida
    MOVB [R3], R5       ; escrever no periferico de saida (linhas)
    MOVB R0, [R4]       ; ler do periferico de entrada (colunas)
    AND R0, R2          ; elimina bits para alem dos bits 0-3
    MOV R9, R5          ; guardar a linha
    SHL R5, 4           ; coloca linha no nibble high
    OR  R5, R0          ; junta coluna (nibble low)
    JMP ingame_sonda