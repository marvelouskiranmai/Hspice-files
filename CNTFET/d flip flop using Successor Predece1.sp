*d flip flop using Successor Predecessor circuits*
*************************************************
***************************************************
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
.lib 'CNFET.lib' CNFET
***************************************************
*Some CNFET parameters:


.param Ccsd=0      CoupleRatio=0
.param m_cnt=1     Efo=0.6     
.param Wg=0        Cb=40e-12
.param Lg=32e-9    Lgef=100e-9
.param Vfn=0       Vfp=0
.param m=19       n=0 
.param ma=10     na=0       
.param Hox=4e-9    Kox=16 

***********************************************************************
* Define out supply
***********************************************************************


*Vdd     1     0     0.9



***********************************************************************
* Main Circuits
***********************************************************************
*********************
.option post=2
.subckt Successor N_1 OUT
* PTI
X1 AP N_1 Gnd Gnd NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=10  n2=0  tubes=3

X2 AP N_1 Vdd Vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=19  n2=0  tubes=3
*NTI
X3 AN N_1 Gnd Gnd NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=3

X4 AN N_1 Vdd Vdd PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=10  n2=0  tubes=3
******* Successor
XT1 OUT AN AP AP  PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=19  n2=0  tubes=3

XT2 OUT AN V12 V12 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=3

XT3 OUT N_1 AP AP NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=3

VVoltageSource_1 Vdd Gnd  DC 0.9 
VVoltageSource_2 V12 Gnd  DC 0.45  

.ends

.subckt Predecessor N_1 OUT
* PTI
X5 AP N_1 Gnd Gnd NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=10  n2=0  tubes=3

X6 AP N_1 Vdd Vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=19  n2=0  tubes=3

*NTI
X7 AN N_1 Gnd Gnd NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=3

X8 AN N_1 Vdd Vdd PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=10  n2=0  tubes=3

******* Predecessor
XT4 OUT N_1 AN AN  PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=19  n2=0  tubes=3

XT5 OUT AP V12 V12  PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=19  n2=0  tubes=3

XT6 OUT AP AN AN NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=3

VVoltageSource_1 Vdd Gnd  DC 0.9 
VVoltageSource_2 V12 Gnd  DC 0.45 
 
.ends
.subckt tx1 D N_1
XT1 N_1 CLK1 D D PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=13  n2=0  tubes=3

XT2 N_1 CLK2 D D NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=13  n2=0  tubes=3

VVoltageSource_5 clk1 Gnd PULSE(0 0.9 0n  0.01n 0.01n 6.125n 12.5n)
VVoltageSource_6 clk2 Gnd PULSE(0.9 0 0n 0.01n 0.01n 6.125n 12.5n)


.ends

.subckt tx2 D N_1
XT1 N_1 CLK2 D D PCNFET  Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=1  Pitch=20e-9  n1=13  n2=0  tubes=3

XT2 N_1 CLK1 D D NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=1  Sout=0  Pitch=20e-9  n1=13  n2=0  tubes=3

VVoltageSource_5 clk1 Gnd PULSE(0 0.9 0n  0.01n 0.01n 6.125n 12.5n)
VVoltageSource_6 clk2 Gnd PULSE(0.9 0 0n 0.01n 0.01n 6.125n 12.5n)

.ends



X1 1 2  Successor
X2 2 3 Predecessor
X3 n_1 1 tx1
X4 1 3 tx2
X5 3 4 tx2
X6 4 QQ Successor
X7 QQ Q Predecessor
X8 4  Q  tx1	

C1 Q Gnd 0.55fF

*VVoltageSource_1 Vdd Gnd  DC 0.9 
*VVoltageSource_2 V12 Gnd  DC 0.45                                                                                                                                                                                                                                              

**Vg n_1 Gnd PWL(0p 0 500p 0.45 500.1p 0.45 1000p 0 1000.1p 0 1500p 0.45 1500.1p 0.45 2000p 0  2000.1p 0.9 2500p 0.9 2500.1p 0 3000p 0)

***VVoltageSource_4 N_1  Gnd  PWL(0p 0 500p 0 500.1p 0.45 1000p 0.45 1000.1p 0.9 1500p 0.9 1500.1p 0.45 2000p 0.45 2000.1p 0 2500p 0)

VVoltageSource_3 n_1   Gnd  PWL(0n 0 2n 0 2.1n 0.45 15n 0.45 15.1n 0 24n 0 24.1n 0.45 32n 0.45 32.1n 0.9 42n 0.9 42.1n 0.45 50n 0.45 50.1n 0 62n 0 62.1n 0.9  72n 0.9 72.1n 0  78n 0 78.1n 0.9 86n 0.9 86.1n 0 95n 0 95.1n 0.45 100n 0.45 100.1n 0 125n 0)
***********************************************************************
.tran 1n 125n

.MEASURE avg_pow AVG power FROM=1n TO=125n
*.MEASURE TRAN t1 TRIG V(N_1) VAL = 0.225 TD = 0p RISE = 1
*+ TARG V(Q) VAL = 0.675 FALL = 1

.MEASURE TRAN t2 TRIG V(N_1) VAL = 0.675 TD = 0p rise = 1
+ TARG V(Q) VAL = 0.45 fall = 1

.MEASURE TRAN t3 TRIG V(N_1) VAL = 0.675 TD = 0p fall = 1
+ TARG V(Q) VAL = 0.45 rise = 1

*.MEASURE TRAN t4 TRIG V(N_1) VAL = 0.225 TD = 0p fall = 1
*+ TARG V(Q) VAL = 0.675 rise = 1

.MEASURE TRAN tp PARAM='(t2+t3)/2.0'


*.OPTION PROBE POST MEASOUT
.option post=2
.end

***********************************************************************
*********************************************************************** 
