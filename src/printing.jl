# Definitions to print the optimisation state depending on the type of
# optimisation chosen

function printHeader(io, ::Type{FirstOrderOptimisationState})
    println(io, "-------------------------------------------------------------")
    println(io, "|  Iteration  |  Step Size  |   Residual    |   Gradient    |")
    println(io, "-------------------------------------------------------------")
    flush(io)
end
function printHeader(io, ::Type{NelderMeadOptimisationState})
    println(io, "------------------------------------------------------------------------")
    println(io, "|  Iteration  |       Step Type        |   Residual    |   Gradient    |")
    println(io, "------------------------------------------------------------------------")
    flush(io)
end
