import sys


INDENT = '    '
INDENT2 = 2 * INDENT


def main():
    if len(sys.argv) != 2:
        print('Usage: python generate_ast.py <output directory>')
        sys.exit(64)
    output_dir = sy.argv[1]
    define_ast(
        output_dir,
        'Expr',
        ['Binary | left: Expr, operator: Token, right: Expr',
         'Grouping | expression: Expr',
         'Literal | value',
         'Unary | operator: Token, right: Expr'])


def define_ast(output_dir: str, base_name: str, types: list[str]) -> None:
    lower_base_name = base_name.lower()
    path = f'{output_dir}/{lower_base_name}.py'
    with open(path, 'w', encoding='UTF-8') as f:
        #define_imports(f, extra_imports)
        f.write('from abc import ABC, abstractmethod\n')
        f.write('from typing import Generic, TypeVar\n\n')
        #define_vistor(f, base_name, lower_base_name, types)
        #define_base_class(f, base_name)
        f.write(f'class {base_name}(ABC):\n')
        f.write(f'{INDENT}@abstractmethod\n')
        f.write(f'{INDENT}def accept(self, visitor: Visitor[V]) -> V:\n')
        f.write(f'{INDENT2}...\n')


    


if __name__ == '__main__':
    main()
