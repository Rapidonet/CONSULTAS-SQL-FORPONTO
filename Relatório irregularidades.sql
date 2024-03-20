/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: Imprime os funcion�rios que tem as ocorr�ncias de irreguralidade, bem como a descri��o da mesma. 
             A consulta � filtrada por um per�odo de datas.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", PMTV.DFMTVDESCRICAO "IRREGULARIDADE", CONVERT(varchar, POCO.DFOCODATA, 103) "DATA" FROM PFUNFPTO PFUN
INNER JOIN PMTVFPTO PMTV ON PMTV.DFEPSCODIGO = PFUN.DFEPSCODIGO
INNER JOIN POCOFPTO POCO ON POCO.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PMTV.DFMTVCODIGO = POCO.DFMTVCODIGO
WHERE PMTV.DFMTVCODIGO IN ('078','102', '038', '073') AND PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '1899-12-30'
AND POCO.DFOCODATA BETWEEN :DATAINI AND :DATAFIM


