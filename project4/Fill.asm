// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Put your code here.

(LOOP)
    //PIXEL = SCREEN
    @SCREEN
    D=A
    
    @PIXEL
    M=D
    
    // If D > 0, then a key is pressed
    @KBD
    D=M

    @BLACK
    D;JGT

(WHITE)
    @PIXEL
    D=M

    // while (@PIXEL < 0x4000 + 8k)
    @24576
    D=D-A
    @END_PAINT_LOOP
    D;JEQ

    //@PIXEL++
    @PIXEL
    M=M+1
    A=M-1

    // 0 for white
    M=0

    @WHITE
    0;JMP

(BLACK)
    @PIXEL
    D=M

    // while (@PIXEL < 0x4000 + 8K)
    @24576
    D=D-A
    @END_PAINT_LOOP
    D;JEQ
    
    //@PIXEL++
    @PIXEL
    M=M+1
    A=M-1

    // 1 for black
    M=-1

    @BLACK
    0;JMP

    
(END_PAINT_LOOP)
    @LOOP
    0;JMP

