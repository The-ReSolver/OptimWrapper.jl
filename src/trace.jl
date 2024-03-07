# Definitions for the trace of the optimisation.

struct Trace{S<:AbstractOptimisationState}
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
Base.push!(::Trace, ::Nothing) = nothing

ifFirstIteration(trace) = length(trace) == 0
function getFinalIteration(trace::Trace)
    finalIteration = -1
    try
        finalIteration = trace[end].iteration
    catch
    end
    return finalIteration
end

function Base.getproperty(trace::Trace, field::Symbol)
    if field === :stateVector
        return getfield(trace, :stateVector)
    else
        T = typeof(getfield(trace[1], field))
        out = Vector{T}(undef, length(trace))
        for i in 1:length(trace)
            out[i] = getfield(trace[i], field)
        end
        return out
    end
end
