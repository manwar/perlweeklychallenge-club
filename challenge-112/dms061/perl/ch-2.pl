use strict;
use warnings;

# Question 2: You are given $n steps to climb
# Write a script to find out the distinct ways to climb to the top. 
# You are allowed to climb either 1 or 2 steps at a time.

# I know there is a better way to implement this. I remember hearing about this (or a similar question)
# during a programming interview--albeit it was about counting the ways to climb $n stairs, and not
# generating them. I believe the solution involved a recurrence relation, so I think there is a nice
# way to determine the methods of climbing $n in terms of some lower $ns.
# But first, I need some data on what f($n) is. Following some advice I was given: let the computer do the
# work for you. This function will recursively generate all methods of climbing stairs and terminate after
# we have climbed at least $n. It only will contribute to the final count if exactly $n stairs were climbed

# Variables for checking effiency
my $calls = 0;

# The idea: we implement a recursive prefix search.
# At any point we have to options to take -> 1 or 2 steps
# We just take any and all paths (for n levels) adding valid paths as we go
#sub brute {
#	my ($n, $cur) = @_;
#	$calls++;
#	#print "n = $n and cur = $cur\n";
#	return 1 if $n == $cur;
#	return 0 if $cur > $n;
#	return brute($n, $cur + 1) + brute($n, $cur + 2);
#}
# Example output:
# f(1) = 1, f(2) = 2, f(3) = 3, f(4) = 5, f(5) = 8, f(6) = 13, f(7) = 21, f(8) = 34, f(9) = 55, f(10) = 89
# ^ we can refactor this to be more like fib! Furthermore, fib would take less operations.
# NOTE: BASE CASES ARE SLIGHTLY OFF, climb(n) = fib(n+1)
# I could have implemented fib with altered base cases, but it felt weird, so climb is a separate function

sub fib {
	my $n = shift;
	$calls++;
	return $n if $n < 2;
	return fib($n - 1) + fib($n - 2);
}

# ^ we can optimize further by memoizing!
# The table of memoized values. I've added $fib[0] so there is no offset due to 0 indexing
my @fib = (0, 1);
sub fib_memo {
	my $n = shift;
	$calls++;
	if ($n > $#fib){
		# oddity of perl, this works!
		# normally, we would have to store new calculated value in a temporary
		# variable because the other fib calls fill the table up to $n, thus
		# allowing us to store the $nth fib value. 
		# However, perl doesn't seem to care (at least on my machine)
		# as long as the value is initalized. You can have gaps between initialized values!
		# Nonethless, we fill up the table by the end anyway
		$fib[$n] = fib_memo($n - 1) + fib_memo($n - 2);
	}
	return $fib[$n];
}

sub climb {
	my $n = shift;
	return fib_memo($n + 1);
}
# Now we have a new problem (2b if you will) -> how do we get the order of the steps?
# The example answer listed all the sequences of steps you could take. I have a really
# nice way of calculating how many sequences you can take, but this does not calculate them
# Theoretically, we can apply a similar method. We can store/calc the sequences for $fib[$n - 1] and
# $fib[$n - 2] and then generate a new sequence that has a 1 and 2 step added (and shuffled) throughtour
# the other sequences respectively

# this func stores the order of the steps
#sub brute_path {
#	my ($n, $cur, @order) = @_;
#	$calls++;
#	#return @order if $n == $cur;
#	if($cur == $n){
#		print "$_ + " foreach @order[0..$#order-1];
#		print "$order[$#order]\n";
#		return 1;
#	}elsif($cur > $n){
#		return 0;
#	}
#	#return () if $cur > $n;
#	$order[@order] = 1;
#	my $lbranch = brute_path($n, $cur + 1, @order);
#	$order[$#order] = 2;
#	return $lbranch + brute_path($n, $cur + 2, @order);
#}

# Test about how and when array warnings are generated
# It will onlt throw warnings when trying to access uninitialized elements
# You can assign to $test[10] without initialized 0..9 and will get no
# errors or warnings as long as you only access elt 10
#my @test = (1, 2, 3);
#$test[10] = 9;
#print "@test\n";
#print "$test[3]\n";
#print "$test[10]\n";

my $count = 0;
for (1 .. 100){
	$count = climb $_;
	print "climb($_) = $count with $calls funcalls\n";
	$calls = 0;
}
