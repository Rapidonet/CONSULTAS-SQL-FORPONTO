/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023

  Descrição: Imprime os funcionários que estão ativos

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", PHOR.DFHORDESCRICAO FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PFUHFPTO PFUH ON PFUH.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PFUH.DFEPSCODIGO = PFUN.DFEPSCODIGO
AND PFUH.DFFUHTERMINO = '29991231'
INNER JOIN FORPONTO.PHORFPTO PHOR ON PHOR.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PHOR.DFHORCODIGO = PFUH.DFHORCODIGO
WHERE PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '1899-12-30'