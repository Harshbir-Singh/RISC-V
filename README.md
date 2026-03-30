<img width="1092" height="646" alt="ArchitectureFinal" src="https://github.com/user-attachments/assets/90fad1ca-9004-4602-9f60-4009156d3df6" />





**RV32I Pipelined Processor Core**

A fully functional 5-stage pipelined RV32I RISC-V processor implemented in hardware description language, supporting all 37 instructions of the RV32I base integer ISA. The design includes a complete Hazard Detection Unit with data forwarding, stalling, and pipeline flushing; verified functionally using Ripes, a visual RISC-V simulator.

**Features:**
1) Full RV32I Base Integer Instruction Set (37 instructions).
2) 5-stage pipeline: IF → ID → EX → MEM → WB.
3) Hazard Detection Unit with:
    - Data forwarding (EX-EX and MEM-EX forwarding paths).
    - Pipeline stalling (load-use hazard).
    - Pipeline flushing (control hazard on branches/jumps).
4) Verified against **Ripes.me** RISC-V simulator.

**Hazard Unit:**

The Hazard Detection Unit resolves three classes of pipeline hazards:

**1. Data Hazards — Forwarding**

When an instruction depends on the result of a previous instruction still in the pipeline, the forwarding unit routes the result directly to the EX stage input, avoiding unnecessary stalls.

    - EX → EX Forwarding: Result from the EX/MEM pipeline register forwarded to the current EX stage.
    - MEM → EX Forwarding: Result from the MEM/WB pipeline register forwarded to the current EX stage.

**2. Load-Use Hazard — Stalling**

When a LOAD instruction is followed immediately by an instruction that uses the loaded value, one stall cycle is inserted:

    - The IF/ID and PC registers are frozen (stalled).
    - A NOP bubble is injected into the EX stage.

**3. Control Hazards — Flushing**

On taken branches (BEQ, BNE, BLT, etc.) and jumps (JAL, JALR):

    - The incorrectly fetched instructions in IF and ID stages are flushed (converted to NOPs).
    - The PC is updated to the correct target address.

**Supported Instructions:**

U-Type :

    - LUI: Load Upper Immediate
    - AUIPC: Add Upper Immediate to PC
  
J-Type:

     - JAL: Jump and Link
     - JALR: Jump and Link Register
   
B-Type — Branches:

    - BEQ: Branch if Equal
    - BNE: Branch if Not Equal
    - BLT: Branch if Less Than (signed)
    - BGE: Branch if Greater or Equal (signed)
    - BLTU: Branch if Less Than (unsigned)
    - BGEU: Branch if Greater or Equal (unsigned)
  
I-Type — Loads:

    - LB: Load Byte (sign-extended)
    - LH: Load Halfword (sign-extended)
    - LW: Load Word
    - LBU: Load Byte (zero-extended)
    - LHU: Load Halfword (zero-extended)
  
S-Type — Stores:

    - SB: Store Byte
    - SH: Store Halfword
    - SW: Store Word
  
I-Type — Immediate Arithmetic:

    - ADDI: Add Immediate
    - SLTI: Set Less Than Immediate (signed)
    - SLTIU: Set Less Than Immediate (unsigned)
    - XORI: XOR Immediate
    - ORI: OR Immediate
    - ANDI: AND Immediate
    - SLLI: Shift Left Logical Immediate
    - SRLI: Shift Right Logical Immediate
    - SRAI: Shift Right Arithmetic Immediate
  
R-Type — Register Arithmetic:

    - ADD: Add
    - SUB: Subtract
    - SLL: Shift Left Logical
    - SLT: Set Less Than (signed)
    - SLTU: Set Less Than (unsigned)
    - XOR: XOR
    - SRL: Shift Right Logical
    - SRA: Shift Right Arithmetic
    - OR: OR
    - AND: AND

**Verification:**

Verified for correct functional behavior using Ripes — a visual pipeline simulator for RISC-V. Test programs were written in RISC-V assembly and executed step-by-step to confirm:

    - Correct register writeback values
    - Proper memory read/write behavior
    - Correct branch/jump resolution and PC updates
    - Accurate hazard handling (stall cycles, forwarding, and flushes visible in pipeline view)
