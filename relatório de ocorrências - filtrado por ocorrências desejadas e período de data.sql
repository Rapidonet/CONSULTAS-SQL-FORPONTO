/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 05/09/2023

  Descrição: script filtrado por data e pelo código das ocorrências, retorna dados do funcionário bem como a data
  das ocorrências desejadas e sua descrição.

------------------------------------------------------------------------------------------------------------------ */


SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", PORG.DFORGCODIGO "CENTRO DE CUSTO", POCO.DFOCODATA "DATA DA OCORRÊNCIA",
POCO.DFMTVCODIGO "CÓDIGO DA OCORRÊNCIA", PMTV.DFMTVDESCRICAO "DESCRIÇÃO DA OCORRÊNCIA"
FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFORGCODIGO = PFUN.DFORGCODIGO AND PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO
INNER JOIN FORPONTO.POCOFPTO POCO ON POCO.DFFUNCRACHA = PFUN.DFFUNCRACHA AND POCO.DFEPSCODIGO = PORG.DFEPSCODIGO 
INNER JOIN FORPONTO.PMTVFPTO PMTV ON PMTV.DFMTVCODIGO = POCO.DFMTVCODIGO AND PMTV.DFEPSCODIGO = POCO.DFEPSCODIGO
WHERE POCO.DFMTVCODIGO IN (:MTV1, :MTV2, :MTV3, :MTV4) AND POCO.DFOCODATA BETWEEN :DATA1 AND :DATA2