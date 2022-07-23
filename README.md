# VSDBabySoC

VSDBabySoC is a small SoC including PLL, DAC, and a RISCV-based processor named RVMYTH.

# Intoduction to VSDBabySoC

VSDBabySoC is a small yet powerful RISCV-based SoC. The main purpose of designing such a small SoC is to test three open-source IP cores together for the first time and 
calibrate the analog part of it. VSDBabySoC contains one RVMYTH microprocessor, an 8x-PLL to generate a stable clock, and a 10-bit DAC to communicate with other analog 
devices.

![vsdbabysoc_block_diagram - 1](https://user-images.githubusercontent.com/83152452/180604666-65f17efc-f281-42bd-8f43-cccf0067891d.png)


# SoC

An SoC is a single-die chip that has some different IP cores on it. These IPs could vary from microprocessors (completely digital) to 5G broadband modems 
(completely analog).


# RVMYTH

RVMYTH core is a simple RISCV-based CPU, introduced in a workshop by RedwoodEDA and VSD. During a 5-day workshop students (including middle-schoolers) managed to create a processor from scratch. 
The workshop used the TLV for faster development. All of the present and future contributions to the IP will be done by students and under open-source licenses.

# PLL

A phase-locked loop or PLL is a control system that generates an output signal whose phase is related to the phase of an input signal. PLLs are widely used for synchronization purposes, including 
clock generation and distribution.

# DAC

A digital-to-analog converter or DAC is a system that converts a digital signal into an analog signal. DACs are widely used in modern communication systems enabling the 
generation of digitally-defined transmission signals. As a result, high-speed DACs are used for mobile communications and ultra-high-speed DACs are employed in optical 
communications systems.

# VSDBabySoC Modeling

Here we are going to model and simulate the VSDBabySoC using iverilog, then we will show the results using gtkwave tool. Some initial input signals will be fed into 
vsdbabysoc module that make the pll start generating the proper CLK for the circuit. The clock signal will make the rvmyth to execute instructions in its imem. 
As a result the register r17 will be filled with some values cycle by cycle. These values are used by dac core to provide the final output signal named OUT. 
So we have 3 main elements (IP cores) and a wrapper as an SoC and of-course there would be also a testbench module out there.


# Steps to follow for the flow:

1. Install few important packages:

  ```
  $ sudo apt install make python python3 python3-pip git iverilog gtkwave docker.io
  $ sudo chmod 666 /var/run/docker.sock
  $ cd ~
  $ pip3 install pyyaml click sandpiper-saas
  ```

# Pre-Synthesis Simulation

1. Clone the repository:

  ```
  $ cd ~
  $ git clone https://github.com/manili/VSDBabySoC.git
  ```

2. `pre_synth_sim.vcd`:

  ```
  $ cd VSDBabySoC
  $ make pre_synth_sim
  ```
  
  The result of the simulation (`pre_synth_sim.vcd`) will be stored in the `output/pre_synth_sim` directory.

3. Execute the waveforms:

  ```
  $ gtkwave output/pre_synth_sim/pre_synth_sim.vcd
  ```

4. Final Waveforms:

![commands-pre-synthesis-1](https://user-images.githubusercontent.com/83152452/180605499-f6b6b891-483c-4290-86f7-9693d4d1b685.png)

![gtkwave-pre-synthesis-1](https://user-images.githubusercontent.com/83152452/180605495-520b4be0-4116-44d7-885c-03b39aaee1c5.png)


# Post-Synthesis Simulation

1. To perform the synthesis process:

  ```
  $ cd ~/VSDBabySoC
  $ make synth
  ```

2. `post_synth_sim.vcd`:

  ```
  $ cd ~/VSDBabySoC
  $ make post_synth_sim
  ```

3. Execute the waveforms:

  ```
  $ gtkwave output/post_synth_sim/post_synth_sim.vcd
  ```

4. Final Waveforms:

![commands-post-synthesis-1](https://user-images.githubusercontent.com/83152452/180605818-6ed0a3af-d892-41e9-ae5d-e186120491a2.png)

![gtkwave-post-synthesis-1](https://user-images.githubusercontent.com/83152452/180605828-e1aed328-cfb3-47f2-b6a9-58fc15715c4f.png)


## Static timing analysis using OpenSTA

To analyze the process:

  ```
  $ cd ~/VSDBabySoC
  $ make sta
  ```

Output of the OpenSTA tool:

![VSDBabySoC-slack met - make sta](https://user-images.githubusercontent.com/83152452/180605965-18772f7e-d239-420e-9a6f-4f8737d05f5b.png)


# VSDBabySoC and TestBench GTKWave

Command to run:

![VSDBabySoC - testbench - commands-1](https://user-images.githubusercontent.com/83152452/180606008-08497fcc-561d-49ce-96f8-dc265cff14fa.png)

GTKWave:

![VSDBabySoC - testbench - gtkwave - 1](https://user-images.githubusercontent.com/83152452/180606010-4f3ee38c-166d-44d1-9088-3aa40a289b6a.png)

![VSDBabySoC - testbench - gtkwave - 2](https://user-images.githubusercontent.com/83152452/180606014-68419d27-3c80-42f2-af77-0fb988703cde.png)

![VSDBabySoC - testbench - gtkwave - 3](https://user-images.githubusercontent.com/83152452/180606023-134d2e6c-81fa-473b-9dc4-dbd32543f659.png)


# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.


## Author
- [A Devipriya](https://github.com/Devipriya1921), B.E (Electronics and Communication Engineering), Bangalore - adevipriya1900@gmail.com





