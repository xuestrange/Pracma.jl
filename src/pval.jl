function signicant(pval)
    if (pval <= 0.1) & (pval > 0.05)
        return "*"
    elseif (pval > 0.01) & (pval <= 0.05)
        return "**"
    elseif pval <= 0.01
        return "***"
    else
        return ""
    end
end
function pvalue(est_pars, num_hessian)
    length(est_pars) == size(num_hessian, 1) || throw(error("pars and related hessian matrix are not matched!"))
    iszero(det(num_hessian)) || throw(error("Hessin matrix is not invertable!"))
    squ_error = diag(inv(num_hessian))
    all(i -> i > 0, squ_error) || throw(error("Some standard errors are negative!"))
    sderror = sqrt.(squ_error)
    t_stats = est_pars ./ sderror
    pval = 2 .* (cdf.(Normal(0, 1), -abs.(t_stats)))
    return (sderror, pval)
end
function table(pars_name, pars_value, num_hessian)
    sderror, pval = pvalue(pars_value, num_hessian)
    sig_level = signicant.(pval)
    header = ["Parameters", "Estimates", "S.d.", "Significant level"]
    data = hcat(pars_name, pars_value, sderror, sig_level)
    hl = Highlighter((data, i, j) -> (data[i, 4] != ""), crayon"red bold")
    return pretty_table(data; header=header, formatters=ft_printf("%.2f"), highlighters=(hl), alignment=[:r, :r, :l, :l])
end