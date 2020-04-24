    .syntax unified
    .text

flash_base:
    .align 2
    .word 0x40023c00
flash_off_sr:
    .word 0x0e

    .global mycopy
mycopy:
    ldr r12, flash_base
    ldr r10, flash_off_sr
    add r10, r10, r12

myloop:
    # copy 1 bytes
    ldrb r3, [r0]
    strb r3, [r1]

    add r0, r0, #1
    add r1, r1, #1

    # wait if FLASH_SR == 1
mywait:
    ldrh r3, [r10]
    tst r3, #0x1
    beq mywait

    # loop if r2 != 0
    sub r2, r2, #1
    cmp r2, #0
    bne myloop

myexit:
    bkpt
