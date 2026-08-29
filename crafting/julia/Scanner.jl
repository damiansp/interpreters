module Scanners

export Scanner, scantokens

using ..Errors
using ..Lox
using ..Tokens


mutable struct Scanner{S<:AbstractString}
    runner::Runner
    source::S
    tokens::Vector{Any}
    start::UInt
    current::UInt
    line::UInt
end


Scanner(runner, source) = Scanner(
    runner, source, [], one(UInt), one(UInt), one(UInt))


nextchar(scanner::Scanner) = (
    scanner.current = nextind(scanner.source, scanner.current))


const keywords = Dict(
    "and" => token_and,
    "class" => token_class,
    "else" => token_else,
    "false" => token_false,
    "for" => token_for,
    "fun" => token_fun,
    "if" => token_if,
    "nil" => token_nil,
    "or" => token_or,
    "print" => token_print,
    "return" => token_return,
    "super" => token_super,
    "this" => token_this,
    "true" => token_true,
    "var" => token_var,
    "while" => token_while,)


function scantokens(scanner::Scanner)
    while !isatend(scanner)
        scanner.start = scanner.current
        scantokens(scanner)
    end
    push!(scanner.tokens, Token(token_eof, Symbol(""), nothing, scanner.line))
end


isatend(scanner::Scanner) = scanner.current > ncodeunits(scanner.source)


function scantoken(scanner::Scanner)
    char = advance(scanner)
    if char == '('
        addtoken(scanner, token_leftparen)
    elseif char == ')'
        addtoken(scanner, token_rightparen)
    elseif char == '{'
        addtoken(scanner, token_leftbrace)
    elseif char == '}'
        addtoken(scanner, token_rightbrace)
    elseif char == ','
        addtoken(scanner, token_comma)
    elseif char == '.'
        addtoken(scanner, token_dot)
    elseif char == '-'
        addtoken(scanner, token_minus)
    elseif char == '+'
        addtoken(scanner, token_plus)
    elseif char == ';'
        addtoken(scanner, token_semicolon)
    elseif char == '*'
        addtoken(scanner, token_star)
    elseif char == '!'
        addtoken(scanner, match(scanner, '=') ? token_bangequal : token_bang)
    elseif char == '='
        addtoken(
            scanner, match(scanner, '=') ? token_equalequal: token_equal)
    elseif char == '<'
        addtoken(scanner, match(scanner, '=') ? token_lessequal: token_less)
    elseif char == '>'
        addtoken(
            scanner, match(scanner, '=') ? token_greaterequal: token_greater)
    elseif char == '/'
        if match(scanner, '/')
            while peek(scanner) != '\n' && !isatend(scanner)
                advance(scanner)
            end
        else
            addtoken(scanner, token_slash)
        end
    else
        loxerror(scanner.runner, scanner.line, "Unexpected character.")
    end
end


function advance(scanner::Scanner)
    char = scanner.source[scanner.current]
    nextchar(scanner)
    char
end


function addtoken(scanner::Scanner, type::TokenType, literal=nothing)
    endind = prevind(scanner.source, scanner.current)
    lexeme = Symbol(scanner.source[scanner.start:endind])
    push!(scanner.tokens, Token(type, lexeme, literal, scanner.line))
end


function match(scanner::Scanner, expected::AbstractChar)
    isatend(scanner) && return false
    scanner.source[scanner.current] != expected && return false
    nextchar(scanner)
    true
end


isatend(scanner::Scanner) = scanner.current > ncodeunits(scanner.source)


function peek(scanner::Scanner)
    isatend(scanner) ? '\0' : scanner.source[scanner.current]
end


end  # module
