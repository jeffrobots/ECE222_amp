** Power Management Circuit for Headphone Amplifier **
** Jeff Baatz and Sean Wang 
** APR 2015
.include sedra_lib.lib

** Outputs a constant +9V at VPP and -9V at VEE
** For use in headphone Amplifier

*			 Positive  Negative
*				  |		|		 
*				  |		|		  
.subckt BATTERY VPP 	VEE
**Batteries and Ground
Vbat1 VPP 1 DC=9
Vbat1 1 VEE DC=9
Vgnd 3 0 DC=0
** Components
D1 VPP 2 D1N4148
R1 2 VEE 100k
R2 VPP 3 100k
R3 3 VEE 100k
C1 VPP 3 .1u
C2 3 VEE .1u
.ends BATTERY



