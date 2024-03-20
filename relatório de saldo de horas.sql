/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vitória Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automação
					   
					   Software: FORPONTO
                       Data da última modificação: 02/10/2023

  Descrição: Imprime saldo de horas dos funcionários filtrado por um período de datas.


  Observação: Relatório puxa as informações majoritariamente da tabela de relátorio saldo de banco de horas.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATRÍCULA", PFUN.DFFUNNOME "NOME", PORG.DFORGCODIGO "SETOR", PORG.DFORGDESCRICAO "DESCRIÇÃO DO SETOR", 
PEBH.DFEBHEXECUCAO "DATA EXECUÇÃO", FORPONTO.CONVMIN(CASE WHEN PEBH.DFEBHHORAS > 0 THEN PEBH.DFEBHHORAS ELSE ' ' END) "SALDO POSITIVO",
FORPONTO.CONVMIN(CASE WHEN PEBH.DFEBHHORAS < 0 THEN PEBH.DFEBHHORAS ELSE ' ' END) "SALDO NEGATIVO"FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PFUN.DFORGCODIGO = PORG.DFORGCODIGO
INNER JOIN FORPONTO.PEBHFPTO PEBH ON PEBH.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PORG.DFEPSCODIGO = PEBH.DFEPSCODIGO
WHERE PEBH.DFEBHCOLUNA = 'SALDO' AND PEBH.DFEBHDATA BETWEEN :1DATAINI AND :2DATAFIM

