# ICS3203-CAT2-Assembly-ShalomObongo147916

Assembly Language Programming CAT 2 Implementation
- **Name:** Shalom Obongo
- **Admission Number:** 147916
- **Unit:** ICS 3203 - Assembly Language Programming

## Programs Overview

### 1. Number Classifier (number_classifier.asm)
A program that takes a numerical input and classifies it as positive, negative, or zero using assembly language control flow mechanisms.
- Demonstrates effective use of conditional and unconditional jumps
- Implements clean branching logic
- Includes detailed documentation of jump instruction choices

### 2. Array Reverser (array_reverser.asm)
Implements in-place array reversal for five integers using efficient memory management.
- Uses direct memory manipulation for array reversal
- Implements looping constructs for array traversal
- Achieves reversal without additional memory allocation

### 3. Factorial Calculator (factorial.asm)
A modular program that calculates factorials using subroutines and proper register management.
- Implements recursive factorial calculation
- Demonstrates proper stack frame management
- Shows effective register preservation techniques

### 4. Water Level Controller (water_controller.asm)
Simulates a water level control system using memory-mapped I/O techniques.
- Reads simulated sensor values
- Controls virtual motor and alarm systems
- Implements threshold-based decision making

## Compilation and Execution Instructions

### Prerequisites
- NASM (Netwide Assembler)
- Linux/Unix environment
- GCC (for linking)

### Compilation Steps
For each program (replace program_name with the actual file name):

```bash
# 1. Assemble the program
nasm -f elf64 program_name.asm -o program_name.o

# 2. Link the object file
ld program_name.o -o program_name

# 3. Execute the program
./program_name
```

## Implementation Insights and Challenges

### 1. Number Classifier
- **Challenges:**
  - Implementing efficient comparison logic
  - Handling edge cases (e.g., maximum/minimum integers)
  - Managing proper control flow with multiple conditions
- **Solutions:**
  - Used CMP instruction with careful flag checking
  - Implemented robust input validation
  - Structured jumps for optimal flow control

### 2. Array Reverser
- **Challenges:**
  - Managing direct memory access safely
  - Implementing in-place reversal without temporary storage
  - Handling array bounds correctly
- **Solutions:**
  - Used indexed addressing for efficient memory access
  - Implemented XOR swap for in-place element exchange
  - Careful index management to prevent overflow

### 3. Factorial Calculator
- **Challenges:**
  - Managing recursive calls in assembly
  - Preserving register values across calls
  - Handling stack frame properly
- **Solutions:**
  - Implemented proper stack frame setup/teardown
  - Careful register preservation using push/pop
  - Efficient register allocation strategy

### 4. Water Controller
- **Challenges:**
  - Simulating I/O operations in memory
  - Managing multiple status flags
  - Implementing reliable threshold checking
- **Solutions:**
  - Used memory locations as virtual I/O ports
  - Implemented bit manipulation for status flags
  - Created clear threshold-based control logic

## Testing
Each program has been tested with various inputs including:
- Boundary cases (minimum/maximum values)
- Zero and near-zero values
- Typical use cases
- Error conditions

## Future Improvements
- Add input validation for all programs
- Implement error handling for edge cases
- Optimize memory usage in array operations
- Add more detailed status reporting
