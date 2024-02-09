@testset "Options                       " begin
    @test OptimWrapper.OptOptions().trace isa OptimWrapper.Trace{OptimWrapper.FirstOrderOptimisationState}
    @test OptimWrapper.OptOptions(alg=NelderMead()).trace isa OptimWrapper.Trace{OptimWrapper.NelderMeadOptimisationState}

    @test !OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(), 0)
    @test !OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(), 1)
    @test OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(write=true), 0)
    @test OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(write=true), 1)
    @test !OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(write=true, n_it_write=2), 1)
    @test OptimWrapper.ifWriteIteration(OptimWrapper.OptOptions(write=true, n_it_write=2), 2)

    @test OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(), 0)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(verbose=false), 0)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(n_it_print=2), 1)
    @test OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(n_it_print=2), 2)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(verbose=false, n_it_print=2), 1)

    @test !OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(), rand(0:9999))
    @test OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(update_frequency_every=1), 0)
    @test OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(update_frequency_every=1), 1)
    @test OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(update_frequency_every=2), 0)
    @test !OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(update_frequency_every=2), 1)
    @test OptimWrapper.ifUpdateFrequency(OptimWrapper.OptOptions(update_frequency_every=2), 2)
end