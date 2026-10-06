from abc import ABC, abstractmethod
from typing import Generic, TypeVar

from tokens import Token


V = TypeVar('V')


class Expr(ABC):
    @abstractmethod
    def accept(self, visitor: Vistor[V]) -> V:
        pass


class Binary(Expr):
    def __init__(self, left: Expr, operator: Token, right: Expr):
        self.left: Expr = left
        self.operator: Token = operator
        self.right: Expr = right

    def accept(self, visitor: Visitor):
        return visitor.visit_binary_expression(self)
