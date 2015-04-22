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

.PARAM freq = 10
Vsig 1 0 SIN(0 .424 freq 0 0 0) ac=.424
VDD 90 0 dc=9
VEE 0 91 dc=9


****Gain Stage****
** 220pF capacitors are used in actual circuit
.PARAM cap1 = 220p
C1 2 0 cap1
Rin 2 1 270
R6 2 0 50k
*(OPA134, OPTA2134)
X0 2 3 90 91 4 OPA2134 
*X0 2 3 90 91 4 TLE2071
* Feedback network for op amp
* Results in 3X gain and 250kHz corner
.PARAM CAPfb1 = 220p
Rfb1 3 4 5k
Cfb1 3 4 CAPfb1
Rfbg1 3 0 1k


***Volume stage****
* * Need to implement a ~10k pot for volume
* * For now this can just be two resistors @ 5k
** Pot output is at node 5
Rpot1 4 5 1
Rpot2 5 0 9999

*** Input to Output op-amp

.PARAM CAP5 = 10u
C5 5 6 CAP5
R11 6 0 40k


* * ****Output Stage****
* *X1 out1 6 out1 91 0 0 0 90 NJM4556A
*
* PINOUT ORDER +IN -IN +V -V OUT FLG for OPA551

X1 6 out1 90 91 out1 0 OPA551
Rload out1 0 32


**** Analysis ****
.OPTIONS POST

*.AC dec 100 1 1Meg
*.PROBE IM(Rload)

*.NOISE v(output) Vsig 10 
*.TRAN .01m 15m SWEEP freq dec 10 1 100k
*.FFT v(out1) start=0m stop = 5m freq=1k window=HAMM fmin=1k 
.AC dec 100 1 50k
.NOISE V(out1) Vsig 1
*.PROBE total_current=PAR('abs(I(VDD))')
*.PROBE load_power=PAR('I(Rload)*V(out1)')
.END
