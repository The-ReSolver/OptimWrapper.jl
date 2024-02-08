@testset "First Order Optimisation State" begin
    # initialise random variables
    value = rand()
    gnorm = rand()
    iter = rand(0:99999999)
    time = rand()
    stepsize = rand()

    state = OptimWrapper.FirstOrderOptimisationState(value, gnorm, iter, time, stepsize)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%.2e", stepsize)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
end
