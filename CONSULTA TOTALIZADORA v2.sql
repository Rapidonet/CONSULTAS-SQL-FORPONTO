/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 22/05/2024

  Descrição: É uma consulta totalizadora, filtrada por um período de datas. Totaliza o horário do almoço,
			 horas trabalhadas, horas extras e total de afastamentos (dos por códigos
			 de ocorrência fornecido pelo cliente) no período selecionado.

------------------------------------------------------------------------------------------------------------------ */

SELECT 
    Dados.MATRÍCULA AS "MATRÍCULA", 
    Dados.FUNCIONÁRIO AS "NOME", 
    Dados."TOTAL HORAS DE ALMOÇO",
    COALESCE(Totais."TOTAL HORAS TRABALHADAS", '00:00') AS "TOTAL HORAS TRABALHADAS",
    COALESCE(Totais."TOTAL HORAS EXTRAS", '00:00') AS "TOTAL HORAS EXTRAS",
    COALESCE(Totais."TOTAL HORAS AFASTAMENTO", '00:00') AS "TOTAL HORAS AFASTAMENTO"
FROM 
(
    SELECT 
        MATRÍCULA, 
        FUNCIONÁRIO, 
        CAST(SUBSTRING(FORPONTO.CONVMIN((SUM(CASE WHEN Linha = 3 THEN DFPILHORA ELSE 0 END) - SUM(CASE WHEN Linha = 2 THEN DFPILHORA ELSE 0 END))), 1, 5) AS VARCHAR) AS "TOTAL HORAS DE ALMOÇO"
    FROM 
    (
        SELECT 
            PFUN.DFFUNCRACHA "MATRÍCULA", 
            PFUN.DFFUNNOME "FUNCIONÁRIO", 
            PPON.DFPILHORA, 
            PPON.DFPONDATA,
            ROW_NUMBER() OVER (PARTITION BY PFUN.DFFUNCRACHA,PPON.DFPONDATA ORDER BY PPON.DFPILDATA, PPON.DFPILHORA) AS Linha 
        FROM FORPONTO.PFUNFPTO PFUN
        INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PORG.DFORGCODIGO = PFUN.DFORGCODIGO
        LEFT JOIN FORPONTO.PPONFPTO PPON ON PPON.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PPON.DFEPSCODIGO = PFUN.DFEPSCODIGO
        WHERE PPON.DFPILDATA BETWEEN :1DATAINI AND :2DATAFIM
    ) AS Dados
    GROUP BY MATRÍCULA, FUNCIONÁRIO
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
) AS Totais ON Dados.MATRÍCULA = Totais.DFFUNCRACHA;
