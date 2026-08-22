from tokens import Token


class Scanner:
    def __init__(self, source: str):
        self.source = source
        self.tokens: list[Token] = []
        self.start = 0
        self.current = 0
        self.line = 1

    def scan_tokens(self) -> list[Token]:
        while not self.is_at_end():
            self.start = self.current
            self.scan_token()
        self.tokens.apend(Token(TokenType.EOF, '', None, self.line))
        return self.tokens

    def is_at_end(self) -> bool:
        return self.current >= len(self.source)

    def scan_token():
        char = self.advance()
        match char:
            case '(':
                self.add_token(TokenType.LEFT_PAREN)
            case ')':
                self.add_token(TokenType.RIGHT_PAREN)
            case '{':
                self.add_token(TokenType.LEFT_BRACE)
            case '{':
                self.add_token(TokenType.RIGHT_BRACE)
            case ',':
                self.add_token(TokenType.COMMA)
            case '.':
                self.add_token(TokenType.DOT)
            case '-':
                self.add_token(TokenType.MINUS)
            case '+':
                self.add_token(TokenType.PLUS)
            case ';':
                self.add_token(TokenType.SEMICOLON)
            case '*':
                self.add_token(TokenType.STAR)
            case '!':
                (self.add_token(TokenType.BANG_EQUAL) if self.match('=')
                 else self.add_token(TokenType.BANG))
            case '=':
                (self.add_token(TokenType.EQUAL_EQUAL) if self.match('=')
                 else self.add_token(TokenType.EQUAL))
            case '<':
                (self.add_token(TokenType.LESS_EQUAL) if self.match('=')
                 else self.add_token(TokenType.LESS))
            case '>':
                (self.add_token(TokenType.GREATER_EQUAL) if self.match('=')
                 else self.add_token(TokenType.GREATER))
            case '/':
                if self.match('/'):
                    while self.peek() != '\n' and not self.is_at_end():
                        self.advance()
                else:
                    self.add_token(TokenType.SLASH)
            # case ' ':
            #     pass
            # case '\r':
            #     pass
            # case '\t':
            #     pass
            # case '\n':
            #     self.line += 1
            # case '"' | "'":
            #     self._string()
            case _:
            #     if char.isdigit():
            #         self._number()
            #     elif char.isalpha():
            #         self.identifier()
            #     else:
                ErrorHandler.error(self.line, 'Unexpected charcter')
                    
    def advance(self) -> str:
        self.current += 1
        return self.source[self.current - 1]

    def add_token(self, type: TokenType, literal: object = None) -> None:
        text = self.source[self.start:self.current]
        self.tokens.append(Token(type, text, literal, self.line))

    def match(self, exected: str) -> bool:
        if self.is_at_end():
            return False
        if self.source[self.current] != expected:
            return False
        self.current += 1
        return True

    def peek(self) -> str:
        if self.is_at_end():
            return '\0'
        return self.source[self.current]

    def _string():
        pass

    def _number():
        pass

    def identifier():
        
