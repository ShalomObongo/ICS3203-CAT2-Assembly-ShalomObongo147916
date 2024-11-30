; Water Level Controller Simulation
; Author: Shalom Obongo
; Admission Number: 147916
; Date: November 2023
;
; Memory/Port Management Documentation:
; 1. Sensor Input (water_level):
;    - Simulated as 8-byte memory location
;    - Values range from 0-100 representing water level percentage
;
; 2. Control Registers:
;    - motor_status: Bit 0 controls motor (1=ON, 0=OFF)
;    - alarm_status: Bit 0 controls alarm (1=ON, 0=OFF)
;
; 3. Threshold Logic:
;    - HIGH_THRESHOLD (80): Triggers alarm, stops motor
;    - LOW_THRESHOLD (20): Activates motor, stops alarm
;    - MODERATE_RANGE: Between thresholds, maintains current state
;
; 4. Port Simulation:
;    - Memory locations used to simulate I/O ports
;    - Bit manipulation used for control signals
;    - Status updates reflected in memory-mapped locations

section .data
    ; Control parameters
    HIGH_THRESHOLD equ 80
    LOW_THRESHOLD equ 20

    ; Display messages
    prompt_msg db "Enter water level (0-100): ", 0
    level_msg db "Current Water Level: %d%%", 10, 0
    motor_msg db "Motor Status: %s", 10, 0
    alarm_msg db "Alarm Status: %s", 10, 0
    status_msg db "System Status:", 10, 0
    error_msg db "Error: Invalid water level (0-100 only)", 10, 0
    
    ; Status strings
    on_str db "ON", 0
    off_str db "OFF", 0
    
    ; I/O format
    input_fmt db "%d", 0

section .bss
    water_level resq 1      ; 8-byte water level storage
    motor_status resb 1     ; Motor control bit
    alarm_status resb 1     ; Alarm control bit

section .text
    global main
    extern printf
    extern scanf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16             ; Align stack

simulation_loop:
    ; Display prompt
    mov rdi, prompt_msg
    xor eax, eax
    call printf

    ; Read water level
    mov rdi, input_fmt
    mov rsi, water_level
    xor eax, eax
    call scanf

    ; Validate input (0-100)
    mov rax, [water_level]
    cmp rax, 0
    jl invalid_input
    cmp rax, 100
    jg invalid_input

    ; Process water level and update controls
    call update_controls
    call display_status
    jmp simulation_loop

invalid_input:
    mov rdi, error_msg
    xor eax, eax
    call printf
    jmp simulation_loop

; Subroutine: Updates control bits based on water level
update_controls:
    push rbp
    mov rbp, rsp

    mov rax, [water_level]
    
    ; Check high threshold
    cmp rax, HIGH_THRESHOLD
    jge high_water_level
    
    ; Check low threshold
    cmp rax, LOW_THRESHOLD
    jle low_water_level
    
    ; Moderate water level - stop motor, clear alarm
    mov byte [motor_status], 0
    mov byte [alarm_status], 0
    jmp update_end

high_water_level:
    ; High level - stop motor, set alarm
    mov byte [motor_status], 0
    mov byte [alarm_status], 1
    jmp update_end

low_water_level:
    ; Low level - start motor, clear alarm
    mov byte [motor_status], 1
    mov byte [alarm_status], 0

update_end:
    mov rsp, rbp
    pop rbp
    ret

; Subroutine: Displays current system status
display_status:
    push rbp
    mov rbp, rsp

    ; Print status header
    mov rdi, status_msg
    xor eax, eax
    call printf

    ; Print water level
    mov rdi, level_msg
    mov rsi, [water_level]
    xor eax, eax
    call printf

    ; Print motor status
    mov rdi, motor_msg
    movzx rsi, byte [motor_status]
    mov rdx, off_str
    test rsi, rsi
    jz .print_motor
    mov rdx, on_str
.print_motor:
    mov rsi, rdx
    xor eax, eax
    call printf

    ; Print alarm status
    mov rdi, alarm_msg
    movzx rsi, byte [alarm_status]
    mov rdx, off_str
    test rsi, rsi
    jz .print_alarm
    mov rdx, on_str
.print_alarm:
    mov rsi, rdx
    xor eax, eax
    call printf

    mov rsp, rbp
    pop rbp
    ret
