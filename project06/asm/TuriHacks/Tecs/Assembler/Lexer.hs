{-# LANGUAGE OverloadedStrings #-}
module TuriHacks.Tecs.Assembler.Lexer (
    Token,
    tokenize
) where

import qualified Data.Text as Text
import qualified Control.Monad as M
import Data.Char

data Token = NumericToken Text.Text Int | AtToken Int |
             OperationToken Text.Text Int | LabelToken Text.Text Int |
             SemicolonToken Int | AssignmentToken Int | EndOfLineToken Int |
             OpenParensToken Int | CloseParentsToken Int |
             ErrorToken Int deriving Show

tokenize :: [Text.Text] -> [Token]
tokenize [] = []
tokenize lines = M.join $ map tokenizeWithLines $ zip [1..] $ map Text.strip lines

tokenizeWithLines :: (Int, Text.Text) -> [Token]
tokenizeWithLines (_, "") = []
tokenizeWithLines (lineNumber, line) = tokenizeLineText lineNumber line

tokenizeLineText :: Int -> Text.Text -> [Token]
tokenizeLineText _ "" = []
tokenizeLineText lineNumber line = tokenizeLine lineNumber $ Text.unpack line

tokenizeLine :: Int -> [Char] -> [Token]
tokenizeLine lineNumber "" = [EndOfLineToken lineNumber]
tokenizeLine lineNumber ('(':xs) = OpenParensToken lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber (')':xs) = CloseParentsToken lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('@':xs) = AtToken lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('+':xs) = OperationToken "+" lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('-':xs) = OperationToken "-" lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('&':xs) = OperationToken "&" lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('|':xs) = OperationToken "|" lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber (';':xs) = SemicolonToken lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber ('=':xs) = AssignmentToken lineNumber : tokenizeLine lineNumber xs
tokenizeLine lineNumber (c:xs)
    | isValidLabelBeginning c = 
        let (restOfLabel, restOfLine) = span isValidLabelChar xs in 
            ( LabelToken (Text.pack $ c : restOfLabel) lineNumber : 
                tokenizeLine lineNumber restOfLine)
    | isDigit c = 
        let (restOfNumber, restOfLine) = span isDigit xs in
            ( NumericToken (Text.pack $ c : restOfNumber) lineNumber :
                tokenizeLine lineNumber restOfLine)
    | otherwise = ErrorToken lineNumber : []

isValidLabelBeginning :: Char -> Bool
isValidLabelBeginning x = x == '_' || isAlpha x

isValidLabelChar :: Char -> Bool
isValidLabelChar '_' = True
isValidLabelChar x = isAlpha x || isDigit x

