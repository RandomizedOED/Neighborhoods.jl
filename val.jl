x = 2.0
y = 3.0

# Comparison instruction is executed at runtime
@code_llvm x == y

x + y

x = Val(2.0)
y = Val(3.0)

# Comparison is done by the compiler based on the type
@code_llvm x == y

# Error. Only run in REPL, not when running tests.
if isinteractive()
    x + y
end

import Base.+

function (+)(::Val{N1}, ::Val{N2}) where {N1, N2}
    return Val{N1 + N2}()
end

@code_llvm x + y
