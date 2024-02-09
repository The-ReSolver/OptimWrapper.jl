# This file contains the definition of the optimisation options that can be
# passed to modify the default behaviour of the wrapper.

@with_kw struct OptOptions{OPTIMIZER<:Optim.AbstractOptimizer, CB, F<:Union{Val{Inf}, Int}}
    # general options
    maxiter::Int = typemax(Int)
    alg::OPTIMIZER = LBFGS()
    trace::Trace = Trace(getOptimisationStateType(alg))
    callback::CB = x->false; @assert !isempty(methods(callback))
    update_frequency_every::F = Val(Inf)

    # optimisation printing
    verbose::Bool = true
    n_it_print::Int = 1
    io::IO = stdout

    # optimisation output
    write::Bool = false
    n_it_write::Int = 1
end

function getOptimisationStateType(algorithm)
    if algorithm isa Optim.FirstOrderOptimizer
        return FirstOrderOptimisationState
    elseif algorithm isa Optim.NelderMead
        return NelderMeadOptimisationState
    else
        throw(ArgumentError("Algorithm does not have a defined state"))
    end
end

ifWriteIteration(options, iteration) = options.write && iteration % options.n_it_write == 0
ifPrintIteration(options, iteration) = options.verbose && iteration % options.n_it_print == 0
ifUpdateFrequency(options::OptOptions{<:Any, <:Any, Val{Inf}}, ::Any) = false
ifUpdateFrequency(options::OptOptions{<:Any, <:Any, Int}, iteration) = iteration % options.update_frequency_every == 0
