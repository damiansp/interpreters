module Expressions

export (
    AssignExpr, BinaryExpr, CallExpr, GetExpr, GroupingExpr, LiteralExpr,
    LoxExpr)

using ..Tokens


# We prefix with "Lox" to avoid confusion with Julia `Expr`s
abstract type LoxExpr end


mutable struct BinaryExpr{L<:LoxExpr, R<:LoxExpr} <: LoxExpr
    left::L
    operator::Token
    right::R
end


end  # module
