# Definitions of the optimisation state for each iteration.

abstract type AbstractOptimisationState end

(f::Type{<:AbstractOptimisationState})() = f((one(f.types[i]) for i in eachindex(fieldnames(f)))...)
iteration(optimisationState::AbstractOptimisationState) = optimisationState.iteration


struct GenericOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    time::Float64
    period::Float64
end
Base.show(io::IO, x::GenericOptimisationState) = (@printf io "|%10d   |  %5.5e  |  %5.5e  |    %8.4f   |" x.iteration x.time x.objectiveValue x.period; flush(io))
Base.convert(::Type{GenericOptimisationState}, state, startIteration, startTime, period) = GenericOptimisationState(startIteration + state.iteration, state.value, startTime + state.metadata["time"], period)


struct FirstOrderOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepSize::Float64
    period::Float64
end
Base.show(io::IO, x::FirstOrderOptimisationState) = (@printf io "|%10d   |  %5.5e  |   %5.2e  |  %5.5e  |  %5.5e  |    %8.4f   |" x.iteration x.time x.stepSize x.objectiveValue x.gradientNorm x.period; flush(io))
Base.convert(::Type{FirstOrderOptimisationState}, state, startIteration, startTime, period) = FirstOrderOptimisationState(startIteration + state.iteration, state.value, state.g_norm, startTime + state.metadata["time"], state.metadata["Current step size"], period)


struct NelderMeadOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepType::String
    period::Float64
end
Base.show(io::IO, x::NelderMeadOptimisationState) = (@printf io "|%10d   |  %5.5e  |   %-20s  |  %5.5e  |  %5.5e  |    %8.4f   |" x.iteration x.time x.stepType x.objectiveValue x.gradientNorm x.period; flush(io))
Base.convert(::Type{NelderMeadOptimisationState}, state, startIteration, startTime, period) = NelderMeadOptimisationState(startIteration + state.iteration, state.value, state.g_norm, startTime + state.metadata["time"], state.metadata["step_type"], period)

struct GradientDescentState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    period::Float64
end
Base.show(io::IO, x::GradientDescentState) = (@printf io "|%10d   |  %5.5e  |  %5.5e  |    %8.4f   |" x.iteration x.objectiveValue x.gradientNorm x.period; flush(io))
Base.convert(::Type{GradientDescentState}, iteration, objectiveValue, gradientNorm, period) = GradientDescentState(iteration, objectiveValue, gradientNorm, period)
