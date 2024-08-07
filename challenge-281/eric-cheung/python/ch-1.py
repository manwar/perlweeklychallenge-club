
arrX_Coor = ["a", "b", "c", "d", "e", "f", "g", "h"]
arrY_Coor = [nLoop for nLoop in range(1, 9)]

## print (arrX_Coor)
## print (arrY_Coor)

## strCoord = "d3"  ## Example 1
## strCoord = "g5"  ## Example 2
strCoord = "e6"  ## Example 3

## Ref.
## True: Light
## False: Dark
print (arrX_Coor.index(strCoord[0]) % 2 == 1 or arrY_Coor.index(int(strCoord[1])) % 2 == 1)
