

function irn(i,n)
    return cos(2π*i/n)+sin(2π*i/n)im
end



function möbius(n)
    if n==1
        return 1
    end
    if n==2
        return -1
    end
    primitive_roots=Any[]
    push!(primitive_roots, irn(1, n))
    for i in 2:n-1
        for s in 2:n-1
            if (i*s)%n==0
                @goto label1
            end
        end
        push!(primitive_roots, irn(i,n))
        @label label1
    end
    return round(Int,real(sum(primitive_roots)))
end
