

function Oddletters(inp)
    local odd = true
    for c in inp:gmatch"." do
      --  print(c)
        local i = 0

        for _ in string.gmatch(inp,c) do
            i = i+1
        end
        

        if i%2==0 then
            print("false")
            odd =false
        end
        if i%2 == 0 then break end

    end
    if odd==true then
        print("true")
    end
end

Oddletters("weelky")
Oddletters("perl")
Oddletters("challenge")
