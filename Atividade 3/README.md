# Atividade 3: Ligar e desligar led com timer
**Objetivo:** Exercício de aplicação e gerenciamento de TIMERs. <br/>
**Especificações:** <br/>
• Fazer o Led piscar alternadamente, o qual permanece ligado ou desligado por 30 ms (milisegundos).<br/>
• Utilizar do Timer0, inicializando seu pre-scaler para 110 (1:128) e valor para .22 (255 - 22 = 233 -> 233 x 128 = 29.824 us) <br/>
• Obter o resultado mais próximo de 30 ms.<br/>
**Saída:** <br/>
• Por meio do Logic Analyser, será visível uma onda quadrada na porta GP2 com o tempo igual no estado ligado/desligado<br/>

**Arquivos:** <br/>
• O programa possui duas versões: Utilizando interrupção (LedInterrupcao.ASM) e outra apenas verificando a flag T0IF (LedAlternado.ASM)
