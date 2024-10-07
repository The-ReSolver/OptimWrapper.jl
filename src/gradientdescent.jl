# Definitions for a simple gradient descent as a fall-back when Optim.jl routines throw a little fit.

# TODO: add period to trace and printing

struct MyGradientDescent <: Optim.AbstractOptimizer end

function gd!(a, objective, step_size, options::OptOptions)
    grad = similar(a)
    options.verbose ? printHeader(options.io, GradientDescentState) : nothing
    iter = getFinalIteration(options.trace)
    maxiter = options.maxiter
    if !isempty(options.trace.stateVector)
        i = 0
        options.verbose ? println(options.io, options.trace[end]) : nothing
    else
        i = -1
    end
    R = objective(a)[1]
    while R > options.res_tol && i < maxiter
        i += 1
        iter += 1
        R = objective(grad, a)[1]
        push!(options.trace.stateVector, convert(GradientDescentState, iter, R, norm(grad)))
        options.verbose && iter % options.n_it_print == 0 ? println(options.io, options.trace[end]) : nothing
        options.callback((a, iter)) ? break : nothing
        update!(a, grad, step_size)
    end
    return a, options.trace
end

update!(a, grad, step_size) = (a .-= step_size.*grad; return a)
