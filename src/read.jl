# Definitions to read optimisation data from disc.

function loadOptimisation(path, ::Val{Inf}, readMethod)
    finalIteration = getFinalIteration(path)
    return loadOptimisation(path, finalIteration, readMethod)
end

function loadOptimisation(path, iteration::Int, readMethod)
    parameters = readOptimisationParameters(path)
    optimisationVariable = readMethod(path*string(iteration)*"/", values(parameters)...)
    readOptimisationVariable!(optimisationVariable, path*string(iteration)*"/")
    optimisationState = tryToReadOptimisationState(path*string(iteration)*"/")
    return optimisationVariable, optimisationState
end

getFinalIteration(path) = maximum(parse.(Int, filter!(x->tryparse(Int, x) !== nothing, readdir(path))))

function readOptimisationParameters(path)
    jldopen(path*"parameters.jld2", "r") do f
        return unpackParametersDictionary(f)
    end
end

function unpackParametersDictionary(fileIO)
    parameters = OrderedDict()
    for key in keys(fileIO)
        merge!(parameters, Dict(key => fileIO[key]))
    end
    return parameters
end

function readOptimisationVariable!(optimisationVariable, path)
    open(path*"optVar", "r") do f
        read!(f, parent(optimisationVariable))
    end
end

function tryToReadOptimisationState(path)
    local optimisationState
    try
        optimisationState = readOptimisationState(path)
    catch
        optimisationState = nothing
    end
    return optimisationState
end

function readOptimisationState(path)
    jldopen(path*"state.jld2", "r") do f
        return f["optimisationState"]
    end
end
