@testset "Options                       " begin
    @test OptimWrapper.OptOptions().trace isa OptimWrapper.Trace{OptimWrapper.FirstOrderOptimisationState}
    @test OptimWrapper.OptOptions(alg=NelderMead()).trace isa OptimWrapper.Trace{OptimWrapper.NelderMeadOptimisationState}

    @test OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(), 0)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(verbose=false), 0)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(n_it_print=2), 1)
    @test OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(n_it_print=2), 2)
    @test !OptimWrapper.ifPrintIteration(OptimWrapper.OptOptions(verbose=false, n_it_print=2), 1)
end
