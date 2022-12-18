using Neighborhoods
using ForwardDiff
using Test


@testset "Neighborhoods.jl" begin
    @testset "Base" begin
        @test length(Neighborhood()) == 1
    end
    @testset "Derivative" begin
        @test ForwardDiff.derivative(abs, 0.0, Neighborhood()) == [1.0, -1.0, 1.0]
    end
end