#!/usr/bin/env julia

function frequency_equalizer(s::String ) ::Bool
    
    d_s = Dict()
    
    for i in s 
        d_s[i]=0
    end
    
    for i in s
        d_s[i] += 1
    end
    
    
    v_s=Vector( sort!(unique(values(d_s))) )
    
    if ( (length(v_s) <= 2) &&
        ( (v_s[1] == 1) ||
          ( length(v_s) > 1 && (abs(v_s[2] - v_s[1]) == 1)) ) )
        return true
    end
   
    return false 
end

println( frequency_equalizer("abbc") ) #true
println( frequency_equalizer("xyzyyxz") ) #true 
println( frequency_equalizer("xzxz") ) #false
println( frequency_equalizer("abcde") ) #true 
println( frequency_equalizer("abbbccc") ) #true

