@testset "Callback                      " begin
    optimisationVariable = zeros(5, 5)
    cache = [zeros(5, 5) for _ in 1:3]
    options1 = OptimWrapper.OptOptions(verbose=false)
    options2 = OptimWrapper.OptOptions(alg=NelderMead(), verbose=false)

    callback1 = OptimWrapper.Callback(optimisationVariable, cache, options1)
    callback2 = OptimWrapper.Callback(optimisationVariable, cache, options2)

    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepSize = rand()
    stepType = rand(["expansion", "reflection", "outside contraction", "inside contraction", "shrink"])

    dummyState1 = DummyState(iter, value, gnorm, Dict("time"=>time, "Current step size"=>stepSize, "x"=>rand(5, 5)))
    dummyState2 = DummyState(iter, value, gnorm, Dict("time"=>time, "step_type"=>stepType, "x"=>rand(5, 5)))

    @test_nowarn callback1(dummyState1)
    @test_nowarn callback2(dummyState2)

    @test length(options1.trace) == 1
    @test options1.trace[1] == OptimWrapper.FirstOrderOptimisationState(0, value, gnorm, time, stepSize)
    @test options2.trace[1] == OptimWrapper.NelderMeadOptimisationState(0, value, gnorm, time, stepType)

    @test_nowarn callback1(dummyState1)
    @test_nowarn callback2(dummyState2)

    @test length(options1.trace) == 2
    @test options1.trace[2] == OptimWrapper.FirstOrderOptimisationState(1, value, gnorm, time, stepSize)
    @test options2.trace[2] == OptimWrapper.NelderMeadOptimisationState(1, value, gnorm, time, stepType)
end