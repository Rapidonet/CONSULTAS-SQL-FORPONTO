/* ------------------------------------------------------------------------------------------------------------------

                       Autora: Vit�ria Viana | vitoria@rapidonet.com.br
                       Empresa: Rapidonet Sistemas e Automa��o
					   
					   Software: FORPONTO
                       Data da �ltima modifica��o: 02/10/2023

  Descri��o: Imprime saldo de horas dos funcion�rios filtrado por um per�odo de datas.


  Observa��o: Relat�rio puxa as informa��es majoritariamente da tabela de rel�torio saldo de banco de horas.

------------------------------------------------------------------------------------------------------------------ */

SELECT PFUN.DFFUNCRACHA "MATR�CULA", PFUN.DFFUNNOME "NOME", PORG.DFORGCODIGO "SETOR", PORG.DFORGDESCRICAO "DESCRI��O DO SETOR", 
PEBH.DFEBHEXECUCAO "DATA EXECU��O", FORPONTO.CONVMIN(CASE WHEN PEBH.DFEBHHORAS > 0 THEN PEBH.DFEBHHORAS ELSE ' ' END) "SALDO POSITIVO",
FORPONTO.CONVMIN(CASE WHEN PEBH.DFEBHHORAS < 0 THEN PEBH.DFEBHHORAS ELSE ' ' END) "SALDO NEGATIVO"FROM FORPONTO.PFUNFPTO PFUN
INNER JOIN FORPONTO.PORGFPTO PORG ON PORG.DFEPSCODIGO = PFUN.DFEPSCODIGO AND PFUN.DFORGCODIGO = PORG.DFORGCODIGO
INNER JOIN FORPONTO.PEBHFPTO PEBH ON PEBH.DFFUNCRACHA = PFUN.DFFUNCRACHA AND PORG.DFEPSCODIGO = PEBH.DFEPSCODIGO
WHERE PEBH.DFEBHCOLUNA = 'SALDO' AND PEBH.DFEBHDATA BETWEEN :1DATAINI�AND�:2DATAFIM

