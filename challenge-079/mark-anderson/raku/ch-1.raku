unit sub MAIN($N where * > 0);

say (1..$N).map(*.base(2).indices(1)).sum mod 1000000007;
