/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: Imprime os funcion�rios que est�o fora da cerca geogr�fica. filtrado por uma data espec�fica.


  Observa��o: Caso a consulta n�o funcione por conta do CONVMIN, tentar:
				  1. Tirar o "FORPONTO." de "FORPONTO.CONVMIN(exemplo)" e deixar apenas "CONVMIN(exemplo)"
				  2. Executar o script: https://github.com/Rapidonet/ConsultasSQL/blob/main/Convmin.sql em 
				  uma nova aba e clicar no F5 na aba da consulta.

------------------------------------------------------------------------------------------------------------------ */


SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", CONVERT(varchar, PMAC.DFPILDATA, 103) + ' ' + FORPONTO.CONVMIN(PMAC.DFPILHORA) AS "DATA E HORA"
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PMACFPTO PMAC ON PMAC.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PMAC.DFEPSCODIGO = PFUN.DFEPSCODIGO
WHERE PMAC.DFMACDISTANCIACERCA > 0 AND PMAC.DFMACDISTANCIACERCA IS NOT NULL AND PMAC.DFPILDATA = DATEADD(day, -1, :DATA);
