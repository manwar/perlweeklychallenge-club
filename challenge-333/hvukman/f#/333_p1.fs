// 333 part 1

let input = [  [|2;1|]  ;  [|2;3|]  ;  [|2;5|] ];
let input2 = [  [|1;4|]  ;  [|3;4|]  ;  [|10;4|] ];
let input3 = [  [|0;0|]  ;  [|1;1|]  ;  [|2;3|] ];
let input4 = [  [|10000;10000|]  ;  [|20000;20000|]  ;  [|30000;30000|] ];
let inputs_1 = [ input; input2 ; input3; input4]
//    -- calculated the determinant
//    -- https://de.wikipedia.org/wiki/Kollinearität#Analytische_Geometrie
let det (x:int array list)  =  let x1,x2,x3 = x[0].[0],x[1].[0],x[2].[0]
                               let y1,y2,y3 = x[0].[1],x[1].[1],x[2].[1]
                               let det = x1*y2 + x2*y3 + x3*y1 - x1*y3 - x2*y1 - x3*y2
                               if det =0 then printf "%s\n" "true" else printf "%s\n" "false"

for x in inputs_1 do
    det (x)
                                 
       
