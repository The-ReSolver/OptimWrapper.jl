# Definitions for a simple gradient descent as a fall-back when Optim.jl routines throw a little fit.

function gd!(a, objective, step_size::Float64; rtol::Float64=1e-12, maxiter::Real=Inf, verbose::Bool=true, n_it_print::Int=1, trace::Trace=Trace(), print_io::IO=stdout, callback=x->false)
    R = objective(a)[2]
    iter = getFinalIteration(trace)
    push!(trace.stateVector, convert(GradientDescentState, iter, R, norm(objective.out)))
    verbose ? printHeader(io, GradientDescentState) : nothing
    verbose && iter % n_it_print == 0 ? println(print_io, trace[end]) : nothing
    callback(a, iter) ? return a : nothing
    while R > rtol && iter < maxiter
        iter += 1
        update!(a, objective.out, step_size)
        R = objective(a)[2]
        push!(trace.stateVector, convert(GradientDescentState, iter, R, norm(objective.out)))
        verbose && iter % n_it_print == 0 ? println(print_io, trace[end]) : nothing
        callback(a, iter) ? break : nothing
    end
    return a
end

update!(a, grad, step_size) = (a .-= step_size.*grad; return a)
