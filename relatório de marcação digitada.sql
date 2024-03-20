/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023
					   

  Descri��o: Imprime as marca��es que foram digitadas/inseridas. A consulta � filtrada por data in�cio e data fim,
			 nessa ordem.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", CONVERT(varchar, PPON.DFPONDATA, 103) "DATA" FROM PFUNFPTO PFUN
INNER JOIN PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA
WHERE PPON.DFPILORIGEM = '2' AND PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '1899-12-30'
AND PPON.DFPONDATA BETWEEN :DATA1 AND :DATA2
