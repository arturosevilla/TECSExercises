module TuriHacks.Tecs.Assembler.Opcode (
    Destination,
    Calculation,
    Jump,
    Instruction,
    Mnemonic) where

import Data.Int

data Destination = None | M | D | MD | A | AM | AD | AMD
data Calculation = Zero | One | Neg1 | DRegister | ARegister | Memory |
                   NotD | NotA | NotM | NegD | NegA | NegM | DPlus1 | 
                   APlus1 | MPlus1 | DMinus1 | AMinus1 | MMinus1 | 
                   DPlusA | DPlusM | DMinusA | DMinusM | AMinusD |
                   MMinusD | DAndA | DAndM | DOrA | DOrM
data Jump = Next | JGT | JEQ | JGE | JLT | JNE | JLE | JMP deriving (Show)

data Instruction = CInstruction Destination Calculation Jump | 
                   AInstruction { value :: Int16 } |
                   AInstructionWithLabel { label :: String }

data Mnemonic = Instruction | Label { labelName :: String }

instance Show Mnemonic where
    show (Label labelName) = "(" ++ labelName ++ ")"

instance Show Instruction where
    show (CInstruction None calc Next) = show calc
    show (CInstruction dest calc Next) = show dest ++ "=" ++ show calc
    show (CInstruction None calc jmp) = show calc ++ ";" ++ show jmp
    show (CInstruction dest calc jmp) = show dest ++ "=" ++ show calc ++ ";" ++ show jmp
    show (AInstruction value) = "@" ++ show value
    show (AInstructionWithLabel labelName) = "@" ++ labelName

instance Show Destination where
    show None = ""
    show M = "M"
    show D = "D"
    show MD = "MD"
    show A = "A"
    show AM = "AM"
    show AD = "AD"
    show AMD = "AMD"

instance Show Calculation where
    show Zero = "0"
    show One = "1"
    show Neg1 = "-1"
    show DRegister = "D"
    show ARegister = "A"
    show Memory = "M"
    show NotD = "!D"
    show NotA = "!A"
    show NotM = "!M"
    show NegD = "-D"
    show NegA = "-A"
    show NegM = "-M"
    show DPlus1 = "D+1"
    show APlus1 = "A+1"
    show MPlus1 = "M+1"
    show DMinus1 = "D-1"
    show AMinus1 = "A-1"
    show MMinus1 = "M-1"
    show DPlusA = "D+A"
    show DPlusM = "D+M"
    show DMinusA = "D-A"
    show DMinusM = "D-M"
    show AMinusD = "A-D"
    show MMinusD = "M-D"
    show DAndA = "D&A"
    show DAndM = "D&M"
    show DOrA = "D|A"
    show DOrM = "D|M"
