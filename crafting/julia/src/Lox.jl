module Lox


export runfile, Runner, runprompt, runstring


mutable struct Runner
    io::IO
    ioerr::IO
    haderror::Bool
    hadruntimeerror::Bool
end


Runner() = Runner(stdout, stderr, false, false)
Runner(io::IO, ioerr::IO) = Runner(io, ioerr, false, false)


include("Errors.jl")
using .Errors

include("Expressions.jl")
include("Interpreters.jl")
using .Interpreters

include("Parser.jl")
using .Parsers

include("Resolvers.jl")
using .Resolvers

include("Scanner.jl")
using .Scanners

include("Statements.jl")
include("Tokens.jl")
using .Tokens


const BASE_ERR = 65
const RUNTIME_ERR = 70


function runfile(runner::Runner, p::AbstractString)
    contents = read(p, String)
    terp = Interpreter(runner)
    run(runner, terp, contents)
    runner.haderror && return BASE_ERR
    runner.hadruntimeerror && return RUNTIME_ERR
    0
end


function runstring(runner::Runner, contents::AbstractString)
    terp = Inerpreter(runner)
    run(runner, terp, contents)
    runner.haderror && return BASE_ERR
    runner.hadruntimeerror && return RUNTIME_ERR
    0
end


function runprompt(runner::Runner)
    terp = Interpreter(runner)
    while true
        print("lox > ")
        line = readline()
        run(runner, terp, line)
        println()
        runner.haderror = false
    end
end


function run(runner::Runner, terp, source::AbstractString)
    scanner = Scanner(runner, source)
    tokens = scantokens(scanner)
    parser = Parser(runner, tokens)
    statements = parser()
    runner.haderror && return
    resolver = Resolver(terp)
    resolve(resolver, statements)
    runner.haderror && return
    interpret(terp, statements)
end


end  # module
