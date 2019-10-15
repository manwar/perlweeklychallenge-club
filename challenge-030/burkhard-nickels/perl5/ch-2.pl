#!/usr/bin/perl

# ----------------------------------
# Perl Weekly Challenge 30 Task #2
#
# Write a script to print all possible series of 3 positive numbers, 
# where in each series at least one of the number is even and sum of 
# the three numbers is always 12. For example, 3,4,5.
#
# ----------------------------------

use strict;
use warnings;
use PDL;
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent=0;

print "----------- Solution with Array ----------\n";
solution_array();
print "----------- Solution with PDL ------------\n";
solution_pdl();
print "----------- Solution with Map ------------\n";
solution_map();
print "------------------------------------------\n";

# ----------------------------------
# Solution 1: with Array
#
# Takes only values from 1 to 12, Zero is excluded in this solution.
#
sub solution_array {
	my @a;
	for(my $i=1; $i<=12; $i++) {
		for(my $j=$i; $j<=12; $j++) {
			for(my $k=$j; $k<=12; $k++) {
				my $sum = $i + $j + $k;
				$a[$i][$j][$k] = $sum;
				print "Sum: $i + $j + $k = $sum\n" if $sum == 12 && even($i,$j,$k);
			}
		}
	}
}
sub even {
	my (@nrn) = @_;
	my $ret = 0;
	foreach my $n (@nrn) { if($n%2==0) { $ret = 1; } }
	return $ret;
}

# ----------------------------------
# Solution 2: with PDL
#
# With PDL also Zero Values are included.
#
sub solution_pdl {
	my $n = 13;
	my $sum  = xvals($n,$n) + yvals($n,$n) + zvals($n,$n,$n);
	my $idx  = whichND($sum==12);
	my $href = eleminate( $idx->unpdl );
	foreach my $key (keys %$href) { print "$key\n"; }
}
sub eleminate {
	my $aref = shift;
	my @tmp  = grep { $_ if (!($_->[0]%2) || !($_->[1]%2) || !($_->[2])) } @$aref;
	my %h    = map { join("-",sort @$_) => 1 } @tmp;
	return \%h;
}

# ----------------------------------
# Solution 3: with map
#
# Also no Zero values
#
sub solution_map {
	my @a = grep { $_!=0 } map { 
		my $x = $_; 
		map { 
			my $y  = $_;
			my $b2 = $_+$x; 
			map { 
				my $z = $_;
				my $sum = $_+$b2; 
				if($sum == 12 && (!($x%2)||!($y%2)||!($z%2))) {
					[ $sum, $x, $y, $z ]; }
				else { 0 }
			} ($y .. 12)
		} ($x .. 12)
	} (1 .. 12);
	
	my $str = Dumper(\@a);
	$str =~ s/\]/\]\n/g;
	print $str;
}


