/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023
					   

  Descrição: Script sql que calcula as horas trabalhadas do funcionário. em uma única linha trás
			 todas as marcações diárias e na coluna final trás o total das horas trabalhadas. a consulta é
			 filtrada por um período de datas especificado.
			 

			 
  Observação 1: Caso esteja tentando rodar a consulta diretamente no banco, o fato de FORPONTO.[CONVMIN]
                estar grifado de vermelho não é problema SE a função já existir no banco.
				
  Observação 2: Caso a consulta não funcione POR CONTA DO CONVMIN, tentar:
				  1. Tirar o "FORPONTO." de "FORPONTO.CONVMIN(exemplo)" e deixar apenas "CONVMIN(exemplo)"
				  2. Executar o script: https://github.com/Rapidonet/ConsultasSQL/blob/main/Convmin.sql em 
				  uma nova aba e clicar no F5 na aba da consulta.

------------------------------------------------------------------------------------------------------------------ */


SELECT MATRÍCULA, FUNCIONÁRIO, TIPO,
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([1]), 1, 5) AS VARCHAR) AS "HORÁRIO DE ENTRADA",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([2]), 1, 5) AS VARCHAR) AS "HORÁRIO DE SAÍDA PARA REFEIÇÃO",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([3]), 1, 5) AS VARCHAR) AS "HORÁRIO DE VOLTA DA REFEIÇÃO",
		CAST(SUBSTRING(FORPONTO.[CONVMIN]([4]), 1, 5) AS VARCHAR) AS "HORÁRIO DE SAÍDA",
		CAST(SUBSTRING(FORPONTO.[CONVMIN](((ISNULL(([2] - [1]), 0) + ISNULL(([4] - [3]), 0)))), 1, 5) AS VARCHAR) AS "HORAS TRABALHADAS"
FROM 
(SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "FUNCIONÁRIO", PORG.DFORGDESCRICAO "TIPO", PPON.DFPILHORA,
ROW_NUMBER() OVER (PARTITION BY PFUN.DFFUNCRACHA,PPON.DFPONDATA ORDER BY PPON.DFPILDATA, PPON.DFPILHORA) AS Linha 
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PORG.DFORGCODIGO = PFUN.DFORGCODIGO
INNER JOIN FORPONTO.PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PPON.DFEPSCODIGO = PFUN.DFEPSCODIGO
WHERE PPON.DFPILDATA BETWEEN :DATA1 AND :DATA2)
AS Dados
PIVOT (
    MAX(DFPILHORA) FOR Linha IN ([1], [2], [3], [4])
) AS PivotTable
ORDER BY MATRÍCULA



