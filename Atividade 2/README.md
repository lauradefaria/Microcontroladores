# Atividade 2: Divisão de 2 números e resultado com uma casa decimal
**Objetivo:** Exercícios de familiarização com o conjunto de instruções do PIC. <br/>
**Especificações:** <br/>
• Dados dois valores de 1 byte, produzir o quociente entre esses valores com uma casa decimal de precisão.<br/>
• Considere-se que os dados estarão armazenados nas variáveis DADO e WORK.<br/>
• O programa fará o quociente: DADO dividido por WORK ( DADO / WORK ).<br/>
**Saída:** <br/>
• a parte inteira do cálculo ficará armazenada em DADO.<br/>
• A casa decimal (de 0 a 9) ficará armazenada em WORK. Essa casa decimal deve utilizar as regras de arredondamento.<br/>
**Exemplo de saída:** <br/>
• DADO=17 ; WORK=3 <br/>
• DADO / WORK = 5,66666... -> DADO=5 ; WORK=7<br/>

<div align='center'>
    <h4>Exemplos de teste<br/> Entrada & Saída</h4>
    <table>
        <tr><td>DADO</td> <td>WORK</td> <td>DADO</td> <td>WORK</td></tr>
        <tr><td>7</td> <td>6</td> <td>1</td> <td>2</td></tr>
        <tr><td>13</td> <td>5</td> <td>2</td> <td>6</td></tr>
        <tr><td>137</td> <td>35</td> <td>3</td> <td>9</td></tr>
        <tr><td>128</td> <td>16</td> <td>8</td> <td>0</td></tr>
        <tr><td>158</td> <td>80</td> <td>2</td> <td>0</td></tr>
    </table>
</div>

-> AJUSTANDO O CÓDIGO!!
