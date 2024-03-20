/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 05/09/2023

  Descri��o: script filtrado por data e pelo c�digo das ocorr�ncias, retorna dados do funcion�rio bem como a data
  das ocorr�ncias desejadas e sua descri��o.

------------------------------------------------------------------------------------------------------------------ */


SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", PORG.DFORGCODIGO "CENTRO DE CUSTO", POCO.DFOCODATA "DATA DA OCORR�NCIA",
POCO.DFMTVCODIGO "C�DIGO DA OCORR�NCIA", PMTV.DFMTVDESCRICAO "DESCRI��O DA OCORR�NCIA"
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFORGCODIGO = PFUN.DFORGCODIGO AND PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO
INNER JOIN FORPONTO.POCOFPTO POCO ON POCO.DFFUNCRACHA = PFUN.DFFUNCRACHA AND POCO.DFEPSCODIGO = PORG.DFEPSCODIGO 
INNER JOIN FORPONTO.PMTVFPTO PMTV ON PMTV.DFMTVCODIGO = POCO.DFMTVCODIGO AND PMTV.DFEPSCODIGO = POCO.DFEPSCODIGO
WHERE POCO.DFMTVCODIGO IN (:MTV1, :MTV2, :MTV3, :MTV4) AND POCO.DFOCODATA BETWEEN�:DATA1�AND�:DATA2