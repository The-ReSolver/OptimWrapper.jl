# This file contains the definitions to create a default callback method
# extending the default behaviour of Optim.jl.

struct Callback{X, C, OPTIMIZER, S, CB, R, F}
    optimisationVariable::X
    cache::C
    options::OptOptions{OPTIMIZER, S, CB, R, F}
    ifKeepZero::Bool

    function Callback(optimisationVariable, cache, options::OptOptions{OPTIMIZER, S, CB, R, F}) where {OPTIMIZER, S, CB, R, F}
        ifKeepZero = ifFirstIteration(options.trace)
        new{typeof(optimisationVariable), typeof(cache), OPTIMIZER, S, CB, R, F}(optimisationVariable, cache, options, ifKeepZero)
    end
end

function (f::Callback)(state)
    ifUpdateTrace(state.iteration, f.ifKeepZero) ? push!(f.options.trace, state) : nothing
    ifWriteIteration(f.options, getFinalIteration(f.options.trace)) ? writeIteration() : nothing
    ifPrintIteration(f.options, getFinalIteration(f.options.trace)) ? (println(f.options.io, f.options.trace[end]); flush(f.options.io)) : nothing
    ifUpdateFrequency(f.options, getFinalIteration(f.options.trace)) ? updateFrequency(f.cache) : nothing
    return f.options.callback(state)
end

ifUpdateTrace(iteration, ifKeepZero) = iteration != 0 || ifKeepZero
