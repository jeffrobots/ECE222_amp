*initial Design for Headphone Amplifier
**By Jeff Baatz and Sean Wang
**For ECE222 - APR2015
.include sedra_lib.lib
.include OPA2134.lib
.include njm4556a_3_hspice.lib
.include battery.lib
.PARAM capac = 1n
** Sources and Signal (one channel)
Xbat 90 91 battery
Vsig 1 0 AC=.3 

****Gain Stage****
* Filter (one channel, may need to AC couple)
RF1 1 2 270
CF1 2 0 200p
Rin 2 0 10k
*Op Amp goes here (OPA134, OPTA2134, or LME49600 can be swapped)
X0 2 3 90 91 4 OPA2134 
* Feedback network for op amp
* Results in 3X gain and 250kHz corner
Rfb1 4 3 6.5k
Cfb1 4 3 capac 
Rfbg1 3 0 1k


***Volume stage****
* * Need to implement a ~10k pot for volume
* * For now this can just be two resistors @ 5k
** Pot output is at node 5
Rpot1 4 5 5k
Rpot2 5 0 5k

* ****Output Stage****
* * AC couple
Cac1 6 5 425n 
* * Current Driver goes here (Use NJM4556)
* * Output of this stage will be the overall output
X1 out1 6 out1 91 6 out2 out2 90 NJM4556A
Rbuf 6 0 40k
RcA output out1 2
RcB output out2 2
Rload output 0 32

**** Analysis ****
.AC dec 100 1 10Meg SWEEP capac 1n 2n .01n
.OPTIONS POST
.probe VM(output)
.probe IM(Rload)
.probe VM(5)
.probe VM(out1)
.probe VM(6)
.probe IM(RcA)
.END
