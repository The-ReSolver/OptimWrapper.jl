@testset "Optimisation Read/Write       " begin
    path = "./tmp/"
    randIteration = rand(1:100)
    randValue = rand()
    randGradientNorm = rand()
    optimisationVariable = rand(Int64, rand(1:100))
    optimisationState = OptimWrapper.GenericOptimisationState(randIteration, randValue, randGradientNorm)
    parameter1 = "First parameters"
    parameter2 = 2.0
    parameter3 = true
    parameter4 = rand(ComplexF64, 5, 4, 3, 2)
    mkpath(path)

    OptimWrapper.initialiseOptimisationVariableFromFile(path, ::String, rest...) = Vector{Int64}(undef, filesize(path*"optVar")÷sizeof(Int64))

    try
        OptimWrapper.initialiseOptimisationDirectory(path, optimisationVariable, parameter1=parameter1, parameter2=parameter2, parameter3=parameter3, parameter4=parameter4)

        @test isfile(path*"parameters.jld2")
        @test isfile(path*"0/optVar")

        OptimWrapper.writeIteration(path*string(randIteration)*"/", optimisationVariable, optimisationState)

        @test isfile(path*string(randIteration)*"/optVar")
        @test isfile(path*string(randIteration)*"/state.jld2")

        parameters2 = OptimWrapper.readOptimisationParameters(path)
        optimisationVariable2, optimisationState2 = OptimWrapper.loadOptimisation(path, randIteration)

        @test optimisationVariable2 == optimisationVariable
        @test optimisationState2 == optimisationState
        @test parameters2["parameter1"] == parameter1
        @test parameters2["parameter2"] == parameter2
        @test parameters2["parameter3"] == parameter3
        @test parameters2["parameter4"] == parameter4
    finally
        rm("./tmp", recursive=true)
    end
end
