use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

my $n = shift;
$n = 1000 unless $n && $n =~ /^\d+$/;
my $o = "";
#my $i = 2;
my $i = 1;
{
	#my $cp = $i**3 - ($i-1)**3;
	my $cp = 3*$i*$i + 3*$i + 1;
	last if $cp > $n;
	$o .= ", $cp" if is_prime($cp);
	$i++;
	redo;
}
$o =~ s/^\D+//;
printf "%s\n", $o;
