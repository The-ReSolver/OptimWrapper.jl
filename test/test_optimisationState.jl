@testset "First Order Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepsize = rand()

    state = OptimWrapper.FirstOrderOptimisationState(iter, value, gnorm, time, stepsize)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%.2e", stepsize)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
end

@testset "Nelder-Mead Optimisation State" begin
    # initialise rndom variables
    iter = rand(0:99999999)
    value = rand()
    gnorm = rand()
    time = rand()
    stepType = rand(["expansion", "reflection", "outside contraction", "inside contraction", "shrink"])

    state = OptimWrapper.NelderMeadOptimisationState(iter, value, gnorm, time, stepType)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%-20s", stepType)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
end
