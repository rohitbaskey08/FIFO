# FIFO (First-In First-Out) Memory Design in Verilog

## Overview

This project implements an **8x8 FIFO (First-In First-Out) memory** using Verilog HDL.
FIFO is a memory structure where the **first data written into the memory is the first data read out**. It is widely used in digital systems for **data buffering and clock domain communication**.

The design includes:

* FIFO memory module
* Control signals for read and write
* Full and empty status flags
* Testbench for simulation

---

## FIFO Specifications

| Parameter     | Value             |
| ------------- | ----------------- |
| Data Width    | 8 bits            |
| FIFO Depth    | 8 locations       |
| Write Pointer | 3 bits            |
| Read Pointer  | 3 bits            |
| Clock         | Single clock      |
| Reset         | Synchronous reset |

---

## Ports Description

### Inputs

* **clk** : System clock signal
* **rst** : Reset signal (clears FIFO)
* **wr_en** : Write enable signal
* **rd_en** : Read enable signal
* **data_in [7:0]** : Input data to be written into FIFO

### Outputs

* **data_out [7:0]** : Output data read from FIFO
* **full** : Indicates FIFO is full
* **empty** : Indicates FIFO is empty

---

## Internal Components

### Memory Array

The FIFO uses an internal memory array:

```
reg [7:0] mem [0:7];
```

This creates **8 memory locations with 8-bit width**.

### Write Pointer

Tracks the location where new data will be written.

```
reg [2:0] wr_ptr;
```

### Read Pointer

Tracks the location from where data will be read.

```
reg [2:0] rd_ptr;
```

---

## Working Principle

### Write Operation

When:

* `wr_en = 1`
* FIFO is **not full**

Then data is written into memory:

```
mem[wr_ptr] <= data_in;
wr_ptr <= wr_ptr + 1;
```

---

### Read Operation

When:

* `rd_en = 1`
* FIFO is **not empty**

Then data is read from memory:

```
data_out <= mem[rd_ptr];
rd_ptr <= rd_ptr + 1;
```

---

## FIFO Status Conditions

### FIFO Empty

```
empty = (wr_ptr == rd_ptr)
```

### FIFO Full

```
full = ((wr_ptr + 1) == rd_ptr)
```

---

## Testbench

A Verilog testbench is included to verify:

* Reset functionality
* Write operations
* Read operations
* Full condition
* Empty condition

The testbench generates a **clock signal** and applies various **input patterns** to verify FIFO behavior.

---

## Simulation

The design can be simulated using tools such as:

* **Xilinx Vivado**
* **ModelSim**
* **Icarus Verilog**
* **GTKWave**

### Steps

1. Compile FIFO module
2. Compile testbench
3. Run simulation
4. Observe waveform results

---

## Applications

FIFO is commonly used in:

* Data buffering
* UART communication
* Network routers
* Clock domain crossing
* Streaming data processing

---

## Future Improvements

Possible enhancements include:

* Parameterized FIFO depth and width
* Asynchronous FIFO design
* Gray code pointer implementation
* Almost full and almost empty signals

---

## Author

**Rohit Baskey**

Project created as part of **VLSI / Digital Design practice using Verilog HDL**.
