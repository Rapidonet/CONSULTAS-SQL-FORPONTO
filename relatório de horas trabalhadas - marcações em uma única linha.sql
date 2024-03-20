/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023
					   

  Descri��o: Script sql que calcula as horas trabalhadas do funcion�rio. em uma �nica linha tr�s
			 todas as marca��es di�rias e na coluna final tr�s o total das horas trabalhadas. a consulta �
			 filtrada por um per�odo de datas especificado.
			 

			 
  Observa��o 1: Caso esteja tentando rodar a consulta diretamente no banco, o fato de FORPONTO.[CONVMIN]
                estar grifado de vermelho n�o � problema SE a fun��o j� existir no banco.
				
  Observa��o 2: Caso a consulta n�o funcione POR CONTA DO CONVMIN, tentar:
				  1. Tirar o "FORPONTO." de "FORPONTO.CONVMIN(exemplo)" e deixar apenas "CONVMIN(exemplo)"
				  2. Executar o script: https://github.com/Rapidonet/ConsultasSQL/blob/main/Convmin.sql em 
				  uma nova aba e clicar no F5 na aba da consulta.

------------------------------------------------------------------------------------------------------------------ */


SELECT MATR�CULA, FUNCION�RIO, TIPO,
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([1]), 1, 5) AS VARCHAR) AS "HOR�RIO DE ENTRADA",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([2]), 1, 5) AS VARCHAR) AS "HOR�RIO DE SA�DA PARA REFEI��O",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([3]), 1, 5) AS VARCHAR) AS "HOR�RIO DE VOLTA DA REFEI��O",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([4]), 1, 5) AS VARCHAR) AS "HOR�RIO DE SA�DA",
		CAST(SUBSTRING(FORPONTO.[CONVMIN](((ISNULL(([2] - [1]), 0) + ISNULL(([4] - [3]), 0)))), 1, 5) AS VARCHAR) AS "HORAS TRABALHADAS"
FROM 
(SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "FUNCION�RIO", PORG.DFORGDESCRICAO "TIPO", PPON.DFPILHORA,
ROW_NUMBER() OVER (PARTITION BY PFUN.DFFUNCRACHA,PPON.DFPONDATA ORDER BY PPON.DFPILDATA, PPON.DFPILHORA) AS Linha 
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PORG.DFORGCODIGO = PFUN.DFORGCODIGO
INNER JOIN FORPONTO.PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PPON.DFEPSCODIGO = PFUN.DFEPSCODIGO
WHERE PPON.DFPILDATA BETWEEN :DATA1 AND :DATA2)
AS Dados
PIVOT (
    MAX(DFPILHORA) FOR Linha IN ([1], [2], [3], [4])
) AS PivotTable
ORDER BY MATR�CULA



