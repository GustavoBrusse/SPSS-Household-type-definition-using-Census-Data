RECODE V503 ('0'=1) ('1'=1) (ELSE =0) INTO CHEFE.
RECODE V503 ('2'=1) (ELSE =0) INTO CONJ.
RECODE V503 ('3'=1) (ELSE =0) INTO FILENT.

RECODE V503 ('4'=1) (ELSE =0) INTO PAISOG.

RECODE V503 ('5'=1) (ELSE =0) INTO OUTPAR.
RECODE V503 ('6'=1) ('7'=1) ('8'=1) ('9'=1) (ELSE =0) INTO NAOPAR.
EXECUTE.

SORT CASES BY V601.
AGGREGATE
  /OUTFILE='C:\Users\Gustavo\Desktop\Doutorado\TESE\Regressao_historico\Domicilios_1980.SAV'
  /PRESORTED
  /BREAK=V601
  /SCHEFE=SUM(CHEFE) 
  /SCONJ=SUM(CONJ) 
  /SFILENT=SUM(FILENT) 
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
IF (V501='1') AND (SCONJ=0 AND SFILENT>0) TIPO2=5.

/* Mulher com filhos.
IF  (V501='3') AND (SCONJ=0 AND SFILENT>0) TIPO2=6.

EXECUTE.

DELETE VARIABLES
V601
mesoreg
microreg
muniat
distr
V201
V202
V203
V204
V205
V206
V207
V208
V209
V602
V211
V212
V213
V214
V215
V216
V217
V218
V219
V220
V221
pesodom
V598
V503
V504
V505
V605
V508
V511
V512
V513
V514
V515
V516
V517
V518
V519
V520
V521
V522
V523
V525
V527
V529
V681
V530
V532
V533
V534
V535
V680
V607
V608
V540
V541
V682
V536
V609
V542
V544
V545
V611
V612
V613
V510
V550
V551
V552
V553
V554
V555
V556
V557
V570
CHEFE
CONJ
FILENT
PAISOG
OUTPAR
NAOPAR
SCHEFE
SCONJ
SFILENT
SPAISOG
SOUTPAR
SNAOPAR

*criar idades quinquenais.
STRING idadequinquenal (A8).
RECODE V606 (65 thru 69='65 a 69') (70 thru 74='70 a 74') (75 thru 79='75 a 79') (80 thru 
    84='80 a 84') (85 thru 89='85 a 89') (90 thru 94='90 a 94') (95 thru 99='95 a 99') (ELSE='100 e mais') INTO idade.
VARIABLE LABELS  idadequinquenal 'Idade Quinquenal'.
EXECUTE.

*situação do domicílio.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V198 ('1'=1) ('3'=1) ('5'=2) ('7'=2) INTO sitdom.
VARIABLE LABELS  sitdom 'Situação do Domicilio'.
EXECUTE.

*aposentadoria.
RECODE V610 (0=2) (ELSE=1) INTO aposent.
VARIABLE LABELS  aposent 'Recebe aposentadoria'.
EXECUTE.

*Raca.
RECODE V509 ('2'=1) ('6'=1) ('4'=2) ('8'=2) INTO raca.
VARIABLE LABELS  raca 'Raça/Cor'.
EXECUTE.

*Sexo.
RECODE V501 ('3'='2').
EXECUTE.

*Estado civil.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V526 ('1'=1) ('2'=1) ('3'=1) ('4'=1) ('5'=2) ('6'=3) ('7'=3) ('8'=3) ('0'=4) ('9'=9) (' '=9) INTO estadocivil.
VARIABLE LABELS  estadocivil 'Estado Civil'.
EXECUTE.

*escolaridade.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE V524 ('0'=1) ('1'=2) ('2'=2) ('3'=3) ('4'=3) ('5'=3) ('6'=3) ('7'=3) ('8'=3) ('9'=9) INTO escola.
VARIABLE LABELS  escola 'Escolaridade'.
EXECUTE.

*Trabalha?.
RECODE V528 ('3'='2').
EXECUTE.

*Trabalha?.
RECODE aposent ('0'='2').
EXECUTE.


*Mora sozinho?.
DATASET ACTIVATE Conjunto_de_dados1.
RECODE TIPO (1=0) (2=0) (3=0) (4=0) (5=0) (6=0) (7=0) (8=1) (9=0) INTO arranjo.
VARIABLE LABELS  arranjo 'Mora sozinho?'.
EXECUTE.
