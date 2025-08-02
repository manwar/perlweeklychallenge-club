use v5.38;
my $alph = 'abcdefghijklmnopqrstuvwxyz';
my $stringy = 'a1c1e1';
proc($stringy);
$stringy = 'a1b2c3d4';
proc($stringy);
$stringy = 'b2b';
proc($stringy);

sub proc($stringy) {
    say "Input: str = $stringy";
    my @lets;
    my @puts;
    for my $i (0 .. length($stringy) - 1) {
	if ($i % 2 == 0) {
	    my $let = substr $stringy, $i, 1;
	    push @lets, $let;
	} else {
	    my $put = shifty($lets[$#lets], substr $stringy, $i, 1);
	    push @puts, $put;
	}
    }
    print "Output: ";
    print $lets[$_], $puts[$_] for (0 .. length($stringy)/2 - 1);
    if ((length $stringy) % 2 == 1) {
	print $lets[$#lets];
    }
    print "\n";
}
    
sub shifty($c, $d) {
    my $ind = index $alph, $c;
    return substr $alph, $d + $ind, 1;
}
