[![author](https://img.shields.io/badge/author-lauradefaria-blue.svg)](https://github.com/lauradefaria)

# Microcontroladores
Guia de atividades utilizando PIC 12F675, baseado na disciplina "Microcontroladores" ministrada na Universidade Federal da Paraíba (UFPB) - [Prof. Dr. Mardson Freitas de Amorim](https://iwada2023.ci.ufpb.br/home/mardson2/).

## Sobre
Um microcontrolador é um dispositivo compacto e altamente integrado que contém um processador central, memória, periféricos de entrada/saída e, em alguns casos, interfaces de comunicação. Ele é projetado para controlar funções específicas em sistemas embarcados. Ao contrário dos microprocessadores, que geralmente precisam de componentes externos para realizar tarefas específicas, os microcontroladores são projetados para serem autossuficientes. <br/>

<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/Microcontrolador.jfif" width="250"> <br/>
  Figura 1: Microcontrolador     <br/>
</p>

A função principal de um microcontrolador é processar informações e controlar dispositivos e sistemas de forma autônoma. Ele executa instruções armazenadas em sua memória para realizar tarefas específicas, como controle de motores, leitura de sensores, processamento de sinais, entre outras. <br/>

## Tipos
Os microcontroladores podem ser categorizados em dois tipos principais em relação à memória: aqueles com memória embutida e aqueles que requerem memória externa.<br/>

Microcontroladores com memória embutida consolidam tanto a memória de programa quanto a memória de dados dentro do mesmo chip. Essa abordagem simplifica consideravelmente o design e a implementação de sistemas embarcados, proporcionando uma solução integrada que facilita o desenvolvimento de aplicações.<br/>

Em contraste, microcontroladores que demandam memória externa podem necessitar de espaço adicional para armazenar programas extensos ou dados suplementares. Nesse cenário, a memória principal do microcontrolador pode ser expandida por meio de interfaces externas, permitindo que o dispositivo lide com demandas de armazenamento mais substanciais.<br/>

Ademais, as variações de microcontroladores se definem também pelas suas configurações disponíveis — pois existem modelos de 4 bits, 8 bits, 16 bits, 32 bits e até de 128 bits, entre muitos outros. Esses valores se referem aos seus números binários. É importante observar que isso reflete diretamente na capacidade de interpretação das informações, permitindo a aplicação de tarefas mais ágeis e até mesmo mais complexas com o tempo.<br/>

## Aplicações
Microcontroladores são peças fundamentais em uma diversidade de setores, desempenhando papéis cruciais em uma ampla gama de aplicações. Eles estão presentes em: Eletrodoméstico; Eletrônicos de consumo; Setor automotivo; Sistemas de controle industrial; Equipamentos médicos; Dispositivos de comunicação; Automação residencial. <br/>

## Benefícios
Eles oferecem uma integração abrangente ao combinar CPU, memória e periféricos em um único chip, simplificando significativamente o design de sistemas embarcados. Essa abordagem compacta contribui para a eficiência no desenvolvimento de dispositivos eletrônicos.<br/>

Além disso, a ênfase em baixo consumo de energia destaca-se como uma característica fundamental em muitos microcontroladores, tornando-os ideais para dispositivos alimentados por bateria. Essa eficiência energética contribui para a durabilidade e vida útil estendida de dispositivos portáteis e sistemas embarcados.<br/>

A característica de serem componentes de baixo custo amplia ainda mais a atratividade dos microcontroladores. Sua acessibilidade financeira torna-os economicamente viáveis para uma ampla variedade de aplicações, impulsionando a inovação em diversos setores.<br/>

A versatilidade é outra vantagem distintiva, pois a programação flexível permite a adaptação dos microcontroladores para diferentes funções e requisitos de sistema. Essa flexibilidade é crucial em ambientes em constante evolução, nos quais a capacidade de adaptação rápida é essencial.<br/>

O tamanho compacto do design dos microcontroladores é especialmente benéfico em aplicações com restrições de espaço. Essa característica é valiosa em dispositivos compactos e sistemas onde o espaço é um recurso limitado.<br/>

Por fim, o desenvolvimento rápido de protótipos é facilitado por ferramentas dedicadas, como compiladores e ambientes de programação, que aceleram o processo de criação e implementação de sistemas embarcados. Essas ferramentas contribuem para a eficácia no desenvolvimento de novas soluções e produtos.<br/>

## Sobre o PIC12F675

O PIC12F675 é um microcontrolador de 8 bits fabricado pela Microchip Technology. Sua arquitetura de processador opera em instruções de 8 bits, sendo adequado para tarefas mais simples e aplicações de controle de baixo a médio nível. Possui uma memória de programa Flash de 1 KB para armazenamento de código, além de 64 bytes de memória RAM para armazenamento temporário de dados durante a execução do programa.<br/>

<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/pic12f675.jfif" width="250"> <br/>
  Figura 2: Microcontrolador PIC12F675     <br/>
</p>

Os periféricos integrados incluem timers/counters, módulo PWM (Pulse Width Modulation), comparadores analógicos e um número limitado de portas de entrada/saída (I/O), facilitando a implementação de diversas funções sem a necessidade de componentes externos em muitos casos. Apesar de sua simplicidade em comparação com modelos mais avançados, o PIC12F675 suporta comunicação serial síncrona (SPI - Serial Peripheral Interface) para facilitar a interação com outros dispositivos.<br/>

Projetado para aplicações de baixo consumo de energia, o PIC12F675 é uma escolha popular em sistemas alimentados por bateria ou em situações onde a eficiência energética é crucial. Seu encapsulamento padrão é geralmente de 8 pinos (DIP-8), conferindo-lhe um tamanho compacto e tornando-o adequado para aplicações com restrições de espaço.<br/>

É importante notar que, devido à sua simplicidade, o PIC12F675 é mais apropriado para aplicações menos complexas. Para projetos mais avançados, microcontroladores de séries superiores da família PIC ou de outras famílias podem ser mais apropriados. Programação para o PIC12F675 geralmente é feita utilizando linguagens como Assembly ou linguagens de alto nível suportadas por compiladores específicos para a arquitetura PIC.<br/>

# Criando o primeiro projeto

Utiliza-se da IDE MPLAB X para executar e visualizar os exercícios propostos. Para criar um novo projeto siga o passo-a-passo abaixo: <br/>

1. Acesse o [Link de Download](https://www.microchip.com/en-us/tools-resources/archives/mplab-ecosystem) para adquirir a versão 4.20 do software (Verificado em 02/02/2024). <br/>

2. Após instalado, clique na seção no canto superior esquerdo `File` e em `New Project`.<br/>

3. Depois disso siga o percurso: `Standalone Project` -> o aparelho que será trabalhado `PIC12F675` -> o debbug header `AC162050` -> `Simulator` -> `mpasm`. <br/>

4. Por fim, clique na opção `Souce Files` dentro do seu projeto (localizado na esquerda) e `Add Existing Item`, adicionando o arquivo que deseja trabalhar (Caso deseje implementar um projeto do início, utilize como base o arquivo `Vazio.ASM` localizado neste repositório). <br/>
<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/instalar7.png" width="250"> <br/>
  Figura 5: Adicionar arquivo no projeto    <br/><br/>
</p>

Para rodar o programa e realizar a verificação de sinal, tempo ou valor das variáveis: <br/>

• Rodar o programa: Primeiramente Clique em `Clean and Build for Debuggin Main Project`, depois em `Launch Debugger Main Project`, depois utilizando a tecla F7 será possível verificar cada linha do código. Caso deseje observar apenas um trecho do código, clique no número da linha para adicionar um breakpoint, podendo pular diretamente para ele utilizando a tecla F5. <br/>
<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/testar1.png" width="250"> 
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/testar2.png" width="250"> <br/>
  Figura 6: Compilar e rodar o projeto     <br/><br/>
</p>

• Para visualizar variáveis: Clique com o botão direito do mouse no nome do projeto, nisso aparecerá um menu. Selecione a opção `Properties` -> Surgirá a janela `Project Properties` -> Selecione a opção `mpasm (Global Options)` -> Habilite a opção `Build in absolute mode` -> Depois, `Apply` e `OK` (Recompile o projeto para que as alterações sejam habilitadas). <br/>
<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/testar4.jpeg" width="250"> <br/>
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/testar5.jfif" width="250"> <br/>
  Figura 7: Visualizar valor das variáveis     <br/><br/>
</p>

•Para visualizar sinal ou tempo: Clique em Window e selecione `Debuggin` (para escolher Stopwatch e visualizar o tempo) ou `Simulator` (para escolher Logic Analyser e visualizar a onda referente ao sinal).
<p align="center">
  <img src="https://github.com/lauradefaria/Microcontroladores/blob/main/imgs/testar3.png" width="250"> <br/>
  Figura 8: Seção para visualizar tempo ou sinal     <br/><br/>
</p>

# Atividades

1. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%201">Atividade 1:  Conversão de hexadecimal para BCD</a>***  <br/>
2. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%202">Atividade 2: Divisão de 2 números e resultado com uma casa decimal</a>***  <br/>
3. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%203">Atividade 3: Ligar e desligar led com timer</a>***  <br/>
4. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%204">Atividade 4: Sete notas musicais, de DÓ a SI (261,63 Hz a 493,88 Hz)</a>***  <br/>
5. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%205">Atividade 5: Manuseando GP2 por interrupção e estímulo externo</a>***  <br/>
6. ***<a href="https://github.com/lauradefaria/Microcontroladores/tree/main/Atividade%206">Atividade 6: Semáforo de trânsito</a>***  <br/>

---
## Autora
|<a href="https://www.linkedin.com/in/lauradefaria/" target="_blank">**Laura de Faria**</a> | 
|:-----------------------------------------------------------------------------------------:|
|                   <img src="imgs/laura.png" width="200px"> </img>                            |
|               <a href="http://github.com/lauradefaria" target="_blank">`github.com/lauradefaria`</a>      |
