# Definitions of the optimisation state for each iteration.

abstract type OptimisationState end

struct FirstOrderOptimisationState <: OptimisationState
    objectiveValue::Float64
    gradientNorm::Float64
    iteration::Int
    frequency::Float64
    time::Float64
    stepSize::Float64
end
Base.show(io::IO, x::FirstOrderOptimisationState) = @printf io "|%10d   |   %5.2e  |  %5.5e  |  %5.5e  |  %5.5e  |" x.iteration x.stepSize x.frequency x.objectiveValue x.gradientNorm

struct NelderMeadOptimisationState <: OptimisationState end
