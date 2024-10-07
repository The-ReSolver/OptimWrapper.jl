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
    x, trace = gd!([0.0, 0.0], Rosenbrok, 1e-3, verbose=false, maxiter=10)
    gd!(x, Rosenbrok, 1e-3, verbose=false, trace=trace)

    @test x ≈ [1.0, 1.0] rtol=1e-5
    @test trace.iteration == collect(0:trace[end].iteration)
end