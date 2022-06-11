
avg_difference(Avg, V, Difference):-
    Difference is V - Avg.

square(X, XSquared):-
    XSquared is X * X.

xy(X, Y, XY):-
    XY is X * Y.

linear_regression(Points, RegressionLineEndpoints):-
    length(Points, NumberPoints),
    % 1. Calculate average of your X variable.
    maplist(nth(1), Points, Xs),
    msort(Xs, XSorted),
    nth(NumberPoints, XSorted, XMax),
    sum_list(Xs, XSum),
    XAvg is XSum / NumberPoints,
    % 2. Calculate the difference between each X and the average X.
    maplist(avg_difference(XAvg), Xs, XDifferences),
    % 3. Square the differences and add it all up. This is Sx.
    maplist(square, XDifferences, XDifferencesSquared),
    sum_list(XDifferencesSquared, Sx), 
    % 4. Calculate average of your Y variable.
    maplist(nth(2), Points, Ys),
    sum_list(Ys, YSum),
    YAvg is YSum / NumberPoints,
    % 5. Multiply the differences (of X and Y from their respective averages) and add them all together.  This is Sxy.
    maplist(avg_difference(YAvg), Ys, YDifferences),
    maplist(xy, XDifferences, YDifferences, XY),
    sum_list(XY, Sxy),
    % 6. Using Sx and Sxy, you calculate the intercept by subtracting Sx / Sxy * AVG(X) from AVG(Y).
    M is Sxy / Sx,
    B is YAvg - (Sxy / Sx * XAvg),
    EndX is XMax + 10,
    EndY is M * EndX + B,
    RegressionLineEndpoints = [0, B, EndX, EndY].

main:-
     Points = [[333,129], [39, 189], [140, 156], [292, 134], [393, 52], [160, 166], [362, 122], [13, 193], [341, 104], [320, 113], [109, 177], [203, 152], [343, 100], [225, 110], [23, 186], [282, 102], [284, 98], [205, 133], [297, 114], [292, 126], [339, 112], [327, 79], [253, 136], [61, 169], [128, 176], [346, 72], [316, 103], [124, 162], [65, 181], [159, 137], [212, 116], [337, 86], [215, 136], [153, 137], [390, 104], [100, 180], [76, 188], [77, 181], [69, 195], [92, 186], [275, 96], [250, 147], [34, 174], [213, 134], [186, 129], [189, 154], [361, 82], [363, 89]],
     linear_regression(Points, RegressionLine),
     write(RegressionLine), nl.
