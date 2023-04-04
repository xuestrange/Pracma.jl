
"""
     groupsum(mat, groups)

aggregate m according to g
## Arguments
+ `m`: matrix need to be aggregated
+ `b`: groups vector given keys
"""
function groupsum(m::AbstractMatrix{T}, g::AbstractVector{<:Integer}) where T <: Number
    size(m, 1) == length(g) || error("# of rows of m should equal to length of g")
    rst = zeros(T, (maximum(g), size(m, 2)))
    for (i, g) in pairs(g)
        @views rst[g, :] .+= m[i, :]
    end
    return rst
end
"""
     repeat_group(V::AbstractVector{<:Integer})

repeat index `i` `V[i]` times

# Examples
```jldoctest
julia> repeat_group([2, 3])
5-element Vector{Int64}:
 1
 1
 2
 2
 2
```
# see https://discourse.julialang.org/t/how-to-speed-up-rowsum-function/88664/3?u=strange_xue
"""
function repeat_group(V::AbstractVector{<:Integer})
    all(V .> 0) || error("elements in V has to be positive")
    rst = Vector{eltype(V)}()
    for g in eachindex(V)
        push!(rst, fill(g, V[g])...)
    end
    return rst
end

