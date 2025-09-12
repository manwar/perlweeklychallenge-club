local inputs = { {6, 5, 4, 8},{7,7,7,7},{5, 4, 3, 2, 1},
    {-1, 0, 3, -2, 1},{0, 1, 1, 2, 0} }

function Smaller(X)
    for i,v in ipairs(X) do
        local int = 0
        for j,w in ipairs(X) do
            if v>= w and i~=j then
                int = int +1
            end
        end
        io.write(int," ")
    end
    io.write("\n")
end

for i=1,#inputs do
    Smaller(inputs[i])
end
