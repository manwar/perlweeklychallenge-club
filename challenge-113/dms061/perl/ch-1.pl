use strict;
use warnings;

=pod

=head1 Question 1

You are given a positive integer $N and a digit $D.

Write a script to check if $N can be represented as a sum of positive integers 
having $D at least once. If check passes print 1 otherwise 0.

NOTE: I am allowing a number to occur more than once in the summation

=head1 Optimizations

TODO

=head1 Old Code (not used in solution)

sub push2each{
	my ($val, @arr) = @_;
	# Creates a copy by turning the refernce into a value array
	# Pushes the new value and then returns a reference to it
	return map {my @cp = @{$_}; push @cp, $val; \@cp;} @arr;
}

sub print_nested{
	print "(";
	print "[@{$_}] " foreach @_;
	print ")\n";
}

sub power_set{
	return ([]) if @_ == 0; # base case, no elements, set with empty set
	my ($head, @rest) = @_;
	# for some reason the following line needed parens around it. Errors otherwise.
	my @pset = power_set (@rest); #add remaining sets without $head
	push @pset, push2each ($head, @pset); #add remaining sets with head
	return @pset;
}

#my @a = ([1, 2], [3, 4]);
#my @b = push2each 9, @a;
#print_nested @a;
#print "B->@b\n";
#print_nested @b;
#my @a = (7, 8, 9);
#my @pa = power_set (@a);
#print_nested @pa;

=head1 brute force

brute function is ugly but effective. It generates summations using the values provided
until $sum = $n or $sum > $n 

=cut

sub brute {
	my ($sum, $n, @vals) = @_;
	# Base cases:
	return 1 if $sum == $n;
	return 0 if $sum > $n;
	# Try to add a number and see what happens
	for (@vals){
		return 1 if brute ($sum + $_, $n, @vals);
	}
	return 0;
}

=pod

=head1 Optimization attempt...

doesn't work for all cases... :<
specifically n = 28, d = 3

sub check {
	my ($n, @nums) = @_;
	my $rem = 0;
	for my $i (0 .. $#nums){
		# check if $n is a multiple of $num[$i]
		$rem = $n % $nums[$i];
		return 1 unless $rem;
		# check if a some multiple of other @nums could be added to make $n
		for (reverse(0 .. $i - 1)){
			$rem %= $nums[$_];
			return 1 unless $rem;
		}
	}
	return 0;
}

=cut

# Get $n and $d. TODO add param checks on ARGV
if (@ARGV == 2){
	# run a specific input supplied in ARGV
	my ($n, $d) = @ARGV;
	# collect all numbers with $d in them
	my @nums = grep /\d*$d\d*/, 1..($n-1);
	print "Numbers: @nums\n";
	# print "All numbers with digit $d that are < $n:\n@nums\n";
	my $repr = brute 0, $n, @nums;
	#my $repr2 = check $n, @nums;
	print "Output: $repr\n";
}else{
	# not enough input args (or too many), go into test mode
	for my $n (10 .. 25){
		for my $d (1 .. 9){
			my @nums = grep /\d*$d\d*/, 1..($n-1);
			my $b = brute 0, $n, @nums;
			print "Input: n = $n, d = $d --> Output: $b\n";
			#my $c = check $n, @nums;
			#print "$b ?= $c";
			#print "($b != $c) Failed n = $n, d = $d\n" unless $b == $c;
		}
	}
}
