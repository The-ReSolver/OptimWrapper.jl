# This file contains the definition of the optimisation options that can be
# passed to modify the default behaviour of the wrapper.

@with_kw struct OptOptions{OPTIMIZER<:Optim.AbstractOptimizer, S, CB}
    maxiter::Int = typemax(Int)                                  # maximum number of iterations
    alg::OPTIMIZER = LBFGS()                                     # optimisation algorithm choice
    res_tol::Float64 = 1e-12                                     # residual tolerance used to determine if the solution is converged
    g_tol::Float64 = 0.0                                         # gradient tolerance
    x_tol::Float64 = 0.0                                         # optimisation variable tolerance
    f_tol::Float64 = 0.0                                         # objective function tolerance
    f_calls_limit::Int = 0                                       # limit on the number of calls to the objective function
    g_calls_limit::Int = 0                                       # limit on the number of calls to the gradient function
    allow_f_increases::Bool = false                              # allow the objective to increase between iterations
    trace_simplex::Bool = false                                  # whether to include the simplex in the trace (only for Nelder-Mead optimisation)
    time_limit::Float64 = NaN                                    # time limit on the optimisation (in seconds)
    trace::Trace{S} = Trace(getOptimisationStateType(alg))       # trace to keep track of the top-level optimisation results
    callback::CB = x->false; @assert !isempty(methods(callback)) # user specified callback function to be executed every iteration
    verbose::Bool = true                                         # whether to print the state of the optimisation at each iteration
    n_it_print::Int = 1                                          # number of iterations between printing the state of the optimisation
    io::IO = stdout                                              # IO stream to print the state to
    step_size::Float64 = 1e-3; @assert step_size > 0             # step size for the custom gradient descent algorith
end

function getOptimisationStateType(algorithm)
    if algorithm isa Optim.FirstOrderOptimizer
        return FirstOrderOptimisationState
    elseif algorithm isa Optim.NelderMead
        return NelderMeadOptimisationState
    else
        return GenericOptimisationState
    end
end

ifPrintIteration(options, iteration) = options.verbose && iteration % options.n_it_print == 0
checkResidualConvergence(options::OptOptions, value) = value < options.res_tol

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
