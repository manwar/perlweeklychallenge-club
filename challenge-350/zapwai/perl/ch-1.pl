use v5.38;

sub is_bad($s) {
    my @l = split '', $s;
    return ($l[0] eq $l[1] || $l[0] eq $l[2] || $l[1] eq $l[2]);
}

sub proc($str) {
    say "Input: \$str = $str";
    my $cnt = 0;
    for my $i (0 .. length($str) - 3) {
	my $s = substr $str, $i, 3;
	$cnt++ unless (is_bad($s));
    }
    say "Output: $cnt";
}

my $str = 'abcaefg';
proc($str);

$str = 'xyzzabc';
proc($str);

$str = 'aababc';
proc($str);

$str = 'qwerty';
proc($str);

$str = 'zzzaaa';
proc($str);
