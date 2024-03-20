/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023
					   

  Descrição: Imprime as marcações que foram digitadas/inseridas. A consulta é filtrada por data início e data fim,
			 nessa ordem.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", CONVERT(varchar, PPON.DFPONDATA, 103) "DATA" FROM PFUNFPTO PFUN
INNER JOIN PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA
WHERE PPON.DFPILORIGEM = '2' AND PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '1899-12-30'
AND PPON.DFPONDATA BETWEEN :DATA1 AND :DATA2
