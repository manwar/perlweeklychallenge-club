

local function rearrange_spaces(x)
    local res = {}
    local spaces = {}

    for i in string.gmatch(x,"%w+") do
        table.insert(res,i)
    end

    for i in string.gmatch(x,"%s+") do
        table.insert(spaces,i)
    end

    local len_spaces = 0
    for _,v in ipairs(spaces) do
        len_spaces = len_spaces + #v
    end

    

    if len_spaces%#res==0 then

        if #res>1 then
            io.write("\"")
            for i=1,#res-1 do
                io.write(res[i], string.rep(" ",len_spaces//(#res-1)))
            end
            io.write(res[#res], "\"","\n")
        else
            io.write("\"", res[1], string.rep(" ",len_spaces),"\"","\n")
        end
    else
        local gaps = #res-1
        local new_space = len_spaces//gaps
        local ii=1
        io.write("\"")
        while ii<#res do
            io.write(res[ii],string.rep(" ",new_space))
            ii =ii+1
        end
        io.write(res[ii],"\"","\n")
    end
    
end

for _,v in ipairs{"  challenge  ","coding  is  fun","a b c  d", "  team      pwc  ","   the  weekly  challenge  "} do
        rearrange_spaces(v)
end


