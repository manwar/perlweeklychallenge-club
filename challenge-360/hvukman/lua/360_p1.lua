
function justifier(str_,length_)

    local padding = length_ - #str_
    local right = math.ceil(padding/2)
    local left = padding - right
    io.write(string.rep("*",left),str_,string.rep("*",right),"\n")

end


justifier("Hi",5)
justifier("Code",10)
justifier("Hello",9)
justifier("Perl",4)
justifier("A",7)
justifier("",5)

