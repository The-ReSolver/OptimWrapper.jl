@testset "Generic Optimisation State    " begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = NaN
    time = rand()
    period = abs(rand())

    dummyState = DummyState(iter, value, gnorm, Dict("time"=>time))
    state = OptimWrapper.GenericOptimisationState(iter, value, time, period)

    @test repr(OptimWrapper.GenericOptimisationState()) == "|"*@sprintf("%10d", 1)*"   |  "*@sprintf("%.5e", 1)*"  |  "*@sprintf("%.5e", 1)*"  |    "*@sprintf("%8.4f", 1)*"   |"
    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |  "*@sprintf("%.5e", time)*"  |  "*@sprintf("%.5e", value)*"  |    "*@sprintf("%8.4f", period)*"   |"
    @test convert(OptimWrapper.GenericOptimisationState, dummyState, 5, 0.0, period) == OptimWrapper.GenericOptimisationState(5 + iter, value, time, period)
end

@testset "First Order Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepSize = rand()
    period = abs(rand())

    dummyState = DummyState(iter, value, gnorm, Dict("time"=>time, "Current step size"=>stepSize))
    state = OptimWrapper.FirstOrderOptimisationState(iter, value, gnorm, time, stepSize, period)

    @test repr(OptimWrapper.FirstOrderOptimisationState()) == "|"*@sprintf("%10d", 1)*"   |  "*@sprintf("%.5e", 1)*"  |   "*@sprintf("%.2e", 1)*"  |  "*@sprintf("%.5e", 1)*"  |  "*@sprintf("%.5e", 1)*"  |    "*@sprintf("%8.4f", 1)*"   |"
    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |  "*@sprintf("%.5e", time)*"  |   "*@sprintf("%.2e", stepSize)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |    "*@sprintf("%8.4f", period)*"   |"
    @test convert(OptimWrapper.FirstOrderOptimisationState, dummyState, 5, 0.0, period) == OptimWrapper.FirstOrderOptimisationState(5 + iter, value, gnorm, time, stepSize, period)
end

@testset "Nelder-Mead Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepType = rand(["expansion", "reflection", "outside contraction", "inside contraction", "shrink"])
    period = abs(rand())

    dummyState = DummyState(iter, value, gnorm, Dict("time"=>time, "step_type"=>stepType))
    state = OptimWrapper.NelderMeadOptimisationState(iter, value, gnorm, time, stepType, period)

    @test repr(OptimWrapper.NelderMeadOptimisationState()) == "|"*@sprintf("%10d", 1)*"   |  "*@sprintf("%.5e", 1)*"  |   "*@sprintf("%-20s", "")*"  |  "*@sprintf("%.5e", 1)*"  |  "*@sprintf("%.5e", 1)*"  |    "*@sprintf("%8.4f", 1)*"   |"
    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |  "*@sprintf("%.5e", time)*"  |   "*@sprintf("%-20s", stepType)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |    "*@sprintf("%8.4f", period)*"   |"
    @test convert(OptimWrapper.NelderMeadOptimisationState, dummyState, 5, 0.0, period) == OptimWrapper.NelderMeadOptimisationState(5 + iter, value, gnorm, time, stepType, period)
end
