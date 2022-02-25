*CRIANDO VARIAVEIS AUXILIARES PRA CONTAR NUMERO DE FILHOS OUTROS PRENTES E AGREGADOS*.

RECODE V0302 ('01'=1) ('20'=1) (ELSE =0) INTO CHEFE.
RECODE V0302 ('02'=1) (ELSE =0) INTO CONJ.
RECODE V0302 ('03'=1) ('04'=1) (ELSE =0) INTO FILENT.

RECODE V0302 ('08'=1) (ELSE =0) INTO NETBIS.
RECODE V0302 ('05'=1) ('06'=1)  (ELSE =0) INTO PAISOG.
RECODE V0302 ('07'=1)  (ELSE =0) INTO AVO.

RECODE V0302 ('09'=1) ('10'=1) ('11'=1) ('12'=1) (ELSE =0) INTO OUTPAR.
RECODE V0302 ('13'=1) ('14'=1) ('15'=1) ('16'=1) (ELSE =0) INTO NAOPAR.
EXECUTE.


SORT CASES BY V0102.
AGGREGATE
  /OUTFILE='C:\Users\Gustavo\Desktop\Doutorado\TESE\Regressao_historico\Domicilios_1991.SAV'
  /PRESORTED
  /BREAK=V0102
  /SCHEFE=SUM(CHEFE) 
  /SCONJ=SUM(CONJ) 
  /SFILENT=SUM(FILENT) 
  /SNETBIS=SUM(NETBIS) 
  /SPAISOG=SUM(PAISOG) 
  /SAVO=SUM(AVO) 
  /SOUTPAR=SUM(OUTPAR) 
  /SNAOPAR=SUM(NAOPAR).


DATASET ACTIVATE DataSet2.

/* Homem ou mulher UNIPESSOAL. (one person only).
IF  (SCONJ=0 AND SFILENT=0) TIPO2=1.

/* Homem ou mulher com não parentes (one person and other).
IF  (SCONJ=0 AND SFILENT=0) AND (SPAISOG>0 OR SOUTPAR>0 OR SNAOPAR>0) TIPO2=2.

/* Casal sem filhos.
IF  (SCONJ=1 AND SFILENT=0)  TIPO2=3. 

/* Casal com filhos.
IF  (SCONJ=1 AND SFILENT>0) TIPO2=4.

/* Homem com filhos.
IF (V0301='1') AND (SCONJ=0 AND SFILENT>0) TIPO2=5.

/* Mulher com filhos.
IF  (V0301='2') AND (SCONJ=0 AND SFILENT>0) TIPO2=6.

EXECUTE.

DELETE VARIABLES
V0102
V7004
V0098
mesoreg
microreg
muniat
V0109
V7003
V0111
V0112
V0201
V2012
V2013
V2014
V0202
V0203
V0204
V0205
V0206
V0207
V0208
V0209
V2094
V0210
V0211
V2111
V2112
V0212
V2121
V2122
V0213
V0214
V0216
V0217
V0218
V0219
V0220
V0221
V0222
V0223
V0224
V0225
V0226
V0227
pesodom
V0302
V0303
V0304
V2011
v3041
v3042
V3043
V3044
V3045
V3046
V3047
V3049
V3005
V3071
v3073
V0312
v0313
V0314
V3151
V3152
V0316
v0317
v0318
v0319
v3191
muant
V0320
v0321
v3211
mun86
V0322
V0323
V0324
V0325
V0326
V0327
v3241
V0329
V0330
v3311
v3312
v3341
v0346
v3461
V0347
v3471
V0349
V0350
V0351
V0352
V0353
V0354
V0355
V0356
V3562
V3563
V3564
V0357
V3574
V0358
V0360
V3604
V0361
V3614
v3351
v3352
v3353
v3354
v3355
v3356
v3360
v3361
v3362
v0335
v0336
v0337
v0338
v0339
v0340
v3357
v0341
v0342
V0343
v3443
V3444
V0310
peso
CHEFE
CONJ
FILENT
NETBIS
PAISOG
AVO
OUTPAR
NAOPAR
SCHEFE
SCONJ
SFILENT
SNETBIS
SPAISOG
SAVO
SOUTPAR
SNAOPAR

*criar idades quinquenais.
STRING idade (A8).
RECODE V3072 (65 thru 69='65 a 69') (70 thru 74='70 a 74') (75 thru 79='75 a 79') (80 thru 
    84='80 a 84') (85 thru 89='85 a 89') (90 thru 94='90 a 94') (95 thru 99='95 a 99') (ELSE='100 e mais') INTO idade.
VARIABLE LABELS  idade 'Idade Quinquenal'.
EXECUTE.

*situação do domicílio.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V1061 ('1'=1) ('2'=2) ('3'=1) ('4'=2) ('5'=2) ('6'=2) ('7'=2) ('8'=2) INTO sitdom.
VARIABLE LABELS  sitdom 'Situação do Domicilio'.
EXECUTE.

*aposentadoria.
RECODE V0359 ('0'=2) ('1'=1) ('2'=1) ('3'=1) (ELSE=1) INTO aposent.
VARIABLE LABELS  aposent 'Recebe aposentadoria'.
EXECUTE.

*Raca.
RECODE V0309 ('1'=1) ('3'=1) ('2'=2) ('4'=2) ('5'=2) INTO raca.
VARIABLE LABELS  raca 'Raça/Cor'.
EXECUTE.

*Estado civil.
RECODE V0332 (MISSING='0') (' '='0').
EXECUTE.
RECODE V0333 (MISSING='0') (' '='0').
EXECUTE.
*variaveis como numeric.
COMPUTE estadocivil=V0332 + V0333.
EXECUTE.
RECODE estadocivil (1=1) (2=1) (3=1) (4=2) (5=3) (6=3) (7=3) (8=4) (9=2) (0=2) (9=2).
EXECUTE.

*escolaridade.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0328 ('0'=1) ('1'=2) ('2'=2) ('3'=3) ('4'=3) ('5'=3) ('6'=3) ('7'=3) ('8'=3) ('9'=9) INTO escola.
VARIABLE LABELS  escola 'Escolaridade'.
EXECUTE.

*Trabalha?.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0345 ('1'=1) ('2'=1) ('3'=2) INTO trabalho.
VARIABLE LABELS  trabalho 'Trabalha'.
EXECUTE.

*Mora sozinho?.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE TIPO (1=0) (2=0) (3=0) (4=0) (5=0) (6=0) (7=0) (8=1) (9=0) INTO arranjo.
VARIABLE LABELS  arranjo 'Mora sozinho?'.
EXECUTE.

*saude.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0311 ('0'=2) ('1'=1) ('2'=1) ('3'=1) ('4'=1) ('5'=1) ('6'=1) ('7'=1) ('8'=1) ('9'=9) INTO saude.
VARIABLE LABELS  saude 'Possui deficiencia?'.
EXECUTE.







