***duplicate3***************************************************
*******************************************************
*For optimal accuracy, convergence, and runtime
***************************************************
.options POST
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-15 
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13

.param   TEMP=27
***************************************************


***************************************************
*Include relevant model files
***************************************************
.lib 'GNRFET.lib' GNRFET
***************************************************
*Supplies and voltage params:
*.param Supply=0.5 	
*.param Vg='Supply'
*.param Vd='Supply'
 
***********************************************************************
* Define out supply
***********************************************************************
*Vdd     Drain     Gnd     Vd
*Vss     Source    Gnd     0
*Vgg 	  Gate	Gnd	  Vg
*Vsub    Sub       Gnd     0
*Vdd     1     0     0.9

***********************************************************************
* Main Circuits
***********************************************************************
.option post=2

.subckt tx1 D in 
XGNR1 in clk1 D D GNRFETPMOS nRib=6 n=9 L=32n Tox=0.95n sp=2n dop=0.001 p=0 
XGNR0 in clk2 D D GNRFETNMOS nRib=6 n=9 L=32n Tox=0.95n sp=2n dop=0.001 p=0

C1 in gnd  0.95fF
VVoltageSource_5 clk1 Gnd PULSE(0 0.9 0n  0.01n 0.01n 6.125n 12.5n)
VVoltageSource_6 clk2 Gnd PULSE(0.9 0 0n 0.01n 0.01n 6.125n 12.5n)
.ends



.subckt tx2 D in 
XGNR1 in clk2 D D GNRFETPMOS nRib=9 n=9 L=32n Tox=0.95n sp=2n dop=0.001 p=0 
XGNR0 in clk1 D D GNRFETNMOS nRib=9 n=9 L=32n Tox=0.95n sp=2n dop=0.001 p=0

C1 in gnd  0.95fF
VVoltageSource_5 clk1 Gnd PULSE(0 0.9 0n  0.01n 0.01n 6.125n 12.5n)
VVoltageSource_6 clk2 Gnd PULSE(0.9 0 0n 0.01n 0.01n 6.125n 12.5n)
.ends

.subckt sti in out
XGNR0 AP in gnd gnd GNRFETNMOS nRib=6 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR1 AP in vdd1 vdd1 GNRFETPMOS nRib=6 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 
*NTI
XGNR3 AN in vdd1 vdd1 GNRFETPMOS nRib=6 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR2 AN in gnd gnd GNRFETNMOS nRib=6 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

**STI
XGNR4 out in vdd1 vdd1 GNRFETPMOS nRib=12 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR5 out in gnd gnd GNRFETNMOS nRib=12 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0

XGNR6 out AP P1 P1 GNRFETNMOS nRib=15 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0

XGNR7 Vdd2 AN P1 P1 GNRFETPMOS nRib=15 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 


C1 out gnd  0.95fF
C2 AP gnd  0.95fF
C3 AN gnd  0.95fF
Voltagesource_1 vdd1 gnd DC 0.9
Voltagesource_2 Vdd2 gnd DC 0.45
.ends
.subckt successor in OUT
XGNR1 AN in Gnd Gnd GNRFETNMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR2 AN in Vdd Vdd GNRFETPMOS  nRib=6  n=6  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR0 AP in gnd gnd GNRFETNMOS nRib=6 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR4 AP in Vdd Vdd GNRFETPMOS nRib=12 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR5 OUT AN V12 V12 GNRFETNMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR6 OUT AN AP AP GNRFETPMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR7 OUT in AP AP GNRFETNMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

C1 OUT gnd 0.95fF
C2 AN gnd 0.95fF
C3 AP gnd 0.95fF
VVoltageSource_1 Vdd Gnd  DC 0.9
VVoltageSource_2 V12 Gnd  DC 0.45
.ends

.subckt predecessor in OUT
XGNR1 AN in gnd gnd GNRFETNMOS  nRib=12  n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR2 AN in Vdd Vdd GNRFETPMOS  nRib=6  n=6  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR0 AP in gnd gnd GNRFETNMOS nRib=6 n=6 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR4 AP in Vdd Vdd GNRFETPMOS nRib=12 n=12 L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR5 OUT in AN AN GNRFETPMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR6 OUT AP AN AN GNRFETNMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

XGNR7 OUT AP V12 V12 GNRFETPMOS  nRib=12  n=12  L=32n Tox=0.95n sp=2n dop=0.001 p=0 

C1 OUT gnd 0.95fF
C2 AN gnd 0.95fF
C3 AP gnd 0.95fF
VVoltageSource_1 Vdd Gnd  DC 0.9
VVoltageSource_2 V12 Gnd  DC 0.45
.ends

XGNR1 D out1 tx1
XGNR2 out1 out2 successor
XGNR3 out2 out3 predecessor
XGNR4 out1 out3 tx2
XGNR8 out3 out4 tx2
XGNR5 out4 out5 sti
XGNR6 out5 out6 sti
XGNR7 out4 out6 tx1

C3 out1 gnd 0.95fF
C2 out2 gnd 0.95fF
C5 out3 gnd 0.95fF
C1 out4 gnd 0.95fF
C4 out5 gnd 0.95fF
C6 out6 gnd 0.95fF

VVoltagesource_3 D gnd  PWL(0n 0 2n 0 2.01n 0.45 15n 0.45 15.01n 0 24n 0 24.01n 0.45 32n 0.45 32.01n 0.9 42n 0.9 42.01n 0.45 50n 0.45 50.01n 0 62n 0 62.01n 0.9 72n 0.9 72.01n 0 78n 0 78.01n 0.9 86n 0.9 86.01n 0 95n 0 95.01n 0.45 100n 0.45 100.01n 0 125n 0)

***********************************************************************
.tran 1n 125n

.MEASURE avg_pow AVG power FROM=1n TO=125n
 

.MEASURE TRAN t1 TRIG V(D) VAL = 0.225 TD = 0p RISE = 1
+ TARG V(out6) VAL = 0.675 FALL = 1

*.MEASURE TRAN t2 TRIG V(D) VAL = 0.675 TD = 0p rise = 1
*+ TARG V(out5) VAL = 0.45 fall = 1

*.MEASURE TRAN t3 TRIG V(D) VAL = 0.675 TD = 0p fall = 1
*+ TARG V(out5) VAL = 0.45 rise = 1

.MEASURE TRAN t4 TRIG V(D) VAL = 0.225 TD = 0p fall = 1
+ TARG V(out6) VAL = 0.675 rise = 1

.MEASURE TRAN tp PARAM='(t1+t4)/2.0'

*.OPTION PROBE POST MEASOUT
.option post=2
.end



***********************************************************************
* Measurements
***********************************************************************
* test n type GNRFET, Ids vs. Vgs
*.DC      Vgg   START=0     STOP='Supply'   STEP='0.01*Supply' 
*+ SWEEP  Vdd   START=0     STOP='Supply'   STEP='0.1*Supply'

* test p type GNRFET, Ids vs. Vgs
*.DC      Vgg   START=0     STOP='-Supply'   STEP='-0.01*Supply' 
*+ SWEEP  Vdd   START=0     STOP='-Supply'   STEP='-0.1*Supply'

***********************************************************************


***********************************************************************
*********************************************************************** 


