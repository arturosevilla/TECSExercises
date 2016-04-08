// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

// R0 will contain the input from the KBD
// R1 will contain an auxiliary counter for painting the screen

(main)
    // read the input from the keyboard
    @KBD
    D=M
    @R0
    M=D

    // loop through the screen
    @SCREEN
    D=A
    @8191  
    D=A+D
    @R1
    M=D
    
(paint)
    // paint the screen
    @R0
    D=M
    @clear
    D;JEQ
    // blacken the pixels
    D=-1
    @R1
    A=M
    M=D
    @loopCheck
    0;JMP
(clear)
    // clears the pixels
    @R1
    A=M
    M=0
(loopCheck)
    @R1
    MD=M-1
    @SCREEN
    D=D-A
    @paint
    D;JGE
    @main
    0;JMP


