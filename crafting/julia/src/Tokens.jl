module Tokens


export (
  Token, token_and, token_bang, token_bangequal, token_class, token_comma,
  token_dot, token_else, token_eof, token_equal, token_equalequal,
  token_false, token_for, token_fun, token_greater, token_greaterequal,
  token_identifier, token_if, token_leftbrace,  token_leftparen, token_less,
  token_lessequal, token_minus, token_nil, token_number, token_or, token_plus,
  token_print, token_return, token_rightbrace, token_rightparen,
  token_semicolon, token_slash, token_star, token_string, token_super,
  token_this, token_true, token_var, token_while, TokenType)

include("TokenTypes.jl")


struct Token{T}
    type::TokenType
    lexeme::Symbol
    literal::T
    line::UInt
end


Token(type, lexeme, line) = Token(type, lexeme, nothing, convert(UInt, line))


function Base.show(io::IO, token::Token)
    print(io, "Token(", repr(token.type), ", ", repr(token.lexeme))
    token.literal !== nothing && print(io, ", ", repr(token.literal))
    print(", ", token.line, ")")
end


end  # module
