@testset "Optimisation Read/Write       " begin
    # test directory initialisation
    # test iteration writing

    path = "./tmp/"
    optimisationVariable = rand(rand([Float64, ComplexF64]), [rand(1:5) for _ in 1:rand(1:3)]...)
    parameter1 = "First parameters"
    parameter2 = 2.0
    parameter3 = true
    parameter4 = rand(ComplexF64, 5, 4, 3, 2)
    mkpath(path)

    OptimWrapper.initialiseOptimisationDirectory(path, optimisationVariable, parameter1=parameter1, parameter2=parameter2, parameter3=parameter3, parameter4=parameter4)

    @test isfile("./tmp/parameters.jld2")
    @test isfile("./tmp/0/optVar")

    # tear down directory
    rm("./tmp", recursive=true)
end