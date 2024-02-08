using Test
using Random
using Printf

using OptimWrapper

struct DummyState
    iteration::Int
    value::Float64
    g_norm::Float64
    metadata::Dict
end

include("test_optimisationState.jl")
include("test_trace.jl")
