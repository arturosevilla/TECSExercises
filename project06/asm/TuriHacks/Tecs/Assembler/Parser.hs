{-# LANGUAGE OverloadedStrings #-}

module TuriHacks.Tecs.Assembler.Parser (
    parse,
    Program,
    ParseError
) where

import qualified TuriHacks.Tecs.Assembler.Lexer as Lexer
import qualified TuriHacks.Tecs.Assembler.Opcode as Opcode
import qualified Data.Text as Text

data ParseError = ParseError Lexer.Token Lexer.Token lineNumber
type Program = Either ParseError [Opcode.Instruction]

newtype Parser a = Parser { 
    getParser :: Lexer.Token -> ([Lexer.Token], Program)
}

instance Functor Parser where
    fmap f (Parser advance) = Parser $ \tokens -> case advance tokens of
        (tokensToParse, Left err) -> (tokensToParse, Left err)
        (tokensToParse, Right a) -> (tokensToParse, Right (f a))

instance Applicative Parser where
    pure a = Parser (\stream -> (stream, Right a))
    Parser f1 <*> Parser g1 = Parser $ \tokens -> case f1 tokens of
        (nextTokens, Left err) -> (nextTokens, Left err)
        (nextTokens, Right f) -> case g1 tokens of
            (nextTokens2, Left err) -> (nextTokens2, Left err)
            (nextTokens2, Right g) -> (nextTokens2, Right (f g))

parse :: [Text.Text] -> Program
parse [] = []
parse lines = parseTokens [] $ Lexer.tokenize lines

parseTokens :: [Lexer.Token] -> Program
parseTokens [] = []
parseTokens (token:tokens) = ,

parseOpenParens :: [Lexer.Token] -> Parser a
parseOpenParens tokens = satisfy (\token -> case token of 
    (Lexer.OpenParensToken _) -> True
    otherwise -> False)

parseCloseParens :: [Lexer.Token] -> Parser a
parseCloseParens tokens = satisfy (\token -> case token of
    (Lexer.CloseParentsToken _) -> True
    otherwise -> False)

parseLabel :: [Lexer.Token] -> Parser a
parseLabel tokens = dropParens <$> parseOpenParens <*> parseLabel <*> parseCloseParens
    where dropParens _ label _ = label




