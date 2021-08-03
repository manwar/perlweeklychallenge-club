:-initialization(main).  

dot_product(X0-Y0, X1-Y1, N):-
    N0 is X0 * X1,
    N is N0 + Y0 * Y1.  

swap_key_value([], []).
swap_key_value([A-B|R], [B-A|S]):-
    swap_key_value(R, S). 

square(Points):-
    setof(X, member(X-_, Points),  Xs),    
    setof(Y, member(_-Y, Points),  Ys),    
    length(Xs, LXs),
    length(Ys, LYs), 

    keysort(Points, PointsByX),    
    swap_key_value(Points, Swapped),
    keysort(Swapped, PointsByY0),    
    swap_key_value(PointsByY0, PointsByY),
    last(PointsByY, Sx-Sy),  
    last(PointsByX, Tx-Ty),  
    nth(1, PointsByY, Ux-Uy),  
    nth(1, PointsByX, Vx-Vy), 
    SUx is Sx + Ux,
    TVx is Tx + Vx,
    SUy is Sy + Uy,
    TVy is Ty + Vy,
    SUym is Sy - Uy,
    TVxm is Tx - Vx,

    DVSTx is Sx - Tx,
    DVSTy is Sy - Ty,
    DVTUx is Tx - Ux,
    DVTUy is Ty - Uy,
    DVUVx is Ux - Vx,
    DVUVy is Uy - Vy,
    DVVSx is Vx - Sx,
    DVVSy is Vy - Sy,

    dot_product(DVSTx-DVSTy, DVTUx-DVTUy, DPSTU),   
    dot_product(DVTUx-DVTUy, DVUVx-DVUVy, DPTUV),   
    dot_product(DVUVx-DVUVy, DVVSx-DVVSy, DPUVS),   

    ((LXs == 2, LYs == 2); (SUx == TVx, SUy == TVy, SUym == TVxm, DPSTU == 0, DPTUV == 0, DPUVS == 0)). 
    

main:-
    ((square([10-20, 20-20, 20-10, 10-10]), write(1)); (write(0))), 
    nl,
    ((square([12-24, 16-10, 20-12, 18-16]), write(1)); (write(0))), 
    nl,
    ((square([-3-1, 4-2, -(9,-3), -(2,-4)]), write(1)); (write(0))), 
    nl,
    ((square([0-0, 2-1, -(3,-1), -(1,-2)]), write(1)); (write(0))), 
    nl,
    halt.
