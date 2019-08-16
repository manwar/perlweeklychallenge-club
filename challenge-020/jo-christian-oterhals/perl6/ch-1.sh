my $a = @*ARGS[0] and say join "\n", do for $a.comb.squish -> $b { $a ~~ s/^ ($b+) //; } or say "String expected as CLI parameter."
