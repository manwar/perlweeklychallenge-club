use v5.38;

sub proc($s) {
    say "Input: \"$s\"";
    my %h;
    $h{$_}++ for (split '', $s);
    my ($vowel_max, $cons_max) = (0, 0);
    for my $key (keys %h) {
	if (grep $_ eq $key, qw(a e i o u)) {
	    $vowel_max = $h{$key} if ($vowel_max < $h{$key});
	} else {
	    $cons_max = $h{$key} if ($cons_max < $h{$key});
	}
    }
    say "Output: ", $vowel_max + $cons_max;
}

my $s = "banana";
proc($s);
$s = "teestett";
proc($s);
$s = "aeiouuaa";
proc($s);
$s = "rhythm";
proc($s);
$s = "x";
proc($s);
