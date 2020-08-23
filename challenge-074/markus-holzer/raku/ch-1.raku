my @N = (1, 2, 2, 3, 2, 4, 2);
my $N = @N.Bag.max( *.value ).value;
my $T = +@N div 2;

say $N > $T ?? $N !! -1;