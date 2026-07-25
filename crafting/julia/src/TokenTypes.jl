@enum TokenType begin
    # Single-char tokens
    token_leftparen
    token_rightparen
    token_leftbrace
    token_rightbrace
    token_comma
    token_dot
    token_minus
    token_plus
    token_semicolon
    token_slash
    token_star

    # One or two char
    token_bang
    token_bangequal
    token_equal
    token_equalequal
    token_greater
    token_greaterequal
    token_less
    token_lessequal

    # Literals
    token_identifier
    token_string
    token_number

    # Keywords
    token_and
    token_class
    token_else
    token_false
    token_fun
    token_for
    token_if
    token_nil
    token_or
    token_print
    token_return
    token_super
    token_this
    token_true
    token_var
    token_while

    token_eof
end
