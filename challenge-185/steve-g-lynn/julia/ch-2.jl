#!/usr/bin/env julia

function mask( str::String) ::String
    return( replace( str, r"[a-wyz0-9]"=>"x"; count=4) )
end

function mask( list::Vector{String}) ::Vector{String}
    retval=String[]
    for str in list
        push!(retval, mask(str))
    end
    return retval
end


println(mask(["ab-cde-123", "123.abc.420", "3abc-0010.xy"]))
println(mask(["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]))
    
