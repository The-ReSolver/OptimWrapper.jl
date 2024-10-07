@testset "Trace                         " begin
    trace1 = OptimWrapper.Trace(OptimWrapper.FirstOrderOptimisationState)
    trace2 = OptimWrapper.Trace(OptimWrapper.NelderMeadOptimisationState)

    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepSize = rand()
    stepType = rand(["expansion", "reflection", "outside contraction", "inside contraction", "shrink"])

    dummyState1 = DummyState(iter, value, gnorm, Dict("time"=>time, "Current step size"=>stepSize))
    dummyState2 = DummyState(iter, value, gnorm, Dict("time"=>time, "step_type"=>stepType))

    @test OptimWrapper.ifFirstIteration(trace1)
    @test OptimWrapper.ifFirstIteration(trace2)

    @test_nowarn push!(trace1, dummyState1, 5, 0.0, 0.0)
    @test_nowarn push!(trace2, dummyState2, 5, 0.0, 0.0)

    @test length(trace1) == length(trace2) == 1
    @test trace1[1] == OptimWrapper.FirstOrderOptimisationState(iter + 5, value, gnorm, time, stepSize, 0.0)
    @test trace2[1] == OptimWrapper.NelderMeadOptimisationState(iter + 5, value, gnorm, time, stepType, 0.0)

    @test !OptimWrapper.ifFirstIteration(trace1)
    @test !OptimWrapper.ifFirstIteration(trace2)

    push!(trace1, dummyState1, 5, 0.0, 0.0)
    push!(trace2, dummyState2, 5, 0.0, 0.0)

    @test length(trace1) == length(trace2) == 2
    @test trace1[2] == OptimWrapper.FirstOrderOptimisationState(iter + 5, value, gnorm, time, stepSize, 0.0)
    @test trace2[2] == OptimWrapper.NelderMeadOptimisationState(iter + 5, value, gnorm, time, stepType, 0.0)

    @test !OptimWrapper.ifFirstIteration(trace1)
    @test !OptimWrapper.ifFirstIteration(trace2)

    push!(trace1, trace1[1])
    push!(trace2, trace2[1])

    @test length(trace1) == length(trace2) == 3
    @test trace1[3] == OptimWrapper.FirstOrderOptimisationState(iter + 5, value, gnorm, time, stepSize, 0.0)
    @test trace2[3] == OptimWrapper.NelderMeadOptimisationState(iter + 5, value, gnorm, time, stepType, 0.0)

    @test eltype(trace1) == OptimWrapper.FirstOrderOptimisationState
    @test eltype(trace2) == OptimWrapper.NelderMeadOptimisationState

    push!(trace1, nothing)
    push!(trace2, nothing)

    @test length(trace1) == length(trace2) == 3
    @test trace1[3] == OptimWrapper.FirstOrderOptimisationState(iter + 5, value, gnorm, time, stepSize, 0.0)
    @test trace2[3] == OptimWrapper.NelderMeadOptimisationState(iter + 5, value, gnorm, time, stepType, 0.0)

    @test trace1.objectiveValue == [value, value, value]
    @test trace2.stepType == [stepType, stepType, stepType]
end
