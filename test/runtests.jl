using Neighborhoods
using ForwardDiff
using Test
using InteractiveUtils


@testset "Neighborhoods.jl" begin
    @testset "Base" begin
        @test length(Neighborhood()) == 1
    end
    @testset "Derivative" begin
        @test ForwardDiff.derivative(abs, 0.0, Neighborhood()) == [1.0, -1.0, 1.0]
    end
    @testset "Code runs" begin
        include("../main.jl")
        include("../val.jl")
        include("../demo.jl")
    end
end