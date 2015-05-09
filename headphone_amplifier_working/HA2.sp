*Initial Design for Headphone Amplifier
**By Jeff Baatz and Sean Wang
**For ECE222 - APR2015


.include sedra_lib.lib
.include OPA2134.lib
.include njm4556a_3_hspice.lib
.include battery.lib
.include OPA551.lib
.include TLE2071_v2.lib


*.PARAM capac = 1n
** Sources and Signal (one channel)
** Battery currently not operational
*Xbat 90 91 0 battery

.PARAM freq = 20
Vsig 1 0 SIN(0 .424 freq 0 0 0) ac=.424
VDD 90 0 dc=9
VEE 0 91 dc=9

** AC Coupling capacitor **

Ccouple 1 2 100n


****Gain Stage****
** 220pF capacitors are used in actual circuit
<<<<<<< HEAD
<<<<<<< HEAD
.PARAM cap1 = 560n
=======
.PARAM cap1 = 630n
>>>>>>> parent of bc21dbc... updated capacitor value
C1 3 2 cap1
*Rin 3 2 270
R6 3 0 14.8k
=======
.PARAM cap1 = 220p
C1 3 0 cap1
Rin 3 2 270
R6 3 0 50k
>>>>>>> parent of 8e832c4... changed bandwidth of design
*(OPA134, OPTA2134)
X0 3 5 90 91 4 OPA2134 
*X0 2 3 90 91 4 TLE2071
* Feedback network for op amp
* Results in 6X gain and 250kHz corner
.PARAM CAPfb1 = 100p
Rfb1 5 4 5k
Cfb1 5 4 CAPfb1
Rfbg1 5 0 1k


***Volume stage****
* * Need to implement a ~10k pot for volume
* * For now this can just be two resistors @ 5k
** Pot output is at node 5
Rpot1 4 6 1
Rpot2 6 0 9999

*** Input to Output op-amp, Low-pass filter ***

.PARAM CAP5 = 100p
C5 7 0 CAP5
R11 6 7 82k


* * ****Output Stage****
* *X1 out1 6 out1 91 0 0 0 90 NJM4556A
*
* PINOUT ORDER +IN -IN +V -V OUT FLG for OPA551

X1 7 out1 90 91 out1 0 OPA551
Rload out1 0 32


**** Analysis ****
.OPTIONS POST

*.AC dec 100 1 1Meg
*.PROBE IM(Rload)

<<<<<<< HEAD
*.TRAN .01m 30m SWEEP freq dec 10 1 50k
*.PROBE I(Rload)
=======
*.NOISE v(output) Vsig 10 
.TRAN .01m 30m SWEEP freq dec 10 1 30k
.PROBE I(Rload)
>>>>>>> parent of 8e832c4... changed bandwidth of design
*.FFT v(out1) start=0m stop = 5m freq=1k window=HAMM fmin=1k 
*.AC dec 100 1 50k
*.NOISE V(out1) Vsig 1
*.PROBE total_current=PAR('abs(I(VDD))')
*.PROBE load_power=PAR('I(Rload)*V(out1)')
*.probe noise onoise onoise(m) onoise(db)
.END
