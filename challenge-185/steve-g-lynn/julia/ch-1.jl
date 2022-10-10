#!/usr/bin/env julia

function convert_mac(mac::String ) ::String
    retval=String[]
    for i in split(mac,".")
        push!(retval, SubString(i,1,2), SubString(i,3,4))
    end
    return( join( retval, ":" ))
end

println(convert_mac("lac2.34f0.b1c2"))
println(convert_mac("abc1.20f1.345a"))

