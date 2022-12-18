using CUDA
using ForwardDiff
using LinearAlgebra
function dotf(x)
    # 4 spaces indendation
    return y = exp.(x .* x)
end
x = [2.0,3.0]
dotf(x)
J = ForwardDiff.jacobian(dotf, x)

@show @code_llvm dotf(x)
@show @code_llvm (x -> ForwardDiff.jacobian(dotf, x))(x)
@code_llvm(dotf(x |> CuArray))
@code_llvm(jacobian(dotf, x |> CuArray))
