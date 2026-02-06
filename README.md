# Logic Synthesis of Hash Generator (FPGA Mapping)

> **Computer-Aided Design of Digital Systems (CAD) – University of Tehran – Department of Electrical & Computer Engineering**

![Language](https://img.shields.io/badge/Language-Verilog-orange) ![Auxiliary](https://img.shields.io/badge/Scripting-C++%20%7C%20Python-purple) ![Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 Overview

This repository contains the **Structural Implementation and Logic Synthesis** of a Hash Generator System. This project was developed as the *Third Assignment* of the *Computer-Aided Design of Digital Systems (CAD)* course at the University of Tehran.

Unlike the first project (which was pure RTL), this assignment requires implementing a simplified **8-bit Hash Generator** by **manually mapping** the logic onto a restricted set of **Programmable Logic Cells (C1, C2, S1, S2)**. This mimics the internal structure of an FPGA.

## 🎯 Project Objectives

- ✅ **Structural Design:** Implementing complex logic strictly by instantiating primitive modules (No behavioral operators like `+`, `&`, `|` allowed).
- ✅ **Logic Synthesis:** Manually mapping high-level algorithms to Lookup Table (LUT)-like structures.
- ✅ **Gate Counting Mechanism:** Integrating **C++ executables** within Verilog simulation to count the exact usage of logic cells.
- ✅ **Algorithm Adaptation:** Modifying the original algorithm to use an 8-bit data width and replacing the "Rotate" operation with a custom **Split Multiplier**.

## 🧠 System Architecture & Constraints

The system is built entirely using four provided base cells. To manage complexity, we first designed intermediate gates (`CA3_and`, `CA3_xor`, `CA3_reg`) using these cells, and then built the higher-level modules.

### 1️⃣ The Programmable Cells (The "Physics")

The entire design is composed of only these primitives:

* **C1 & C2:** Combinational logic cells (acting as LUTs/Muxes).
* **S1 & S2:** Sequential logic cells (Latches/Flip-Flops with logic).

### 2️⃣ Hierarchical Design Approach

To maintain modularity without behavioral operators, we adopted a bottom-up approach:

* **Level 0:** Base Cells (C1, C2, S1, S2).
* **Level 1:** Basic Logic Gates (AND, XOR, INV, REG) mapped to Base Cells.
* **Level 2:** Arithmetic Units (Adders, Multiplexers, Split Multiplier).
* **Level 3:** Subsystems (F_Logic_ALU, Datapath, Controller).
* **Level 4:** Top-Level Integration (Hash Generator & RND).

### 3️⃣ Split Multiplier (New Feature)

Instead of a barrel shifter, this architecture features a **Split Multiplier**:

* Takes an 8-bit input.
* Splits it into two 4-bit nibbles ($High$ and $Low$).
* Computes $High \times Low$.
* This arithmetic unit is implemented structurally using the base cells.

### 🖼️ Design Visualizations

Below are schematic representations of how logic gates were mapped to the structural cells:

|           Basic Gate Mapping           |        Complex Module Structure        |
| :------------------------------------: | :------------------------------------: |
|   **AND Gate Implementation**   |   **ALU Logic Implementation**   |
|    ![AND Gate](https://raw.githubusercontent.com/mragetsars/Logic-Synthesis-of-Hash-Generator/refs/heads/master/Design/CA3_and_2.png)    | ![ALU Logic](https://raw.githubusercontent.com/mragetsars/Logic-Synthesis-of-Hash-Generator/refs/heads/master/Design/HG_F_logic_ALU.png) |
| *Mapping basic logic to C1/C2 cells* | *Structural composition of the ALU* |

## 📂 Repository Structure

The project is organized as follows:

```text
Logic Synthesis of Hash Generator/
├── Description/           # Project specifications & References
│   ├── CAD-CA3.pdf        # Assignment description
│   └── out_hw.txt         # Reference output for verification
├── Source/                 # Structural Verilog Source files
│   ├── c1.cpp, c2.cpp...  # C++ codes for Gate Counting cost function
│   ├── modules.v          # Definition of Base Cells (C1, C2, S1, S2)
│   ├── CA3_*.v            # Wrapper modules (AND, XOR, REG, INV)
│   ├── HG_*.v             # Hash Generator Structural Modules
│   └── RND_*.v            # Random Number Generator Structural Modules
├── Designs/               # Schematic Diagrams & Waveforms
│   ├── Adder & Multiplier.pdf
│   ├── HG_datapath.PNG
│   └── ...
├── Project/               # ModelSim Simulation files
│   ├── numbers.txt        # Output file for Gate Count results
│   ├── *.exe              # Compiled C++ cost calculators
│   └── work/              # Compiled libraries
├── Report/                # Documentation & Testbenches
│   ├── TestBench Creator.py # Python script for generating test vectors
│   └── Report.pdf
└── README.md
```

## 🛠️ Tools & Verification Flow

* **Simulation:** Mentor Graphics ModelSim.
* **Cost Estimation:** C++ (GCC). The Verilog testbench invokes `system()` calls to run `.exe` files that increment a counter in `numbers.txt` every time a module is instantiated/activated.
* **Verification:**

1. The system reads `testcase.txt`.
2. The structural logic processes the data.
3. Outputs are compared against `out_hw.txt`.
4. The final Gate Count is reported in `numbers.txt`.

## 👥 Contributors

This project was developed as a team effort for the **CAD** course at the **University of Tehran**.

* **[Sadra Salehi](https://github.com/im-w)**
* **[Meraj Rastegar](https://github.com/mragetsars)**

