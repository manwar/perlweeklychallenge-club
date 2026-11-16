use v5.38;

sub proc($n) {
    say "Input: $n";
    my @a = (1 .. $n);
    my @o;
    for my $num (@a) {
	if ($num < 11) {
	    push @o, $num;
	    next;
	}
	my @d = split '', $num;
	my %h;
	for my $dig (@d) {
	    $h{$dig}++;
	}
	my $flag = 0;
	for my $val (values %h) {
	    $flag = 1 if ($val > 1);
	}
	next if ($flag);
	push @o, $num;
    }
    my $out = 0;
    for my $i (0 .. $#o - 1) {
	my $diff = $o[$i+1] - $o[$i];
	$out = $diff if ($diff > $out);
    }
    say "Output: $out\n";
}

my $int = 20;
proc($int);
$int = 110;
proc($int);
$int = 500;
proc($int);
$int = 2026;
proc($int);
$int = 10000;
proc($int);
