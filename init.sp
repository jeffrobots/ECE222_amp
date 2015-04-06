**Initial Design for Headphone Amplifier
**By Jeff Baatz and Sean Wang
**For ECE222 - APR2015
.include sedra_lib.lib
.include OPA2134.lib
.include njm4556a_3_hspice.lib

** Sources and Signal (one channel)
Vp nP ng dc=24
Vn nN ng dc=0
Vsig nIn ng AC=.3

****Gain Stage****
* Filter (one channel, may need to AC couple)
RF1 nIn nF1 270
CF1 nF1 ng 200p
Rin nF1 ng 10k
*Op Amp goes here (OPA134, OPTA2134, or LME49600 can be swapped)
Xg1 nF1 nfb Vp Vn nGainO OPA2134
* Feedback network for op amp
* Results in 3X gain and 250kHz corner
* Rfb1 nGainO nfb 2k
* Cfb1 nGainO nfb 220p
* Rfbg1 nfb ng 1k

* ****Volume Stage****
* * Need to implement a ~10k pot for volume
* * For now this can just be two resistors @ 5k
* Rpot1 nGainO nVol 5k
* Rpot2 nVol ng 5k

* ****Output Stage****
* * AC couple
* Cac1 nac1 nVol 220p
* * Current Driver goes here (Use NJM4556)
* * Output of this stage will be the overall output
* Xo1 OUT1 nCAp OUT1 nN nCBp OUT2 OUT2 nP NJM4556A
* RcA OUTPUT OUT1 2
* RcB OUTPUT OUT2 2


**** Analysis ****
.AC dec 100 1 10Meg
.OPTIONS POST

.END

