*initial Design for Headphone Amplifier
**By Jeff Baatz and Sean Wang
**For ECE222 - APR2015
.include sedra_lib.lib
.include OPA2134.lib
.include njm4556a_3_hspice.lib
.include battery.lib
.include OPA551_hspice.lib
*.PARAM capac = 1n
** Sources and Signal (one channel)
Xbat 90 91 battery
Vsig 1 0 SIN(0 .424 1k 0 0 0)

****Gain Stage****
* Filter (one channel, may need to AC couple)
RF1 1 2 270
CF1 2 0 200p
Rin 2 0 10k
*Op Amp goes here (OPA134, OPTA2134, or LME49600 can be swapped)
X0 2 3 90 91 4 OPA2134 
* Feedback network for op amp
* Results in 3X gain and 250kHz corner
Rfb1 4 3 5k
Cfb1 4 3 200p
Rfbg1 3 0 1k


***Volume stage****
* * Need to implement a ~10k pot for volume
* * For now this can just be two resistors @ 5k
** Pot output is at node 5
Rpot1 4 5 1 
Rpot2 5 0 10k

* * ****Output Stage****
* * * AC couple
Cac1 6 5 200p
* * * Current Driver goes here (Use NJM4556)
* * * Output of this stage will be the overall output
* *X1 out1 6 out1 91 0 0 0 90 NJM4556A
X1 6 out1 90 91 out1 0 OPA551
Rbuf 6 0 40k
RcA output out1 2
Rload output 0 32

**** Analysis ****
*.AC dec 100 1 10Meg
*.NOISE v(output) Vsig 10 
.TRAN .01m 10m
*.FFT v(output) start=0m stop = 5m freq=1k window=HAMM fmin=1k 
*.DISTO Rload  dec 100 1 1meg
.OPTIONS POST
.PROBE IM(Rload)
.PROBE VM(output)

.END
