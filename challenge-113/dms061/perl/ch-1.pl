use strict;
use warnings;

=pod

=head1 Question 1

You are given a positive integer $N and a digit $D.

Write a script to check if $N can be represented as a sum of positive integers 
having $D at least once. If check passes print 1 otherwise 0.

=head1 Question about question
Can the numbers repeat? E.g., if $D is 1, is 1 + 1 + ... + 1 = $N a valid answer?
It will make the problem more difficult, but I think yes...

=head1 Method

1) Create a list of (positive) integers with $D digit present that are < $N
2) Generate the power set of those digits
3) Sum the sets
4) Print all sets when the sum = $N

=head1 Optimizations

TODO

=head1 links

https://origin.geeksforgeeks.org/check-if-n-can-be-represented-as-sum-of-positive-integers-containing-digit-d-at-least-once/

=cut

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

=pod

brute function is ugly but effective. It generates summations using the values provided
until $sum = $n or $sum > $n 


=cut

sub brute {
	my ($sum, $n, @vals) = @_;
	print "In func, sum: $sum\n";
	# Base cases:
	return 1 if $sum == $n;
	return 0 if $sum > $n;
	for (@vals){
		return 1 if brute ($sum + $_, $n, @vals);
	}
	return 0;
}

# Get $n and $d. TODO add param checks on ARGV
my ($n, $d) = @ARGV;
print "$d\n";
# collect all numbers with $d in them
my @nums = grep /\d*$d\d*/, 1..($n-1);
# print "All numbers with digit $d that are < $n:\n@nums\n";
my $repr = brute 0, $n, @nums;
print "Output: $repr\n";
#my @pset = power_set (@nums);
#print_nested @pset;

