@testset "Gradient Descent              " begin
    # define rosenbrock function
    function Rosenbrok(grad, x)
        grad[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
        grad[2] = 200.0 * (x[2] - x[1]^2)
        F = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
        return F
    end
    Rosenbrok(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2

    # perform optimisation
    x, trace = optimise!([0.0, 0.0], Rosenbrok, OptOptions(step_size=1e-3, verbose=false, maxiter=10, alg=MyGradientDescent()))
    optimise!(x, Rosenbrok, OptOptions(step_size=1e-3, verbose=false, trace=trace, alg=MyGradientDescent()))

    @test x ≈ [1.0, 1.0] rtol=1e-5
    @test trace.iteration == collect(0:trace[end].iteration)
end
