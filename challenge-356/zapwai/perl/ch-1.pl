use v5.38;

# My code works for $int < 13

my $begin = "1221121221221121122";
my @chunk;
for my $i (0 .. length($begin) - 1) {
    my $char = substr($begin, $i, 1);
    my $next_char = substr($begin, $i + 1, 1);
    if ($char ne $next_char) {
	my $s = $char;
	unless ($i == 0) {
	    my $prev_char = substr($begin, $i - 1, 1);
	    if ($prev_char eq $char) {
		$s .= $char;
	    }
	}
	push @chunk, $s;
    }
}

sub proc($int) {
    say "Input: \$int = $int";
    my $s;
    for my $i (0 .. $int - 1) {
	$s .= length($chunk[$i]);
    }
    say $s;
    my $cnt = 0;
    for my $i (0 .. length($s) - 1) {
	my $char = substr($s, $i, 1);
	$cnt++ if ($char eq 1);
    }
    say "Output: $cnt";
}

my $int = 4;
proc($int);
$int = 5;
proc($int);
$int = 6;
proc($int);
$int = 7;
proc($int);
