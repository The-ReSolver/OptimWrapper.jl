# This file contains the definition of the optimisation options that can be
# passed to modify the default behaviour of the wrapper.

@with_kw struct OptOptions{OPTIMIZER, CB}
    # general options
    maxiter::Int = typemax(Int)
    alg::OPTIMIZER = LBFGS()
    trace::Trace = Trace()
    callback::CB = x->false; @assert !isempty(methods(callback))

    # optimisation printing
    verbose::Bool = true
    n_it_print::Int = 1
    io::IO = stdout

    # optimisation output
    write::Bool = false
    n_it_write::Int = 1
end
