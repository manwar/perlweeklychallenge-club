
function Straight(x)
    local dummy = true
    -- calculated the determinant
    -- https://de.wikipedia.org/wiki/Kollinearität#Analytische_Geometrie
    local det = x[1][1]*x[2][2] + x[2][1]*x[3][2]+
    x[3][1]*x[1][2] - x[1][1]*x[3][2] - x[2][1]*x[1][2]
    - x[3][1]*x[2][2]
    print( det == 0)


end

Straight({ {2,1},{2,3},{2,5},{2,3}})
Straight({ {1,4},{3,4},{10,4}})
Straight({ {0,0},{1,1},{2,3}})
Straight({ {1,1},{1,1},{1,1}} )
Straight({ {1000000, 1000000} , {2000000, 2000000}, {3000000, 3000000}})
