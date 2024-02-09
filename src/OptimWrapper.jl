module OptimWrapper

using Optim, Printf, Parameters, LineSearches

export LBFGS, ConjugateGradient, GradientDescent, NelderMead

export HagerZang, MoreThuente, BackTracking, StrongWolfe, Static
export InitialPrevious, InitialStatic, InitialHagerZhang, InitialQuadratic, InitialConstantChange

export OptOptions
export optimise!

include("optimisationState.jl")
include("trace.jl")
include("printing.jl")
include("options.jl")
include("output.jl")
include("callback.jl")
include("optimise.jl")

end
