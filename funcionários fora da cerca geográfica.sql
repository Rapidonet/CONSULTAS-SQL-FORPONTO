/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023

  Descrição: Imprime os funcionários que estão fora da cerca geográfica. filtrado por uma data específica.


  Observação: Caso a consulta não funcione por conta do CONVMIN, tentar:
				  1. Tirar o "FORPONTO." de "FORPONTO.CONVMIN(exemplo)" e deixar apenas "CONVMIN(exemplo)"
				  2. Executar o script: https://github.com/Rapidonet/ConsultasSQL/blob/main/Convmin.sql em 
				  uma nova aba e clicar no F5 na aba da consulta.

------------------------------------------------------------------------------------------------------------------ */


SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", CONVERT(varchar, PMAC.DFPILDATA, 103) + ' ' + FORPONTO.CONVMIN(PMAC.DFPILHORA) AS "DATA E HORA"
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PMACFPTO PMAC ON PMAC.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PMAC.DFEPSCODIGO = PFUN.DFEPSCODIGO
WHERE PMAC.DFMACDISTANCIACERCA > 0 AND PMAC.DFMACDISTANCIACERCA IS NOT NULL AND PMAC.DFPILDATA = DATEADD(day, -1, :DATA);
