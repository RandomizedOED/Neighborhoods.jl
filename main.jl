using ForwardDiff
using Neighborhoods
using CUDA
using LinearAlgebra

x = 0.0

@show n = Neighborhood(x)
@show neighborhood(abs, n)
@show derivative_neighborhood(abs, n)

x = [0.0, 1.0]
@show ForwardDiff.derivative.(abs, x, Neighborhood())