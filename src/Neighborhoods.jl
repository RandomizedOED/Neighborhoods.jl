module Neighborhoods

using ForwardDiff
using LinearAlgebra

greet() = print("Hello World!")

abstract type AbstractNeighborhood end

struct Neighborhood{T} <: AbstractNeighborhood
    x::Vector{T}
end

function Neighborhood()
    return Neighborhood(Vector{Nothing}([nothing, nothing, nothing]))
end

function Neighborhood(x::T) where {T}
    return Neighborhood(Vector{T}([x, x-eps(T), x+eps(T)]))
end

# Polutes outer scope
export Neighborhood, neighborhood, derivative_neighborhood

function neighborhood(f::Function, n::Neighborhood{T}) where {T}
    return f.(n.x)
end

# Doesn't work. Cannot add function to module
function derivative_neighborhood(f::Function, n::Neighborhood)
    return ForwardDiff.derivative.(f, n.x)
end

function ForwardDiff.derivative(f::Function, n::Neighborhood)
    return ForwardDiff.derivative.(f, n.x)
end

function ForwardDiff.derivative(f::Function, x::T, ::Neighborhood) where {T}
    n = Neighborhood(x)
    return ForwardDiff.derivative.(f, n.x)
end

Base.length(::Neighborhood{T}) where {T} = 1
Base.iterate(n::Neighborhood{Nothing}) = (n, nothing)
Base.iterate(::Neighborhood{Nothing}, ::Nothing) = nothing

end # module Neighborhoods
