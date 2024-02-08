@testset "First Order Optimisation State" begin
    # initialise random variables
    value = rand()
    gnorm = rand()
    iter = rand(0:99999999)
    freq = rand()
    time = rand()
    stepsize = rand()

    state = OptimWrapper.FirstOrderOptimisationState(value, gnorm, iter, freq, time, stepsize)

    @test repr(state) == "|"*@sprintf("%10d", iter)*"   |   "*@sprintf("%.2e", stepsize)*"  |  "*@sprintf("%.5e", freq)*"  |  "*@sprintf("%.5e", value)*"  |  "*@sprintf("%.5e", gnorm)*"  |"
end