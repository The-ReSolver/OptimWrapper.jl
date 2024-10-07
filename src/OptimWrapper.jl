module OptimWrapper

using Optim, Printf, Parameters, LineSearches, JLD2, OrderedCollections, LinearAlgebra

export LBFGS, ConjugateGradient, GradientDescent, NelderMead, MyGradientDescent

export HagerZang, MoreThuente, BackTracking, StrongWolfe, Static
export InitialPrevious, InitialStatic, InitialHagerZhang, InitialQuadratic, InitialConstantChange

export Trace
export OptOptions
export initialiseOptimisationDirectory
export loadOptimisation
export optimise!
export gd!

include("optimisationState.jl")
include("trace.jl")
include("printing.jl")
include("options.jl")
include("gradientdescent.jl")
include("callback.jl")
include("optimise.jl")

end
