#!/usr/bin/env julia

function digital_clock( mytime::String ) ::Int64
    
    r_time = r"^[0-2\?][0-9\?]\:[0-5\?][0-9\?]$"
    r_qn = r"\?"

    if (match(r_time, mytime)==nothing)
        return -1
    end
 
    mytest=SubString(mytime,1,2)
    if !occursin(r_qn, mytest)
        if parse(Int64, mytest ) >= 24
            return -1
        end
    end

    mytest=SubString(mytime,4,5)
    if !occursin(r_qn, mytest)
        if parse(Int64, mytest ) > 59
            return -1
        end
    end

    d_i = Dict()
    
    for i in mytime
        d_i[i]=0
    end
    
    for i in mytime
        d_i[i] += 1
    end
    
    if haskey(d_i,'?')
        if d_i['?'] != 1
            return -1
        end
    end

    qn_indx = findfirst('?',mytime)
    
    if qn_indx == 1
        if parse(Int64,mytime[2]) > 3
            return 1
        else
            return 2
        end
    end 
    
    
    if qn_indx == 2
        mytest=parse(Int64,mytime[1])
        if mytest <= 1
            return 9
        elseif mytest == 2
            return 3
        else
            return -999 #-- bug
        end
    end
    
    if qn_indx == 4
        return 5
    end
    
    if qn_indx == 5
        return 9
    end 

    return -999 #-- bug
    
end   

println( digital_clock("?5:00") ) #1
println( digital_clock("?3:00") ) #2
println( digital_clock("1?:00") ) #9
println( digital_clock("2?:00") ) #3
println( digital_clock("12:?5") ) #5
println( digital_clock("12:5?") ) #9
