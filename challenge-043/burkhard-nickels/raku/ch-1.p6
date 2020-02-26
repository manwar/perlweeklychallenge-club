#!/home/chuck/rakudo/bin/perl6

use strict;

print "ch-1.p6, PWC #43 Task #1: Olympic Rings\n";

my @a = (9,'x',5,'x','x','x',7,'x',8);

print "Values: ", join("-",@a), "\n";
my ($c,$nrx);                               # Number of x in array
repeat {
	numbers();
	$c = join("",@a) ~~ m:g/x/;  # Determine Nr of x
	$nrx = $c.chars;
} while ($nrx);                  # if Nr of x

print "Result: ", join("-",@a), "\n";

# ------------------- function to determine missing numbers
sub numbers {
	loop (my $i = 0; $i <= @a.end; $i += 2) {  # Only every second value is a Main Ring Value

		my @win = @a[$i-1 .. $i+1]; # Create window of 3 numbers that shifts along array
		@win[0] = 0 if $i==0;       # At begin, set window first element to zero
		@win[2] = 0 if $i==@a.end;  # At end,   set window last  element to zero

		my $c = join("",@win) ~~ m:g/x/;  # How many x are in window
		my $nr = $c.chars;
		if ($nr == 1) {                   # Only if 1 value is missing, determine next value
			if (@win[1] eq 'x') { @a[$i] = 11 - @win[0] - @win[2]; } 
			elsif (@win[0] eq 'x') { @a[$i-1] = 11 - @win[1] - @win[2]; }
			elsif (@win[2] eq 'x') { @a[$i+1] = 11 - @win[1] - @win[0]; }
		}
	} 
}

