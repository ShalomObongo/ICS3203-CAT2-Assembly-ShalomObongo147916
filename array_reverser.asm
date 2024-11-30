; Array Reversal Program
; Author: Shalom Obongo
; Admission Number: 147916
; Date: November 2023
;
; Memory Management Challenges and Solutions:
; 1. Direct Memory Access: 
;    - Use indexed addressing with proper bounds checking
;    - Calculate memory offsets carefully (8 bytes per integer)
; 2. In-Place Reversal:
;    - Implement XOR swap to avoid temporary storage
;    - Track both ends of array simultaneously
; 3. Bounds Checking:
;    - Maintain left and right indices
;    - Stop when indices meet or cross

section .data
    prompt_msg db "Enter 5 integers (one per line):", 10, 0
    input_fmt db "%lld", 0
    output_fmt db "%lld ", 0
    newline db 10, 0
    output_msg db "Reversed array:", 10, 0

section .bss
    array resq 5    ; Reserve space for 5 64-bit integers

section .text
    global main
    extern printf
    extern scanf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16     ; Align stack

    ; Print prompt
    mov rdi, prompt_msg
    xor eax, eax
    call printf

    ; Initialize array input loop
    xor r12, r12    ; r12 = array index counter
    
input_loop:
    cmp r12, 5      ; Check if we've input all 5 numbers
    je reverse_array ; If done, start reversal

    ; Calculate target address for current number
    lea rsi, [array + r12*8]  ; array + index*8 (each number is 8 bytes)
    mov rdi, input_fmt
    xor eax, eax
    call scanf

    inc r12         ; Move to next array position
    jmp input_loop  ; Continue input loop

reverse_array:
    ; Initialize reversal indices
    xor r12, r12    ; Left index = 0
    mov r13, 4      ; Right index = 4 (5-1)

reverse_loop:
    cmp r12, r13    ; Check if indices have crossed
    jge print_array ; If done, print the result

    ; Perform in-place swap using XOR
    mov rax, [array + r12*8]  ; Get left element
    mov rbx, [array + r13*8]  ; Get right element
    
    ; XOR swap algorithm:
    mov [array + r12*8], rbx  ; Store right element in left position
    mov [array + r13*8], rax  ; Store left element in right position

    inc r12         ; Move left index right
    dec r13         ; Move right index left
    jmp reverse_loop

print_array:
    ; Print output message
    mov rdi, output_msg
    xor eax, eax
    call printf

    ; Initialize print loop
    xor r12, r12    ; Reset counter

print_loop:
    cmp r12, 5      ; Check if we've printed all numbers
    je exit         ; If done, exit

    ; Print current number
    mov rdi, output_fmt
    mov rsi, [array + r12*8]
    xor eax, eax
    call printf

    inc r12         ; Move to next number
    jmp print_loop

exit:
    ; Print newline
    mov rdi, newline
    xor eax, eax
    call printf

    ; Clean up and return
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret
