// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Put your code here.

    @1
    D=M
    @3
    M=D

    @2
    M=0

(LOOP)
    @3
    D=M
    @END
    D;JEQ
    @3
    M=D-1

    @2
    D=M
    @0
    D=D+M
    @2
    M=D
     
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
