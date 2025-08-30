local scores = {"5","-2","4","C","D","9","+","+"}

function Final_score(x)
    local score = 0
    local prev = {}
    local res = {}

    for i=1,#x do
        if (tonumber(x[i])) then
            table.insert(prev,x[i])
            table.insert(res,x[i])
        elseif scores[i]=="C" then
            table.remove(prev)
            table.remove(res)
        elseif scores[i]=="D" then -- double previous score
            local last = prev[#prev]
            table.insert(res,last*2)
            table.insert(prev,last*2)
        elseif scores[i]=="+" then -- add last two scores
            local last = prev[#prev]
            local last2 = prev[#prev-1]
            table.insert(res,last+last2)
            table.insert(prev,last+last2)
        end
    end


    for _,v in ipairs(res) do
        print(v)
        score= score + v
    end

    print("score ", score)
end

Final_score(scores)