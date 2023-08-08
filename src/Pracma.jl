module Pracma
using PrettyTables
using LinearAlgebra:diag
using Distributions
include("rowsum.jl")
include("pval.jl")
export groupsum, groupmean, repeat_group
export signicant, pvalue, table
end # module pracma
