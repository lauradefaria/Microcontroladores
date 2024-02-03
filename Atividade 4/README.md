# Atividade 4: Sete notas musicais, de DÓ a SI (261,63 Hz a 493,88 Hz)
**Objetivo:** Exercício de aplicação e gerenciamento de TIMERs. <br/>
**Especificações:** <br/>
• As frequências das notas podem ser verificadas neste [ENDEREÇO](https://musicaeadoracao.com.br/25371/escala-musical-temperada-frequencias-das-notas-musicais/). <br/>
• As 7 notas (de DÓ à SI) devem ser reproduzidas pela geração de um sinal de onda quadrada, com duty cycle de 50% (desejável).<br/>
• A primeira nota deve ser DÓ, com frequência de 261,63 Hz.<br/>
• Cada nota deve ter a duração de 0,5 s, sem a necessidade de intervalo entre elas.<br/>
• O sinal deve ser gerado pela porta GP5.<br/>
**Saída:** <br/>
• A sequência de notas deve ser reproduzida continuamente enquanto a porta GP0 estiver em nível lógico LOW.<br/>
• Para proteção do amplificador de áudio, enquanto GP0 estiver em HIGH, a saída GP5 deve permanecer em LOW.<br/>
