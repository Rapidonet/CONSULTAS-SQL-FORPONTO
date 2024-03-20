/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023

  Descrição: Imprime os funcionários que tem as ocorrências de irreguralidade, bem como a descrição da mesma. 
             A consulta é filtrada por um período de datas.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", PMTV.DFMTVDESCRICAO "IRREGULARIDADE", CONVERT(varchar, POCO.DFOCODATA, 103) "DATA" FROM PFUNFPTO PFUN
INNER JOIN PMTVFPTO PMTV ON PMTV.DFEPSCODIGO = PFUN.DFEPSCODIGO
INNER JOIN POCOFPTO POCO ON POCO.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PMTV.DFMTVCODIGO = POCO.DFMTVCODIGO
WHERE PMTV.DFMTVCODIGO IN ('078','102', '038', '073') AND PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '1899-12-30'
AND POCO.DFOCODATA BETWEEN :DATAINI AND :DATAFIM


