/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 22/05/2024

  Descri��o: � uma consulta totalizadora, filtrada por um per�odo de datas. Totaliza o hor�rio do almo�o,
			 horas trabalhadas, horas extras e total de afastamentos (dos por c�digos
			 de ocorr�ncia fornecido pelo cliente) no per�odo selecionado.

------------------------------------------------------------------------------------------------------------------ */

SELECT 
    Dados.MATR�CULA AS "MATR�CULA", 
    Dados.FUNCION�RIO AS "NOME", 
    Dados."TOTAL HORAS DE ALMO�O",
    COALESCE(Totais."TOTAL HORAS TRABALHADAS", '00:00') AS "TOTAL HORAS TRABALHADAS",
    COALESCE(Totais."TOTAL HORAS EXTRAS", '00:00') AS "TOTAL HORAS EXTRAS",
    COALESCE(Totais."TOTAL HORAS AFASTAMENTO", '00:00') AS "TOTAL HORAS AFASTAMENTO"
FROM 
(
    SELECT 
        MATR�CULA, 
        FUNCION�RIO, 
        CAST(SUBSTRING(FORPONTO.CONVMIN((SUM(CASE WHEN Linha = 3 THEN DFPILHORA ELSE 0 END) - SUM(CASE WHEN Linha = 2 THEN DFPILHORA ELSE 0 END))), 1, 5) AS VARCHAR) AS "TOTAL HORAS DE ALMO�O"
    FROM 
    (
        SELECT 
            PFUN.DFFUNCRACHA "MATR�CULA", 
            PFUN.DFFUNNOME "FUNCION�RIO", 
            PPON.DFPILHORA, 
            PPON.DFPONDATA,
            ROW_NUMBER() OVER (PARTITION BY PFUN.DFFUNCRACHA,PPON.DFPONDATA ORDER BY PPON.DFPILDATA, PPON.DFPILHORA) AS Linha 
        FROM FORPONTO.PFUNFPTO PFUN
        INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PORG.DFORGCODIGO = PFUN.DFORGCODIGO
        LEFT JOIN FORPONTO.PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PPON.DFEPSCODIGO = PFUN.DFEPSCODIGO
        WHERE PPON.DFPILDATA BETWEEN :1DATAINI AND :2DATAFIM
    ) AS Dados
    GROUP BY MATR�CULA, FUNCION�RIO
) AS Dados
LEFT JOIN
(
    SELECT 
        PFUN.DFFUNCRACHA, 
        PFUN.DFFUNNOME, 
        CAST(FORPONTO.CONVMIN(SUM(CASE WHEN POCO.DFMTVCODIGO in ('001', '041', '044') THEN POCO.DFOCOHORA ELSE 0 END)) AS VARCHAR) AS "TOTAL HORAS TRABALHADAS",
        CAST(FORPONTO.CONVMIN(SUM(CASE WHEN POCO.DFMTVCODIGO in ('003', '015', '018', '026', '027', '037', '038', '042', '043') THEN POCO.DFOCOHORA ELSE 0 END)) AS VARCHAR) AS "TOTAL HORAS EXTRAS",
        CAST(FORPONTO.CONVMIN(SUM(CASE WHEN POCO.DFMTVCODIGO in ('004', '016', '019', '029', '045') THEN POCO.DFOCOHORA ELSE 0 END)) AS VARCHAR) AS "TOTAL HORAS AFASTAMENTO"
    FROM forponto.POCOFPTO POCO
    INNER JOIN FORPONTO.PFUNFPTO PFUN ON PFUN.DFFUNCRACHA = POCO.DFFUNCRACHA 
    WHERE POCO.DFOCODATA BETWEEN :1DATAINI AND :2DATAFIM AND PFUN.DFFUNATIVO = 'S' AND PFUN.DFFUNDATADEMISSAO = '18991230'
    GROUP BY PFUN.DFFUNCRACHA, PFUN.DFFUNNOME
) AS Totais ON Dados.MATR�CULA = Totais.DFFUNCRACHA;
