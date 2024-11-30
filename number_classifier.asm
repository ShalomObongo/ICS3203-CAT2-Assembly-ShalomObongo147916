; Number Classifier Program
; Author: Shalom Obongo
; Admission Number: 147916
; Date: November 2023
; Purpose: Demonstrates control flow and conditional logic by classifying input numbers
;
; Jump Instructions Used:
; - JG (Jump if Greater): Used for positive numbers because it considers sign
; - JL (Jump if Less): Used for negative numbers, also considers sign
; - JE (Jump if Equal): Used for zero check, most direct comparison
; - JMP (Unconditional Jump): Used to skip other conditions once a match is found

section .data
    prompt db "Enter a number: ", 0
    pos_msg db "POSITIVE", 10, 0    ; 10 is newline
    neg_msg db "NEGATIVE", 10, 0
    zero_msg db "ZERO", 10, 0
    fmt_in db "%d", 0

section .bss
    number resq 1    ; Reserve 8 bytes for the input number

section .text
    global main
    extern printf
    extern scanf

main:
    ; Function prologue - set up stack frame
    push rbp
    mov rbp, rsp
    sub rsp, 16         ; Align stack for function calls

    ; Display prompt
    mov rdi, prompt     ; First argument: format string
    xor eax, eax        ; No floating point arguments
    call printf

    ; Read number
    mov rdi, fmt_in     ; Format for scanf
    mov rsi, number     ; Address to store input
    xor eax, eax
    call scanf

    ; Load number for comparison
    mov rax, [number]
    
    ; Start classification logic
    cmp rax, 0          ; Compare with zero
    je zero_number      ; If equal to zero, jump to zero case
    jg positive_number  ; If greater than zero, jump to positive case
    jl negative_number  ; If less than zero, jump to negative case
                       ; Note: JL used because it's sign-aware

zero_number:
    mov rdi, zero_msg
    jmp print_result    ; Unconditional jump to print routine

positive_number:
    mov rdi, pos_msg
    jmp print_result    ; Skip other conditions, go straight to print

negative_number:
    mov rdi, neg_msg
    ; Falls through to print_result

print_result:
    xor eax, eax
    call printf

    ; Function epilogue - restore stack frame
    mov rsp, rbp
    pop rbp
    xor eax, eax        ; Return 0
    ret
