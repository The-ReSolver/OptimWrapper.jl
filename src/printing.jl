# Definitions to print the optimisation state depending on the type of
# optimisation chosen

function printHeader(io, ::Type{GenericOptimistionState})
    println(io, "-----------------------------------------------")
    println(io, "|  Iteration  |     Time      |   Residual    |")
    println(io, "-----------------------------------------------")
    flush(io)
end
function printHeader(io, ::Type{FirstOrderOptimisationState})
    println(io, "-----------------------------------------------------------------------------")
    println(io, "|  Iteration  |     Time      |  Step Size  |   Residual    |   Gradient    |")
    println(io, "-----------------------------------------------------------------------------")
    flush(io)
end
function printHeader(io, ::Type{NelderMeadOptimisationState})
    println(io, "-----------------------------------------------------------------------------------------")
    println(io, "|  Iteration  |     Time      |        Step Type        |   Residual    | √(Σ(yᵢ-ȳ)²)/n |")
    println(io, "-----------------------------------------------------------------------------------------")
    flush(io)
end
