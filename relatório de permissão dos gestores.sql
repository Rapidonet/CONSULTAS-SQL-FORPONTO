/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: imprime os tipos de permiss�o e visibilidade que os gestores tem

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", PUSU.DFUSUPERMITIDA "PERMISS�ES", PUSU.DFUSUVISIVEL "VISIBILIDADE" 
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PUSUFPTO PUSU ON PUSU.DFFUNCRACHA = PFUN.DFFUNCRACHA
