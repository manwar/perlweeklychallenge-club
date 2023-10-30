use v5.30;
no warnings;
my @words = ("aba", "aabb", "abcd", "bac", "aabc");
#@words = ("aabb", "ab", "ba");
#@words = ("nba", "cba", "dba");
my $count = 0;
my $output;
for my $i (0 .. $#words - 1) {
    my %a;
    $a{$_} = 1 foreach (split "", $words[$i]);
    my @a = keys %a;
    for my $j ($i + 1 .. $#words) {	    
	my %b;
	$b{$_} = 1 foreach (split "", $words[$j]);
	my @b = keys %b;
	if (is_same_letters(\@a, \@b)) {
	    $output .= " $words[$i] & $words[$j] |" ;
	    $count++;
	}
    }
}
say "Input: \@words = @words";
say "Output: $count";
say "\tPairs: " . substr $output, 0, -1 if ($count);
sub is_same_letters {
    my ($r, $s) = @_;
    my ($cnt,$cnt2) = 0;
    my $len = 1 + $#{$r};
    my $len2 = 1 + $#{$s};
    for my $l (@$r) {
	for my $m (@$s) {
	    $cnt++ if ($l eq $m);
	}
    }
    for my $l (@$s) {
	for my $m (@$r) {
	    $cnt2++ if ($l eq $m);
	}
    }    
    return 0 if ( ($cnt != $len) or ($cnt2 != $len2) );
    1
}
