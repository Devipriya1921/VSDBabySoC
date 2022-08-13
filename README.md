# VSDBabySoC

VSDBabySoC is a small SoC including PLL, DAC, and a RISCV-based processor named RVMYTH.

# Table of Contents
- [Introduction to VSDBabySoC](#introduction-to-vsdbabysoc)
  - [SoC](#soc)
  - [RVMYTH](#rvmyth)
  - [PLL](#pll)
  - [DAC](#dac)
- [VSDBabySoC Modeling](#vsdbabysoc-modeling)
- [Steps to follow for the OpenLane flow](#steps-to-follow-for-the-openlane-flow)
  - [OpenLANE installation](#openlane-installation)
  - [Pre-Synthesis Simulation](pre-synthesis-simulation)
  - [Post-Synthesis Simulation](#post-synthesis-simulation)
  - [Static timing analysis using OpenSTA](#static-timing-analysis-using-opensta)
  - [VSDBabySoC and TestBench GTKWave](#vsdbabysoc-and-testbench-gtkwave)
- [Synthesis of VSDBabySoC using Design Compiler](#synthesis-of-vsdbabysoc-using-design-compiler)
  - [Core Block Diagram and Schematic](#core-block-diagram-and-schematic)
  - [Pre-Synthesis Simulation](#pre-synthesis-simulation)
  - [Post-Synthesis Simulation](#post-synthesis-simulation)
- [Acknowledgements](#acknowledgements)
- [Author](#author)

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


# Steps to follow for the OpenLane flow

## OpenLANE installation

The OpenLANE and sky130 installation can be done by following the steps in this repository `https://github.com/nickson-jose/openlane_build_script`.

* More information on OpenLANE can be found in the following repositories:

  * `https://github.com/The-OpenROAD-Project/OpenLane`
  * `https://github.com/efabless/openlane`

To summerize the installation processes:

  ```
  $ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
  $ cd OpenLane/
  $ make openlane
  $ make pdk
  $ make test
  ```
  
For more info please refer to the GitHub repositories.


#### Install few important packages:

  ```
  $ sudo apt install make python python3 python3-pip git iverilog gtkwave docker.io
  $ sudo chmod 666 /var/run/docker.sock
  $ cd ~
  $ pip3 install pyyaml click sandpiper-saas
  ```

## Pre-Synthesis Simulation

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


## Post-Synthesis Simulation

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


## VSDBabySoC and TestBench GTKWave

Command to run:

![VSDBabySoC - testbench - commands-1](https://user-images.githubusercontent.com/83152452/180606008-08497fcc-561d-49ce-96f8-dc265cff14fa.png)

GTKWave:

![VSDBabySoC - testbench - gtkwave - 1](https://user-images.githubusercontent.com/83152452/180606010-4f3ee38c-166d-44d1-9088-3aa40a289b6a.png)

![VSDBabySoC - testbench - gtkwave - 2](https://user-images.githubusercontent.com/83152452/180606014-68419d27-3c80-42f2-af77-0fb988703cde.png)

![VSDBabySoC - testbench - gtkwave - 3](https://user-images.githubusercontent.com/83152452/180606023-134d2e6c-81fa-473b-9dc4-dbd32543f659.png)



# Synthesis of VSDBabySoC using Design Compiler 

Synopsys Design compiler, Design Vision is used to perform the synthesis and IC_Shell is used to convert the .lib files to .db for DAC and PLL. The technology node used is SAED_PDK 28_32nm.


## Core Block Diagram and Schematic 

![core - block diag](https://user-images.githubusercontent.com/83152452/184493625-23f0d686-97b1-431e-9661-bb718e5e3269.png)

![core - schematic](https://user-images.githubusercontent.com/83152452/184493628-ade77845-63ea-4b95-aa10-8fd4c0f92c0a.png)


## Pre-Synthesis Simulation

#### Perform the steps as shown below:

  ```
  $ cd 
  $ git clone https://github.com/Devipriya1921/VSDBabySoC.git
  $ cd VSDBabySoC/src/module
  $ source vsdbabysoc.tcl
  ```

#### The tcl script file includes:

```
set target_library [list /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db /home/devipriya/VSDBabySoC/src/lib/avsdpll.db  /home/devipriya/VSDBabySoC/src/lib/avsddac.db]
set link_library [list  /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db  /home/devipriya/VSDBabySoC/src/lib/avsdpll.db  /home/devipriya/VSDBabySoC/src/lib/avsddac.db] 
set symbol_library ""

read_file -format verilog {/home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v}
read_verilog /home/devipriya/VSDBabySoC/src/module/rvmyth.v
read_verilog /home/devipriya/VSDBabySoC/src/module/clk_gate.v

read_lib -lib /home/devipriya/VSDBabySoC/src/module/avsdpll.lib
read_lib -lib /home/devipriya/VSDBabySoC/src/module/avsddac.lib

analyze -library WORK -format verilog {/home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v}
elaborate vsdbabysoc -architecture verilog -library WORK
analyze {}

set_units -time ns
create_clock [get_pins {pll/CLK}] -name clk -period 10
set_max_area 8000;
set_max_fanout 5 vsdbabysoc;
set_max_transition 10 vsdbabysoc
#set_min_delay -max 10 -clock[get_clk myclk] [get_ports OUT]
set_max_delay 10 -from dac/OUT -to [get_ports OUT]

#set_input_delay[expr 0.34][all_inputs]

set_clock_latency -source 2 [get_clocks MYCLK];
set_clock_latency 1 [get_clocks MYCLK];
set_clock_uncertainty -setup 0.5 [get_clocks MYCLK];
set_clock_uncertainty -hold 0.5 [get_clocks MYCLK];

set_input_delay -max 4 -clock [get_clocks MYCLK] [get_ports VCO_IN];
set_input_delay -max 4 -clock [get_clocks MYCLK] [get_ports ENb_CP];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports VCO_IN];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports ENb_CP];

set_input_transition -max 0.4 [get_ports ENb_CP];
set_input_transition -max 0.4 [get_ports VCO_IN];
set_input_transition -min 0.1 [get_ports ENb_CP];
set_input_transition -min 0.1 [get_ports VCO_IN];

set_load -max 0.5 [get_ports OUT];
set_load -min 0.5 [get_ports OUT];

check_design

compile_ultra

file mkdir report
write -hierarchy -format verilog -output /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc_gtlvl.v
write_sdc -nosplit -version 2.0 /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.sdc
report_area -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.area
report_timing > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.timing
report_power -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.power

gui_start
```


#### The Block diagram and Schematic generated after performing ``` $ source vsdbabysoc.tcl ``` is shown below:

![vsdbabysoc v block diag](https://user-images.githubusercontent.com/83152452/184493257-2ecc9842-fdd2-48a9-9a57-85f9b7856701.png)

![vsdbabysoc v schematic](https://user-images.githubusercontent.com/83152452/184493252-a26bc819-ae16-4350-a3f2-de9bb7251f12.png)


#### To generate the pre-synthesis waveforms using iverilog and GTKWave:

```
$ cd VSDBabySoC/src/module
$ iverilog vsdbabysoc.v testbench.v clk_gate.v
$ ./a.out
$ gtkwave dump.vcd
```

#### The waveforms generated are as shown below:

![gtkwave - vsdbabysoc v](https://user-images.githubusercontent.com/83152452/184493270-ca24d06d-9a85-4aba-a0c1-3de4db1a8c75.png)
 

## Post-Synthesis Simulation

#### To generate the post-synthesis waveforms using iverilog and GTKWave:

```
$ cd VSDBabySoC/src/module
$ iverilog report/vsdbabysoc_gtlvl.v testbench.v clk_gate.v
$ ./a.out
$ gtkwave dump.vcd
```

#### Reports generated:

Timing report: ``` report_timing ```

```
****************************************
Report : timing
        -path full
        -delay max
        -max_paths 1
Design : vsdbabysoc
Version: S-2021.06-SP5-1
Date   : Fri Aug 12 22:53:40 2022
****************************************

Operating Conditions: tt0p85v25c   Library: saed32hvt_tt0p85v25c
Wire Load Model Mode: enclosed

  Startpoint: core/CPU_is_addi_a3_reg
              (rising edge-triggered flip-flop clocked by clk)
  Endpoint: core/CPU_Xreg_value_a4_reg[2][31]
            (rising edge-triggered flip-flop clocked by clk)
  Path Group: clk
  Path Type: max

  Des/Clust/Port     Wire Load Model       Library
  ------------------------------------------------
  vsdbabysoc         16000                 saed32hvt_tt0p85v25c
  rvmyth             16000                 saed32hvt_tt0p85v25c

  Point                                                   Incr       Path
  --------------------------------------------------------------------------
  clock clk (rise edge)                                   0.00       0.00
  clock network delay (ideal)                             0.00       0.00
  core/CPU_is_addi_a3_reg/CLK (DFFX1_HVT)                 0.00       0.00 r
  core/CPU_is_addi_a3_reg/Q (DFFX1_HVT)                   0.19       0.19 r
  core/U265/Y (OR2X1_HVT)                                 0.09       0.28 r
  core/U18/Y (NOR2X0_HVT)                                 0.13       0.41 f
  core/U13/Y (NOR2X0_HVT)                                 0.23       0.64 r
  core/U489/Y (OAI22X1_HVT)                               0.22       0.86 f
  core/U11/Y (XOR2X1_HVT)                                 0.19       1.05 r
  core/DP_OP_210J2_122_9377/U33/CO (FADDX1_HVT)           0.16       1.21 r
  core/DP_OP_210J2_122_9377/U32/CO (FADDX1_HVT)           0.17       1.38 r
  core/DP_OP_210J2_122_9377/U31/CO (FADDX1_HVT)           0.17       1.54 r
  core/DP_OP_210J2_122_9377/U30/CO (FADDX1_HVT)           0.17       1.71 r
  core/DP_OP_210J2_122_9377/U29/CO (FADDX1_HVT)           0.17       1.87 r
  core/DP_OP_210J2_122_9377/U28/CO (FADDX1_HVT)           0.17       2.04 r
  core/DP_OP_210J2_122_9377/U27/CO (FADDX1_HVT)           0.17       2.21 r
  core/DP_OP_210J2_122_9377/U26/CO (FADDX1_HVT)           0.17       2.37 r
  core/DP_OP_210J2_122_9377/U25/CO (FADDX1_HVT)           0.17       2.54 r
  core/DP_OP_210J2_122_9377/U24/CO (FADDX1_HVT)           0.17       2.70 r
  core/DP_OP_210J2_122_9377/U23/CO (FADDX1_HVT)           0.17       2.87 r
  core/DP_OP_210J2_122_9377/U22/CO (FADDX1_HVT)           0.17       3.04 r
  core/DP_OP_210J2_122_9377/U21/CO (FADDX1_HVT)           0.17       3.20 r
  core/DP_OP_210J2_122_9377/U20/CO (FADDX1_HVT)           0.17       3.37 r
  core/DP_OP_210J2_122_9377/U19/CO (FADDX1_HVT)           0.17       3.53 r
  core/DP_OP_210J2_122_9377/U18/CO (FADDX1_HVT)           0.17       3.70 r
  core/DP_OP_210J2_122_9377/U17/CO (FADDX1_HVT)           0.17       3.87 r
  core/DP_OP_210J2_122_9377/U16/CO (FADDX1_HVT)           0.17       4.03 r
  core/DP_OP_210J2_122_9377/U15/CO (FADDX1_HVT)           0.17       4.20 r
  core/DP_OP_210J2_122_9377/U14/CO (FADDX1_HVT)           0.17       4.36 r
  core/DP_OP_210J2_122_9377/U13/CO (FADDX1_HVT)           0.17       4.53 r
  core/DP_OP_210J2_122_9377/U12/CO (FADDX1_HVT)           0.17       4.70 r
  core/DP_OP_210J2_122_9377/U11/CO (FADDX1_HVT)           0.17       4.86 r
  core/DP_OP_210J2_122_9377/U10/CO (FADDX1_HVT)           0.17       5.03 r
  core/DP_OP_210J2_122_9377/U9/CO (FADDX1_HVT)            0.17       5.19 r
  core/DP_OP_210J2_122_9377/U8/CO (FADDX1_HVT)            0.17       5.36 r
  core/DP_OP_210J2_122_9377/U7/CO (FADDX1_HVT)            0.17       5.53 r
  core/DP_OP_210J2_122_9377/U6/CO (FADDX1_HVT)            0.17       5.69 r
  core/DP_OP_210J2_122_9377/U5/CO (FADDX1_HVT)            0.17       5.86 r
  core/DP_OP_210J2_122_9377/U4/CO (FADDX1_HVT)            0.17       6.02 r
  core/DP_OP_210J2_122_9377/U3/CO (FADDX1_HVT)            0.16       6.18 r
  core/U25/Y (XOR2X1_HVT)                                 0.19       6.37 f
  core/U29/Y (INVX1_HVT)                                  0.06       6.43 r
  core/U26/Y (NOR2X0_HVT)                                 0.16       6.59 f
  core/U1216/Y (AO22X1_HVT)                               0.13       6.71 f
  core/CPU_Xreg_value_a4_reg[2][31]/D (DFFX1_HVT)         0.01       6.72 f
  data arrival time                                                  6.72

  clock clk (rise edge)                                  10.00      10.00
  clock network delay (ideal)                             0.00      10.00
  core/CPU_Xreg_value_a4_reg[2][31]/CLK (DFFX1_HVT)       0.00      10.00 r
  library setup time                                     -0.08       9.92
  data required time                                                 9.92
  --------------------------------------------------------------------------
  data required time                                                 9.92
  data arrival time                                                 -6.72
  --------------------------------------------------------------------------
  slack (MET)                                                        3.19


  Startpoint: dac/OUT (internal path startpoint)
  Endpoint: OUT (output port)
  Path Group: default
  Path Type: max

  Des/Clust/Port     Wire Load Model       Library
  ------------------------------------------------
  vsdbabysoc         16000                 saed32hvt_tt0p85v25c

  Point                                    Incr       Path
  -----------------------------------------------------------
  input external delay                     0.00       0.00 r
  dac/OUT (avsddac)                        0.00       0.00 r
  OUT (out)                                0.01       0.01 r
  data arrival time                                   0.01

  max_delay                               10.00      10.00
  output external delay                    0.00      10.00
  data required time                                 10.00
  -----------------------------------------------------------
  data required time                                 10.00
  data arrival time                                  -0.01
  -----------------------------------------------------------
  slack (MET)                                         9.99


1
```

Area report: ``` report_area ```

```
****************************************
Report : area
Design : vsdbabysoc
Version: S-2021.06-SP5-1
Date   : Fri Aug 12 22:53:40 2022
****************************************

Information: Updating design information... (UID-85)
Library(s) Used:

    avsddac (File: /home/devipriya/VSDBabySoC/src/lib/avsddac.db)
    avsdpll (File: /home/devipriya/VSDBabySoC/src/lib/avsdpll.db)
    saed32hvt_tt0p85v25c (File: /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db)

Number of ports:                           19
Number of nets:                          2308
Number of cells:                         2195
Number of combinational cells:           1515
Number of sequential cells:               676
Number of macros/black boxes:               2
Number of buf/inv:                         77
Number of references:                       3

Combinational area:               3889.673928
Buf/Inv area:                       97.845440
Noncombinational area:            4466.835091
Macro/Black Box area:                0.000000
Net Interconnect area:            2879.664152

Total cell area:                  8356.509019
Total area:                      11236.173171

Hierarchical area distribution
------------------------------

                                  Global cell area          Local cell area
                                  ------------------  ---------------------------- 
Hierarchical cell                 Absolute   Percent  Combi-     Noncombi-  Black-
                                  Total      Total    national   national   boxes   Design
--------------------------------  ---------  -------  ---------  ---------  ------  ---------
vsdbabysoc                        8356.5090    100.0     0.0000     0.0000  0.0000  vsdbabysoc
core                              8356.5090    100.0  3889.6739  4466.8351  0.0000  rvmyth
--------------------------------  ---------  -------  ---------  ---------  ------  ---------
Total                                                 3889.6739  4466.8351  0.0000

1
```

Power Report: ``` report_power ```

```
 
****************************************
Report : power
        -hier
        -analysis_effort low
Design : vsdbabysoc
Version: S-2021.06-SP5-1
Date   : Fri Aug 12 22:53:40 2022
****************************************


Library(s) Used:

    avsddac (File: /home/devipriya/VSDBabySoC/src/lib/avsddac.db)
    avsdpll (File: /home/devipriya/VSDBabySoC/src/lib/avsdpll.db)
    saed32hvt_tt0p85v25c (File: /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db)


Operating Conditions: tt0p85v25c   Library: saed32hvt_tt0p85v25c
Wire Load Model Mode: enclosed

Design        Wire Load Model            Library
------------------------------------------------
vsdbabysoc             16000             saed32hvt_tt0p85v25c
rvmyth                 16000             saed32hvt_tt0p85v25c


Global Operating Voltage = 0.85 
Power-specific unit information :
    Voltage Units = 1V
    Capacitance Units = 1.000000ff
    Time Units = 1ns
    Dynamic Power Units = 1uW    (derived from V,C,T units)
    Leakage Power Units = 1pW


--------------------------------------------------------------------------------
                                       Switch   Int      Leak     Total
Hierarchy                              Power    Power    Power    Power    %
--------------------------------------------------------------------------------
vsdbabysoc                               38.718    0.000 1.98e+08  236.631 100.0
  dac (avsddac)                        1.84e-03    0.000    0.000 1.84e-03   0.0
  pll (avsdpll)                          32.438    0.000    0.000   32.438  13.7
  core (rvmyth)                           6.278    0.000 1.98e+08  204.189  86.3
1
```

#### After synthesis the Gate-Level netlist is saved in ``` vsdbabysoc/src/module/report ``` location.


#### The waveforms generated are as shown below:

commands:

![gtkwave - vsdbabysoc_gtln v - commands](https://user-images.githubusercontent.com/83152452/184493414-ee4d8737-b7a8-47d1-8fd3-cdfceb27922e.png)


Waveform:

![gtkwave - vsdbabysoc_gtln v](https://user-images.githubusercontent.com/83152452/184493417-75675fac-05da-41a3-b719-7d41a0ac8d8e.png)


The Simulated waveforms of Pre-synthesis and Post-synthesis matches.


# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [VSDBabySoC](https://github.com/manili/VSDBabySoC.git).
- Skandha, T.A.


# Author
- [A Devipriya](https://github.com/Devipriya1921), B.E (Electronics and Communication Engineering), Bangalore - adevipriya1900@gmail.com





