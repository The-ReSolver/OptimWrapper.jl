# Definitions for writing optimisation data to disc.

function initialiseOptimisationDirectory(path, optimisationVariable; parameters...)
    writeOptimisationParameters(path; parameters...)
    writeIteration(path*"0/", optimisationVariable)
end

function writeOptimisationParameters(path; parameters...)
    jldopen(path*"parameters.jld2", "w") do f
        for (key, value) in parameters
            f[string(key)] = value
        end
    end
end

function writeIteration(path, optimisationVariable, optimisationState)
    writeVariableTo(path, optimisationVariable)
    writeOptimisationState(path, optimisationState)
end
writeIteration(path, optimisationVariable) = writeVariableTo(path, optimisationVariable)

function writeVariableTo(path, optimisationVariable)
    createIterationDirectory(path)
    writeOptimisationVariable(path, optimisationVariable)
end

createIterationDirectory(path) = isdir(path) ? nothing : mkdir(path)

function writeOptimisationVariable(path, optimisationVariable)
    open(path*"optVar", "w") do f
        write(f, parent(optimisationVariable))
    end
end

function writeOptimisationState(path, optimisationState)
    jldopen(path*"state.jld2", "w") do f
        f["optimisationState"] = optimisationState
    end
end
