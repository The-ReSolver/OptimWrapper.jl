# Definitions of the optimisation state for each iteration.

abstract type AbstractOptimisationState end

# TODO: there's gotta be a better way? Look at the data flow of the optimisation initialisation.
(f::Type{<:AbstractOptimisationState})() = f((one(f.types[i]) for i in eachindex(fieldnames(f)))...)


struct GenericOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    time::Float64
end
Base.show(io::IO, x::GenericOptimisationState) = @printf io "|%10d   |  %5.5e  |  %5.5e  |" x.iteration x.time x.objectiveValue
Base.convert(::Type{GenericOptimisationState}, state, prevIteration) = GenericOptimisationState(prevIteration + 1, state.value, state.metadata["time"])


struct FirstOrderOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepSize::Float64
end
Base.show(io::IO, x::FirstOrderOptimisationState) = @printf io "|%10d   |  %5.5e  |   %5.2e  |  %5.5e  |  %5.5e  |" x.iteration x.time x.stepSize x.objectiveValue x.gradientNorm
Base.convert(::Type{FirstOrderOptimisationState}, state, prevIteration) = FirstOrderOptimisationState(prevIteration + 1, state.value, state.g_norm, state.metadata["time"], state.metadata["Current step size"])


struct NelderMeadOptimisationState <: AbstractOptimisationState
    iteration::Int
    objectiveValue::Float64
    gradientNorm::Float64
    time::Float64
    stepType::String
end
Base.show(io::IO, x::NelderMeadOptimisationState) = @printf io "|%10d   |  %5.5e  |   %-20s  |  %5.5e  |  %5.5e  |" x.iteration x.time x.stepType x.objectiveValue x.gradientNorm
Base.convert(::Type{NelderMeadOptimisationState}, state, prevIteration) = NelderMeadOptimisationState(prevIteration + 1, state.value, state.g_norm, state.metadata["time"], state.metadata["step_type"])
