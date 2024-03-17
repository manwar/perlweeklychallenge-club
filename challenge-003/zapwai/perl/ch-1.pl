use v5.30.0;
my $N = $ARGV[0] || 1_000;
my @smooth;
for my $n (0 .. 50) {		# works for input up to 1e15
    for my $m (0 .. 32) {
	for my $o (0 .. 22) {
	    my $x = 2**$n*3**$m*5**$o;
	    next if ($x > $N);
	    push @smooth, $x ;
	}
    }
}
@smooth = sort { $a <=> $b } @smooth;	
say "@smooth";
