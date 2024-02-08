@testset "First Order Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepSize = rand()

    dummyState = DummyState(iter, value, gnorm, Dict("time"=>time, "Current step size"=>stepSize))
    state = OptimWrapper.FirstOrderOptimisationState(iter, value, gnorm, time, stepSize)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%.2e", stepSize)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
    @test convert(OptimWrapper.FirstOrderOptimisationState, dummyState, 5) == OptimWrapper.FirstOrderOptimisationState(6, value, gnorm, time, stepSize)
end

@testset "Nelder-Mead Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepType = rand(["expansion", "reflection", "outside contraction", "inside contraction", "shrink"])

    dummyState = DummyState(iter, value, gnorm, Dict("time"=>time, "step_type"=>stepType))
    state = OptimWrapper.NelderMeadOptimisationState(iter, value, gnorm, time, stepType)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%-20s", stepType)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
    @test convert(OptimWrapper.NelderMeadOptimisationState, dummyState, 5) == OptimWrapper.NelderMeadOptimisationState(6, value, gnorm, time, stepType)
end
