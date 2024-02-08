# Definitions for the trace of the optimisation.

struct Trace{S<:OptimisationState}
    stateVector::Vector{S}
end
Trace(::Type{T}=FirstOrderOptimisationState) where {T} = Trace{T}(T[])

# NOTE: only works if trace is updated every iteration
Base.push!(trace::Trace{S}, state) where {S} = push!(trace.stateVector, convert(S, state, getFinalIteration(trace)))

function getFinalIteration(trace::Trace)
    finalIteration = -1
    try
        finalIteration = trace.stateVector[end].iteration
    catch
    end
    return finalIteration
end
