use strict;
use warnings;
use Math::Prime::Util qw/is_prime next_prime/;

my $n = shift;
$n = 100 unless $n && $n =~ /^\d+$/;
my $p = 2;
my $ap = $p;
{
	$p = next_prime($p);
	last if $p > $n;
	$ap .= ", $p" if $p < 10 || is_prime(eval(join(" + ", $p =~ /(.)/g)));
	redo;
}
printf "%s\n", $ap;
