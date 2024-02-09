# This file contains the definition of the optimisation options that can be
# passed to modify the default behaviour of the wrapper.

@with_kw struct OptOptions{OPTIMIZER<:Optim.AbstractOptimizer, S, CB, F<:Union{Val{Inf}, Int}}
    # general options
    maxiter::Int = typemax(Int)
    alg::OPTIMIZER = LBFGS()
    g_tol::Float64 = 1e-12
    x_tol::Float64 = 0.0
    f_tol::Float64 = 0.0
    f_calls_limit::Int = 0
    g_calls_limit::Int = 0
    allow_f_increases::Bool = false
    trace_simplex::Bool = false
    time_limit::Float64 = NaN
    trace::Trace{S} = Trace(getOptimisationStateType(alg))
    callback::CB = x->false; @assert !isempty(methods(callback))
    update_frequency_every::F = Val(Inf)

    # optimisation printing
    verbose::Bool = true
    n_it_print::Int = 1
    io::IO = stdout

    # optimisation output
    write::Bool = false
    n_it_write::Int = 1
    # TODO: output mode just for trace
end

function getOptimisationStateType(algorithm)
    if algorithm isa Optim.FirstOrderOptimizer
        return FirstOrderOptimisationState
    elseif algorithm isa Optim.NelderMead
        return NelderMeadOptimisationState
    else
        return GenericOptimistionState
    end
end

ifWriteIteration(options, iteration) = options.write && iteration % options.n_it_write == 0
ifPrintIteration(options, iteration) = options.verbose && iteration % options.n_it_print == 0
ifUpdateFrequency(options::OptOptions{<:Any, <:Any, <:Any, Val{Inf}}, ::Any) = false
ifUpdateFrequency(options::OptOptions{<:Any, <:Any, <:Any, Int}, iteration) = iteration % options.update_frequency_every == 0

genOptimOptions(options, callback) = Optim.Options( g_tol=options.g_tol,
                                                    x_tol=options.x_tol,
                                                    f_tol=options.f_tol,
                                                    f_calls_limit=options.f_calls_limit,
                                                    g_calls_limit=options.g_calls_limit,
                                                    trace_simplex=options.trace_simplex,
                                                    allow_f_increases=options.allow_f_increases,
                                                    iterations=options.maxiter,
                                                    show_trace=false,
                                                    extended_trace=true,
                                                    show_every=1,
                                                    time_limit=options.time_limit,
                                                    store_trace=false,
                                                    callback=callback)
