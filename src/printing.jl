# Definitions to print the optimisation state depending on the type of
# optimisation chosen

printHeader(::IO, ::Type{<:AbstractOptimisationState}) = nothing

function printHeader(io::IO, ::Type{GenericOptimisationState})
    println(io, "---------------------------------------------------------------")
    println(io, "|  Iteration  |     Time      |   Residual    |     Period    |")
    println(io, "---------------------------------------------------------------")
    flush(io)
end

function printHeader(io::IO, ::Type{FirstOrderOptimisationState})
    println(io, "---------------------------------------------------------------------------------------------")
    println(io, "|  Iteration  |     Time      |  Step Size  |   Residual    |   Gradient    |     Period    |")
    println(io, "---------------------------------------------------------------------------------------------")
    flush(io)
end

function printHeader(io::IO, ::Type{NelderMeadOptimisationState})
    println(io, "---------------------------------------------------------------------------------------------------------")
    println(io, "|  Iteration  |     Time      |        Step Type        |   Residual    | √(Σ(yᵢ-ȳ)²)/n |     Period    |")
    println(io, "---------------------------------------------------------------------------------------------------------")
    flush(io)
end

function printHeader(io::IO, ::Type{GradientDescentState})
    println(io, "---------------------------------------------------------------")
    println(io, "|  Iteration  |   Residual    |   Gradient    |     Period    |")
    println(io, "---------------------------------------------------------------")
    flush(io)
end
