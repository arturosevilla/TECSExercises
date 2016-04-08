// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

    @2 // product
    M=0
(LOOP)
    // test if the value at R0 is 0
    @0
    D=M
    D=D-A
    @END
    D;JEQ

    // now add whatever is in R2 with R1, and store it in R2
    @1
    D=M
    @2
    M=D+M

    // decrease R0
    @0
    M=M-1
    
    @LOOP
    0;JMP
(END)
