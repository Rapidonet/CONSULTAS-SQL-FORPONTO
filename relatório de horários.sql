/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: Imprime os hor�rios de cada funcion�rio

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", PHOR.DFHORDESCRICAO FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PFUHFPTO PFUH ON PFUH.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PFUH.DFEPSCODIGO = PFUN.DFEPSCODIGO
AND PFUH.DFFUHTERMINO = '29991231'
INNER JOIN FORPONTO.PHORFPTO PHOR ON PHOR.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PHOR.DFHORCODIGO = PFUH.DFHORCODIGO
WHERE PHOR.DFHORCODIGO = '0001' 