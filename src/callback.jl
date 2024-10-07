# This file contains the definitions to create a default callback method
# extending the default behaviour of Optim.jl.

struct Callback{X, C, OPTIMIZER, S, CB}
    optimisationVariable::X
    cache::C
    options::OptOptions{OPTIMIZER, S, CB}
    ifKeepZero::Bool
    startIteration::Int
    startTime::Float64

    function Callback(optimisationVariable, cache, options::OptOptions{OPTIMIZER, S, CB}) where {OPTIMIZER, S, CB}
        ifKeepZero = ifFirstIteration(options.trace)
        startIteration = getStartIteration(options.trace)
        startTime = getStartTime(options.trace)
        new{typeof(optimisationVariable), typeof(cache), OPTIMIZER, S, CB}(optimisationVariable, cache, options, ifKeepZero, startIteration, startTime)
    end
end

function getStartTime(trace::Trace)
    startTime = 0.0
    try
        startTime = trace[end].time
    catch
    end
    return startTime
end

function (f::Callback)(state)
    updateOptimisationVariable!(f.optimisationVariable, state)
    ifUpdateTrace(state.iteration, f.ifKeepZero) ? push!(f.options.trace, state, f.startIteration, f.startTime, getPeriod(f.optimisationVariable)) : nothing
    ifPrintIteration(f.options, getFinalIteration(f.options.trace)) ? println(f.options.io, f.options.trace[end]) : nothing
    return checkResidualConvergence(f.options, f.options.trace[end].objectiveValue) || f.options.callback(f)
end

updateOptimisationVariable!(optimisationVariable, optimState::Optim.OptimizationState{<:Any, <:Optim.NelderMead}) = (optimisationVariable .= optimState.metadata["centroid"]; return optimisationVariable)
updateOptimisationVariable!(optimisationVariable, optimState) = (optimisationVariable .= optimState.metadata["x"]; return optimisationVariable)
ifUpdateTrace(iteration, ifKeepZero) = iteration != 0 || ifKeepZero

getPeriod(::Any) = 0.0
