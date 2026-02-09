use v5.38;
use List::Util "sum";

sub proc($int) {
    say "Input: $int";
    my $pers = 0;
    my @d = split '', $int;
    if (1 == @d) {
	say "Output: Persistence = $pers \n Digital Root = $int";
    } else {
	my $sum = $int;
	do {
	    $pers++;
	    @d = split '', $sum;
	    $sum = sum(@d);
	} while (1 < length($sum));
	say "Output: Persistence = $pers \n Digital Root = $sum";
    }
}

my $int = 38;
proc($int);

$int = 7;
proc($int);

$int = 999;
proc($int);

$int = 1999999999;
proc($int);

$int = 101010;
proc($int);
