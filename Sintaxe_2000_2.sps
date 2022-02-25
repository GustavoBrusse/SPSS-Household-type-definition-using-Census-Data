*CRIANDO VARIAVEIS AUXILIARES PRA CONTAR NUMERO DE FILHOS OUTROS PRENTES E AGREGADOS*.

RECODE V0402 ('01'=1) ('12'=1) (ELSE =0) INTO CHEFE.
RECODE V0402 ('02'=1) (ELSE =0) INTO CONJ.
RECODE V0402 ('03'=1) (ELSE =0) INTO FILENT.

RECODE V0402 ('05'=1) (ELSE =0) INTO NETBIS.
RECODE V0402 ('04'=1) (ELSE =0) INTO PAISOG.

RECODE V0402 ('07'=1) ('06'=1) (ELSE =0) INTO OUTPAR.
RECODE V0402 ('08'=1) ('09'=1) ('10'=1) ('11'=1) (ELSE =0) INTO NAOPAR.
EXECUTE.

SORT CASES BY V0300.
AGGREGATE
  /OUTFILE='C:\Users\Gustavo\Desktop\Doutorado\TESE\Regressao_historico\Domicílios_2000.SAV'
  /PRESORTED
  /BREAK=V0300
  /SCHEFE=SUM(CHEFE) 
  /SCONJ=SUM(CONJ) 
  /SFILENT=SUM(FILENT) 
  /SNETBIS=SUM(NETBIS) 
  /SPAISOG=SUM(PAISOG) 
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
IF (V0401='1') AND (SCONJ=0 AND SFILENT>0) TIPO2=5.

/* Mulher com filhos.
IF  (V0401='2') AND (SCONJ=0 AND SFILENT>0) TIPO2=6.

EXECUTE.

DELETE VARIABLES
v0300
mesoreg
microreg
muniat
distr
subdistr
RM
AREAP
V1005
V1007
V0110
V0111
V0201
V0202
V0203
V0204
V0205
V0206
V0207
V0208
V0209
V0210
V0211
V0212
V0213
V0214
V0215
V0216
V0217
V0218
V0219
V0220
V0221
V0222
V0223
V7100
V7203
V7204
V7401
V7402
V7403
V7404
V7405
V7406
V7407
V7408
V7409
V7616
V7617
pesodom
V1111
V1112
V1113
MARCA
V0402
V0403
V0404
V4754
V4070
V4090
V0410
V0415
V0416
V0417
V0418
V0419
V0420
V4210
V0422
V4230
V0424
V4250
V4260
V4276
V0428
V0429
V0430
V0431
V0433
V0434
V4355
V4300
V0436
V0437
V0440
V0441
V0442
V0443
V0444
V4452
V4462
V0447
V0448
V0449
V0450
V4511
V4512
V4513
V4514
V4521
V4522
V4523
V4524
V4525
V4526
V0453
V0454
V4534
V0455
V0456
V4583
V4593
V4603
V4613
V4615
V4620
V0463
V4654
V4670
V4690
Peso
V4621
V4622
V4631
V4632
V0464
V4671
V4672
V4451
V4461
CHEFE
CONJ
FILENT
NETBIS
PAISOG
OUTPAR
NAOPAR
SCHEFE
SCONJ
SFILENT
SNETBIS
SPAISOG
SOUTPAR
SNAOPAR


*criar idades quinquenais.
STRING idade (A8).
RECODE V4752 (65 thru 69='65 a 69') (70 thru 74='70 a 74') (75 thru 79='75 a 79') (80 thru 
    84='80 a 84') (85 thru 89='85 a 89') (90 thru 94='90 a 94') (95 thru 99='95 a 99') (ELSE='100 e mais') INTO idade.
VARIABLE LABELS  idade 'Idade Quinquenal'.
EXECUTE.

*situação do domicílio.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V1006 ('1'=1) ('2'=2) INTO sitdom.
VARIABLE LABELS  sitdom 'Situação do Domicilio'.
EXECUTE.

*aposentadoria.
RECODE V4573 (0=1) (ELSE=2) INTO aposent.
VARIABLE LABELS  aposent 'Recebe aposentadoria'.
EXECUTE.

*Raca.
RECODE V0408 ('1'=1) ('3'=1) ('2'=2) ('4'=2) ('5'=2) INTO raca.
VARIABLE LABELS  raca 'Raça/Cor'.
EXECUTE.

*Estado civil.
RECODE V0438 ('1'=1) ('2'=3) ('3'=3) ('4'=4) ('5'=2) INTO estadocivil.
VARIABLE LABELS  estadocivil 'Estado Civil'.
EXECUTE.

*escolaridade.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0432 ('9'=1) ('1'=2) ('2'=2) ('3'=3) ('4'=3) ('5'=2) ('6'=3) ('7'=3) ('8'=3) (' '=9) INTO escola.
VARIABLE LABELS  escola 'Escolaridade'.
EXECUTE.

*Trabalha?.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0439 ('1'=1) ('2'=2) INTO trabalho.
VARIABLE LABELS  trabalho 'Trabalha'.
EXECUTE.

*Mora sozinho?.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE TIPO (1=0) (2=0) (3=0) (4=0) (5=0) (6=0) (7=0) (8=1) (9=0) INTO arranjo.
VARIABLE LABELS  arranjo 'Mora sozinho?'.
EXECUTE.

*saude.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0414 ('1'=1) ('2'=1) ('3'=1) ('4'=1) ('5'=0) INTO saude1.
VARIABLE LABELS  saude1 'Deficiencias'.
EXECUTE.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0411 ('1'=1) ('2'=1) ('3'=1) ('4'=0) INTO saude2.
VARIABLE LABELS  saude2 'Enxergar'.
EXECUTE.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0412 ('1'=1) ('2'=1) ('3'=1) ('4'=0) INTO saude3.
VARIABLE LABELS  saude3 'Ouvir'.
EXECUTE.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V0412 ('1'=1) ('2'=1) ('3'=1) ('4'=0) INTO saude4.
VARIABLE LABELS  saude4 'Caminhar'.
EXECUTE.

COMPUTE saudeaux=saude1 + saude2 + saude3 + saude4.
EXECUTE.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE saudeaux (0=0) (1 thru 8 = 1) (ELSE=9) INTO saude.
VARIABLE LABELS  saude 'Saude Final'.
EXECUTE.
