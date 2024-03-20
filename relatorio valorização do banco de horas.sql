/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 16/02/24
					   
  Descri��o: Relat�rio de valoriza��o do banco de horas, filtrado por um per�odo de datas.

------------------------------------------------------------------------------------------------------------------ */

SELECT DISTINCT POCO.DFFUNCRACHA "MATRICULA", PFUN.DFFUNNOME "NOME", CONVERT(varchar, POCO.DFOCODATA, 103) "DATA", POCO.DFMTVCODIGO "C�DIGO", 
PMTV.DFMTVDESCRICAO "DESCRI��O", FORPONTO.CONVMIN(CAST(ROUND(POCO.DFOCOHORA * PBCM.DFBCMFATOR, 0) AS INT)) "HORAS"
FROM POCOFPTO POCO
INNER JOIN PFUNFPTO PFUN ON PFUN.DFFUNCRACHA = POCO.DFFUNCRACHA
INNER JOIN PMTVFPTO PMTV ON PMTV.DFMTVCODIGO = POCO.DFMTVCODIGO
INNER JOIN PFUBFPTO PFUB ON PFUB.DFFUNCRACHA = PFUN.DFFUNCRACHA 
INNER JOIN PBCMFPTO PBCM ON PBCM.DFBCOCODIGO = PFUB.DFBCOCODIGO AND PBCM.DFMTVCODIGO = PMTV.DFMTVCODIGO
WHERE POCO.DFMTVCODIGO IN ('325','326','327','329','336','337','416','425','321','330',
'338','417','421','422','423','424','512') and DFOCODATA between :DATA1 and :DATA2
