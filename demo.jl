using CUDA
# On Mac
# using Metal
# On Intel Xe Graphics or Intel GPUs
# using oneAPI
using ForwardDiff
using LinearAlgebra

# Profiling
# For @time
using Profile
# For @btime
using BenchmarkTools
# Flamegraph
using PProf
function dotf(x)
    # 4 spaces indendation
    return exp.(x .* x)
end
x = [2.0,3.0]
@show dotf(x)
@show J = ForwardDiff.jacobian(dotf, x)

@show @code_llvm dotf(x)
@show dotf(x |> CuArray)

# Profiling
@time ForwardDiff.jacobian(dotf, x)
@time ForwardDiff.jacobian(dotf, x |> CuArray)
x = rand(10000)
@benchmark ForwardDiff.jacobian(dotf, x)
@benchmark ForwardDiff.jacobian(dotf, x |> CuArray)

x = rand(10000)
Profile.clear()
Profile.@profile ForwardDiff.jacobian(dotf, x)
pprof()

x = rand(10000)
Profile.clear()
Profile.@profile ForwardDiff.jacobian(dotf, x |> CuArray)
pprof()

x = rand(10000)
Profile.Allocs.clear()
Profile.Allocs.@profile ForwardDiff.jacobian(dotf, x)
results = Profile.Allocs.fetch()
last(sort(results.allocs, by=x->x.size))
PProf.Allocs.pprof()