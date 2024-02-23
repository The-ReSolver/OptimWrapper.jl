# Definitions to read optimisation data from disc.

function loadOptimisation(path, iteration)
    parameters = readOptimisationParameters(path)
    optimisationVariable = initialiseOptimisationVariableFromFile(path*string(iteration)*"/", values(parameters)...)
    readOptimisationVariable!(optimisationVariable, path*string(iteration)*"/")
    optimisationState = tryToReadOptimisationState(path*string(iteration)*"/")
    return optimisationVariable, optimisationState
end

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

initialiseOptimisationVariableFromFile(path, parameters...) = Vector{Float64}(undef, filesize(path*"optVar")÷sizeof(Float64))

function readOptimisationVariable!(optimisationVariable, path)
    open(path*"optVar", "r") do f
        read!(f, parent(optimisationVariable))
    end
end

function tryToReadOptimisationState(path)
    local optimisationState
    try
        optimisationState = readOptimisationState(path)
    catch e
        throw(e)
        optimisationState = nothing
    end
    return optimisationState
end

function readOptimisationState(path)
    jldopen(path*"state.jld2", "r") do f
        return f["optimisationState"]
    end
end
