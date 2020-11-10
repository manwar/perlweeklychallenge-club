
my $A = @*ARGS.head;
my @N = @*ARGS[1..*];

my $yes = @N.combinations(2).first(-> @combo { $A == abs([-] @combo) });

say defined($yes) ?? 1 !! 0;
