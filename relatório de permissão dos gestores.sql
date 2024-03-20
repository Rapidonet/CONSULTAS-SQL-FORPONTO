/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023

  Descrição: imprime os tipos de permissão e visibilidade que os gestores tem

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", PUSU.DFUSUPERMITIDA "PERMISSÕES", PUSU.DFUSUVISIVEL "VISIBILIDADE" 
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PUSUFPTO PUSU ON PUSU.DFFUNCRACHA = PFUN.DFFUNCRACHA
