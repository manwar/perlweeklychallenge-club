n = Input[];
solution = Solve[
    a > 0 && b > 0 && c > 0 && d > 0 && a b = c d && c d == n && a + b = c + d + 1,
    {a, b, c, d},
    Integers
];
If [solution == {}, Print[0], Print[1]];
