# Definitions to read optimisation data from disc.

function loadOptimisationState(path, iteration)
    parameters = readOptimisationParameters(path*"parameters.jld2")
    optimisationVariable = readOptimisationVariable!(path*string(iteration))
    optimisationState = tryToReadOptimisationState(path*string(iteration))
    return optimisationVariable, optimisationState, parameters
end

function readOptimisationParameters(path)
    parameters = jldopen(path*"parameters.jld2", "r") do f
        return unpackParametersFile!(f)
    end
    return parameters
end

function unpackParametersFile!(fileIO)
    parameters = Dict{String, Any}()
    for key in keys(fileIO)
        merge!(parameters, Dict(key=>fileIO[key]))
    end
    return parameters
end

# TODO: need fallback that assumes optimisation variable is a real vector
function readOptimisationVariable!(path)
    optimisationVariable = initialiseOptimisationVariableFromFile(path*"optVar")
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
    optimisationState = open(path*"state.jld2", "r") do f
        return f["optimisationState"]
    end
    return optimisationState
end
