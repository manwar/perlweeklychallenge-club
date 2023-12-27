use v5.30;
my $str = "IDID";
# my $str = "III";
# my $str = "DDI";
my @s = split "", $str;
my @p = (0 .. @s);
say "Input: \$str = $str";
print "Output: ";
my $cnt;
do {
    $cnt = 0;
    for my $i (0 .. $#s) {
	if ($s[$i] eq 'I') {
	    if ($p[$i] > $p[$i+1]) {
		swap($i, \@p);
		$cnt++;
	    }
	} else {
	    if ($p[$i] < $p[$i+1]) {
		swap($i, \@p);
		$cnt++;	    
	    }
	}
    }
} while ($cnt != 0);

say "@p";

sub swap {
    my ($i, $ref) = @_;
    my $val = $$ref[$i];
    $$ref[$i] = $$ref[$i + 1];
    $$ref[$i + 1] = $val;
}
