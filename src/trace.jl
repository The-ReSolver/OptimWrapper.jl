# Definitions for the trace of the optimisation.

struct Trace{S<:OptimisationState}
    stateVector::Vector{S}
end
Trace(::Type{T}=FirstOrderOptimisationState) where {T} = Trace{T}(T[])

Base.length(trace::Trace) = length(trace.stateVector)
Base.getindex(trace::Trace, i) = trace.stateVector[i]
Base.lastindex(trace::Trace) = lastindex(trace.stateVector)
Base.eltype(::Trace{S}) where {S} = S

# NOTE: only works if trace is updated every iteration
Base.push!(trace::Trace{S}, state) where {S} = push!(trace.stateVector, convert(S, state, getFinalIteration(trace)))
Base.push!(trace::Trace{S}, state::S) where {S} = push!(trace.stateVector, state)

ifFirstIteration(trace) = length(trace) == 0
function getFinalIteration(trace::Trace)
    finalIteration = -1
    try
        finalIteration = trace[end].iteration
    catch
    end
    return finalIteration
end
