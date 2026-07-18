import sys
from parser import Parser

from error_handler import ErrorHandler
from interpreter import Interpreter
from resolver import Resolver
from scanner import Scanner


USAGE_ERROR = 64
BASE_ERROR = 65
RUNTIME_ERROR = 70


class Lox:
    def __init__(self, interpreter: Interpreter) -> None:
        self.interpreter = interpreter

    def run_file(self, path: str) -> None:
        f = open(path)
        self.run(f.read())
        if ErrorHandler.has_error:
            sys.exit(BASE_ERROR)
        if ErrorHandler.had_runtime_error:
            sys.exit(RUNTIME_ERROR)

    def run_prompt(self) -> None:
        while True:
            line = input("rj-plox > ")
            if line is None or line == 'exit':
                break
            self.run(line)
            ErrorHandler.has_error = False

    def run(self, source: str) -> None:
        scanner = Scanner(source)
        tokens = scanner.scan_tokens()
        parser = Parser(tokens)
        statements = parser.parse()
        if ErrorHandler.has_error:
            sys.exit(BASE_ERROR)
        resolver = Resolver(interpreter)
        resolver.resolve_stmts(statements)
        if ErrorHandler.had_runtime_error:
            sys.exit(RUNTIME_ERROR)
        self.interpreter.interpret(statements)


if __name__ == '__main__':
    interpreter = Interpreter()
    lox = Lox(interpreter)
    if len(sys.argv) > 2:
        print('Usage: rjpylox [script name]')
        sys.exit(USAGE_ERROR)
    elif len(sys.argv) == 2:
        script = sys.argv[1]
        lox.run_file(script)
    else:
        lox.run_prompt()
