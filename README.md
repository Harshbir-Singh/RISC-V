<img width="1092" height="646" alt="ArchitectureFinal" src="https://github.com/user-attachments/assets/90fad1ca-9004-4602-9f60-4009156d3df6" />


**RISC_V — RV32I Pipelined Processor Core**

A fully functional 5-stage pipelined RV32I RISC-V processor implemented in hardware description language, supporting all 37 instructions of the RV32I base integer ISA. The design includes a complete Hazard Detection Unit with data forwarding, stalling, and pipeline flushing — verified functionally using Ripes, a visual RISC-V simulator.

**Features:**
1) Full RV32I Base Integer Instruction Set (37 instructions)
2) Classic 5-stage pipeline: IF → ID → EX → MEM → WB
3) Hazard Detection Unit with:
  - Data forwarding (EX-EX and MEM-EX forwarding paths)
  - Pipeline stalling (load-use hazard)
  - Pipeline flushing (control hazard on branches/jumps)
4) Verified against Ripes RISC-V simulator
