local moves = {  {{0, 0} , {2, 0} , {1, 1} , {2, 1} , {2 ,2} }
    , { {0, 0} , {1,1} , {0, 1} , {0, 2} , {1 ,0}, {2,0} }
    , { {0, 0} , {1,1} , {2, 0} , {1, 0} , {1 ,2}, {2,1}, {0, 1} , {0 ,2}, {2,2} }
    , {  {0, 0} , {1,1 } }
    , { {1,1} , {0,0} , {2,2} , {0, 1} , {1 ,0}, {0,2} }
}
local magic_square = { {4,9,2}, {3,5,7},{8,1,6}} 
-- https://en.wikipedia.org/wiki/Magic_square
-- any winning combination is 15

function Winner(X)
    -- a game with less than 3 moves cannot be won
    if #X>=3 then

        local score_a = 0
        local score_b = 0

        for j=1,#X do
            
            if j%2==0 then -- move b
                score_b = score_b + magic_square[1+X[j][1]] [1+X[j][2]]
            else -- move a
                score_a = score_a + magic_square[1+X[j][1]] [1+X[j][2]]
            end
            -- winning score is 15
            if score_a == 15 then
                print ("Winner A")
            else if score_b == 15 then
                print ("winner B")
            end
            -- if at the end no score is 15 => draw
            if j==#X and score_a~=15 and score_b~=15 then
                print("draw")
            end

            end
        end
    else
        print("pending")
    end

end

for _,v in ipairs(moves) do
    Winner(v)
end



