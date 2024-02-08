# Definitions of the optimisation state for each iteration.

abstract type OptimisationState end

struct FirstOrderOptimisationState <: OptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepSize::Float64
end
Base.show(io::IO, x::FirstOrderOptimisationState) = @printf io "|%10d   |   %5.2e  |  %5.5e  |  %5.5e  |" x.iteration x.stepSize x.objectiveValue x.gradientNorm
Base.convert(::Type{FirstOrderOptimisationState}, state::Optim.OptimizationState{<:Any, <:Optim.FirstOrderOptimizer}, prevIteration) = FirstOrderOptimisationState(state.value, state.g_norm, prevIteration + 1, state.metadata["time"], state.metadata["Current step size"])

struct NelderMeadOptimisationState <: OptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepType::String
end
Base.show(io::IO, x::NelderMeadOptimisationState) = @printf io "|%10d   |   %-20s  |  %5.5e  |  %5.5e  |" x.iteration x.stepType x.objectiveValue x.gradientNorm
Base.convert(::Type{FirstOrderOptimisationState}, state::Optim.OptimizationState{<:Any, <:Optim.FirstOrderOptimizer}, prevIteration) = FirstOrderOptimisationState(state.value, state.g_norm, prevIteration + 1, state.metadata["time"], state.metadata["step_type"])
