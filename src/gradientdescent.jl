# Definitions for a simple gradient descent as a fall-back when Optim.jl routines throw a little fit.

function gd!(a, objective, step_size::Float64; rtol::Float64=1e-12, maxiter::Real=Inf, verbose::Bool=true, n_it_print::Int=1, trace::Trace=Trace(GradientDescentState), print_io::IO=stdout, callback=(x,i)->false)
    grad = similar(a)
    verbose ? printHeader(print_io, GradientDescentState) : nothing
    iter = getFinalIteration(trace)
    if !isempty(trace.stateVector)
        maxiter = maxiter + trace[end].iteration
        verbose ? println(print_io, trace[end]) : nothing
    end
    R = objective(a)[1]
    while R > rtol && iter < maxiter
        iter += 1
        R = objective(grad, a)[1]
        push!(trace.stateVector, convert(GradientDescentState, iter, R, norm(grad)))
        verbose && iter % n_it_print == 0 ? println(print_io, trace[end]) : nothing
        callback(a, iter) ? break : nothing
        update!(a, grad, step_size)
    end
    return a, trace
end

update!(a, grad, step_size) = (a .-= step_size.*grad; return a)
