function oddmatrix(row,col,locs)

    local mat = {}
    for i=1,row do
        mat[i]={}
        for j=1,col do
            mat[i][j]=0
        end
    end

    for i,v in ipairs(locs) do
      
        -- apply to rows
        for k=1,col do
            mat[v[1]+1][k]=mat[v[1]+1][k]+1
        end
        -- apply to cols
        for l=1,row do
            mat[l][v[2]+1] =  mat[l][v[2]+1]+1
        end

    end


    local odds=0

    for i=1,row do
        for j=1,col do
            if mat[i][j]%2~=0 then
                odds = odds + 1
            end
        end
    end
    print("odds ", odds)
end

oddmatrix(2,3,{{0,1},{1,1}})
oddmatrix(2,2,{{1,1},{0,0}})
oddmatrix(3,3,{{0,0},{1,2},{2,1}})
oddmatrix(1,5,{{0,2},{0,4}})
oddmatrix(4,2,{{1,0},{3,1},{2,0},{0,1}})
