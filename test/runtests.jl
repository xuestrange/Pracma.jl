using Random
seed = Random.seed!(2022 - 10 - 14)
using Test
n_groups = 5000
g_ = rand(seed, 2:10, n_groups)
m = randn(seed, sum(g_), 4)
# g = vcat(fill.(1:length(g_), g_)...)
g = repeat_group(g_)

@code_warntype repeat_group(g_)
@code_warntype rowsum(m, g)
using Pracma
rowsum(m, g)
@testset  "Pracma test" begin
    
end

repeat()