# Definitions for the top-level optimsiation methods.

optimise!(optimisationVariable, objective, options=OptOptions()) = _optimise!(optimisationVariable, objective, options, genOptimOptions(options, Callback(optimisationVariable, objective, options)))
function optimise!(objective, options=OptOptions())
    optimisationVariable, optimisationState = loadOptimisationState(options.write_path, options.restart)
    push!(options.trace, optimisationState)
    optimise!(optimisationVariable, objective, options)
end

_optimise!(optimisationVariable, objective, options::OptOptions, optimOptions) = _optimise!(optimisationVariable, objective, options.alg, options, optimOptions)
_optimise!(optimisationVariable, objective, options::OptOptions{<:Optim.FirstOrderOptimizer}, optimOptions) = _optimise!(optimisationVariable, Optim.only_fg!(objective), options.alg, options, optimOptions)
_optimise!(optimisationVariable, objective, options::OptOptions{<:Optim.NelderMead}, optimOptions) = _optimise!(optimisationVariable, objective, Optim.NelderMead(), options, optimOptions)

function _optimise!(optimisationVariable, objective, algorithm, options::OptOptions{<:Any, S}, optimOptions) where {S}
    options.verbose ? printHeader(options.io, S) : nothing
    optimize(objective, optimisationVariable, algorithm, optimOptions)
end
