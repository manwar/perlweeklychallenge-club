use strict;
use warnings;
use Math::Prime::Util qw/is_semiprime factor/;
#
# By its definition, 1st Brilliant number is square of 1st prime numbers
# => 2*2 = 4
my ($i,$count) = (4,0);
print($i) && $i++ && $count++;
{
	print ", $i" if is_semiprime($i) && eval(join(" - ", map{ length } factor $i ))==0 && $count++; 
	$i++ && redo if $count < 20;
	print "\n";
}
