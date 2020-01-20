#!/usr/bin/perl

use strict;
use warnings;

print "ch-1.pl, PWC #43 Task #1: Olympic Rings\n";
my $DEBUG=0;

my @a = (9,'x',5,'x','x','x',7,'x',8);

print "Values: ", join("-",@a), "\n";
my $nrx;                             # Number of x in array
do {
	numbers();
	$nrx = () = join("",@a) =~ /x/g; # Determine Nr of x
} while($nrx);                       # if Nr of x

print "Result: ", join("-",@a), "\n";

# ------------------- function to determine missing numbers
sub numbers {
	for(my $i=0; $i<=$#a; $i+=2) {  # Only every second value is a Main Ring Value

		my @win = @a[$i-1 .. $i+1]; # Create window of 3 numbers that shifts along array
		$win[0] = 0 if $i==0;       # At begin, set window first element to zero
		$win[2] = 0 if $i==$#a;     # At end,   set window last  element to zero

		my $nr = () = join("",@win) =~ /x/g;  # How many x are in window
		print "($i) Win(", join("/",@win), ") Nrx $nr\n" if $DEBUG;
		if($nr == 1) {                     # Only if 1 value is missing, determine next value
			if($win[1] eq 'x') { $a[$i] = 11 - $win[0] - $win[2]; } 
			elsif($win[0] eq 'x') { $a[$i-1] = 11 - $win[1] - $win[2]; }
			elsif($win[2] eq 'x') { $a[$i+1] = 11 - $win[1] - $win[0]; }
		}
	} 
}

