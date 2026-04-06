use v5.38;
use List::Util "uniq";

my $SIZE = 1_000_000;

# Primes which could divide $SIZE or smaller
sub primes() {
    my @p = (2);
    for my $i (3 .. int(sqrt($SIZE))+1) {
	my $o = 0;
	for my $p (@p) {
	    if ($i % $p == 0) {
		$o = 1;
		last;
	    }
	}
	next if ($o);
	push @p, $i;
    }
    return @p;
}
my @primes = primes();

sub proc($num, $mode){
    say "Input:  \$num = $num\n\t\$mode = $mode";
    my @l;
    for my $p (@primes) {
	while ($num % $p == 0) {
	    $num /= $p;
	    push @l, $p;
	}
	last if ($num == 1);
    }
    push @l, $num if ($num != 1);
    my @distinct = uniq(@l);
    if ($mode == 0) {
	say "Output: ", scalar @distinct, " (@distinct)";
    } else {
	say "Output: ", scalar @l, " (@l)";
    }
}

my $num = 100061;
my $mode = 0;
proc($num, $mode);
$num = 971088;
proc($num, $mode);
$num = 63640;
$mode = 1;
proc($num, $mode);
$num = 988841;
proc($num, $mode);
$num = 211529;
$mode = 0;
proc($num, $mode);
