# Atividade 6: Semáforo de trânsito
**Objetivo:** Exercício de aplicação e gerenciamento de TIMERs. <br/>
**Contexto:** Proponha um aplicativo em Assembly (PIC12F675) para controlar o semáforo de um cruzamento simples de rua: fecha para um lado e abre para o outro. <br/>
**Especificações:** <br/>
• Suponha a utilização de LEDs de 3 cores: vermelho, amarelo e verde. <br/>
• Por questões de simulação, cada lado (vermelho ou verde) deve ficar mantido por 2,5 segundos.<br/>
• Na transição para fechar, o LED amarelo correspondente deve acender por 0,5 s (simultaneamente com o verde).<br/>
• A definição das portas fica a critério do projetista, mas, deve ficar bem documentado para permitir a execução dos testes.<br/>
**Saída:** <br/>
• A Figura 1 ilustra o funcionamento descrito para o semáforo.<br/>

<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/Atividade6.png" width="400"> <br/>
  Figura 1: Semáforo de um cruzamento simples. <br/>
</p>
