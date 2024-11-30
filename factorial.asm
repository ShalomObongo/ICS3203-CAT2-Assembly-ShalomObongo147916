; Factorial Calculator Program
; Author: Shalom Obongo
; Admission Number: 147916
; Date: November 2023
;
; Register Management Documentation:
; - RAX: Holds return value and intermediate multiplication results
; - RBX: Preserved register, used for storing current number in recursion
; - RCX: Used for loop counter in iterative version (if needed)
; - RBP: Base pointer, maintains stack frame
; - RSP: Stack pointer, managed for local variables and calls
;
; Stack Management:
; - Each recursive call creates a new stack frame
; - Registers are preserved using push/pop operations
; - Return addresses managed automatically by call/ret
; - Stack alignment maintained for system calls

section .data
    prompt_msg db "Enter a number to calculate factorial: ", 0
    result_msg db "Factorial of %d is: %lld", 10, 0
    input_fmt db "%d", 0
    error_msg db "Error: Input must be non-negative", 10, 0

section .bss
    number resq 1       ; Input number storage

section .text
    global main
    extern printf
    extern scanf

main:
    ; Set up stack frame
    push rbp
    mov rbp, rsp
    sub rsp, 16         ; Align stack for function calls

    ; Print prompt
    mov rdi, prompt_msg
    xor eax, eax
    call printf

    ; Read number
    mov rdi, input_fmt
    mov rsi, number
    xor eax, eax
    call scanf

    ; Check if input is negative
    mov rdi, [number]
    cmp rdi, 0
    jl error_handler

    ; Calculate factorial
    mov rdi, [number]   ; Load input number
    call factorial      ; Result will be in RAX

    ; Print result
    mov rdi, result_msg
    mov rsi, [number]   ; Original number
    mov rdx, rax        ; Factorial result
    xor eax, eax
    call printf
    jmp exit

error_handler:
    mov rdi, error_msg
    xor eax, eax
    call printf

exit:
    ; Clean up and return
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret

; Factorial subroutine
; Input: RDI = number to calculate factorial for
; Output: RAX = factorial result
; Preserves: RBX
factorial:
    ; Set up stack frame
    push rbp
    mov rbp, rsp
    push rbx            ; Preserve RBX (callee-saved register)

    ; Save input parameter
    mov rbx, rdi

    ; Base cases: 0! = 1, 1! = 1
    cmp rdi, 1
    jle factorial_base_case

    ; Recursive case: n * factorial(n-1)
    dec rdi             ; n-1
    call factorial      ; Recursive call for (n-1)!
    
    ; Multiply result by n
    mul rbx             ; RAX = RAX * RBX

    jmp factorial_end

factorial_base_case:
    mov rax, 1          ; Return 1 for input <= 1

factorial_end:
    ; Restore registers and return
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
