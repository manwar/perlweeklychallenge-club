#my @N = ();
#my @N = (1, 2, 3);

my @N = (1, 2, 2, 3, 2, 4, 2);
my $N = @N.Bag.maxpairs.first.value || 0;
say $N > +@N div 2 ?? $N !! -1;