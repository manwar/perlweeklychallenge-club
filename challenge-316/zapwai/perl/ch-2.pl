use v5.38;
sub proc($s1, $s2) {
    say "Input: $s1, $s2";
    my @l = split '', $s1;
    my $o = 'true';
    my $ind = 0;
    for my $i (0 .. $#l) {
	$ind = index $s2, $l[$i], $ind;
	$o = 'false' if ($ind == -1);
    }
    say "Output: $o";
}

my $s1 = "uvw";
my $s2 = "bcudvew";
proc($s1, $s2);

$s1 = "aec"; $s2 = "abcde";
proc($s1, $s2);

$s1 = "sip"; $s2 = "javascript";
proc($s1, $s2);
