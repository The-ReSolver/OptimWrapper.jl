# This file contains the definitions to create a default callback method
# extending the default behaviour of Optim.jl.

struct Callback{X, C, OPTIMIZER, S, CB, R, F, RM}
    optimisationVariable::X
    cache::C
    options::OptOptions{OPTIMIZER, S, CB, R, F, RM}
    ifKeepZero::Bool

    function Callback(optimisationVariable, cache, options::OptOptions{OPTIMIZER, S, CB, R, F, RM}) where {OPTIMIZER, S, CB, R, F, RM}
        ifKeepZero = ifFirstIteration(options.trace)
        new{typeof(optimisationVariable), typeof(cache), OPTIMIZER, S, CB, R, F, RM}(optimisationVariable, cache, options, ifKeepZero)
    end
end

function (f::Callback)(state)
    updateOptimisationVariable!(f.optimisationVariable, state)
    ifUpdateTrace(state.iteration, f.ifKeepZero) ? push!(f.options.trace, state) : nothing
    ifWriteIteration(f.options, getFinalIteration(f.options.trace)) ? writeIteration(f.options.write_path, f.optimisationVariable, f.options.trace[end]) : nothing
    ifPrintIteration(f.options, getFinalIteration(f.options.trace)) ? (println(f.options.io, f.options.trace[end]); flush(f.options.io)) : nothing
    ifUpdateFrequency(f.options, getFinalIteration(f.options.trace)) ? updateFrequency(f.cache) : nothing
    return f.options.callback(state)
end

updateOptimisationVariable!(optimisationVariable, optimState::Optim.OptimizationState{<:Any, <:Optim.NelderMead}) = (optimisationVariable .= optimState.metadata["centroid"]; return optimisationVariable)
updateOptimisationVariable!(optimisationVariable, optimState) = (optimisationVariable .= optimState.metadata["x"]; return optimisationVariable)
ifUpdateTrace(iteration, ifKeepZero) = iteration != 0 || ifKeepZero
