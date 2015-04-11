# ECE222_amp
# Headphone Amplifier Project
# By @jeffrobots 

The files in this project are associated with a headphone amplifier simulation and design for ECE222. 

The project will require the following steps:
- [x] Research and plan overall design and specify requirements
- [x] Construct a block diagram of headphone amplifier
- [x] Pick optimal parts and simulate design in HSPICE
- [ ] Build hardware version of headphone amplifier
- [ ] Verify functionality

Optional goals include: 
- [ ] Don't break any headphones in the process
- [ ] Finish without an all-nighter in ITS


Tasks:
- [x] Increase gain of gain stage to provide 35mA at output (will need to multiply gain by ~2.5)
- [x] Place a better op amp in gain stage
- [ ] Optimize capacitor in gain stage feedback to provide 18-20kHz bandwidth
      * Optimize for FULL POWER bandwidth on 18-20kHz (.99% of Gain is acceptable)
      * Slew rate must be 6k to achieve desired slew bandwidth 
- [x] Optimize power usage. Must draw a total of 100mA (50mA per channel) at max RMS Power
- [x] Verify output impedance, input impedance, and power @ 32 ohms
- [ ] Noise Testing (.NOISE)
- [x] THD Testing (.FFT)
- [x] Power Management Circuit for battery
- [ ] Implement AC Power Options
      * Should feed into already implemented battery circuit. 




Full Circuit (one channel only)

[![CircuitLab Schematic k54het](https://www.circuitlab.com/circuit/k54het/screenshot/540x405/)](https://www.circuitlab.com/circuit/k54het/headphoneamp/)
