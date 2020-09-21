unit sub MAIN($N where * > 0);

say (1..$N).map(*.base(2)).comb.sum mod 1000000007;
