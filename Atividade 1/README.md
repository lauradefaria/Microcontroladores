# Atividade 1:  Conversão de hexadecimal para BCD
**Objetivo:** Exercícios de familiarização com o conjunto de instruções do PIC. <br/>
**Especificações:** <br/>
• Dado um valor em hexadecimal (1 byte), converter esse valor para a notação BCD.<br/>
• Considere que o valor a ser convertido estará armazenado no registrador WORK e, após a conversão, o valor será armazenado na variável DADO.<br/>
**Saída:** <br/>
• Se o valor convertido for maior que 99, o registrador WORK será utilizado como byte complementar. <br/>
• Se o valor convertido for menor que 99, o registrador WORK deverá conter zero. <br/>

<div align='center'>
    <h4>Exemplos de saída</h4>
    <table>
        <tr><td>Valor (hexadecimal)</td> <td>WORK</td> <td>DADO</td></tr>
        <tr><td>45</td> <td>0</td> <td>69</td></tr>
        <tr><td>64</td> <td>1</td> <td>00</td></tr>
        <tr><td>C5</td> <td>1</td> <td>97</td></tr>
        <tr><td>C8</td> <td>2</td> <td>00</td></tr>
        <tr><td>4D</td> <td>0</td> <td>77</td></tr>
        <tr><td>B5</td> <td>1</td> <td>81</td></tr>
        <tr><td>FC</td> <td>2</td> <td>52</td></tr>
    </table>
</div>

