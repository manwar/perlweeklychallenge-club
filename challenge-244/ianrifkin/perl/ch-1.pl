use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;
use Data::Dumper;

# Task 1: Count Smaller

my $man = 0;
my $help = 0;
my $str_input;
GetOptions ('help|?' => \$help, man => \$man,
	    "nums=s" => \$str_input
    )
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Prepare input array
my @int;
# if values provided at cmd line split on comma
if ( $str_input ) {
    say reverse_pairs(split(/,/, $str_input));    
}
# else set default values from example if no cmd line input
else {
    # Example 1
    @int = (8, 1, 2, 2, 3); 
    say count_smaller(@int);

    # Example 2
    @int = (6, 5, 4, 8);
    say count_smaller(@int);

    # Example 3
    @int = (2, 2, 2);
    say count_smaller(@int);    
}

sub count_smaller {
    my @int = @_;
    my @int_out;

    # Loop through each number in array to count how many numbers are smaller than it
    for (my $i=0; $i < @int; $i++) {
	$int_out[$i] = 0; #default is no number is smaller than it
	# check each number in the array except for self
	for (my $j=0; $j < @int; $j++) {	
	    $int_out[$i]++ if ($int[$i] > $int[$j] && $i != $j);
	}
    }

    # Return the @output array in the desired format
    $Data::Dumper::Terse = 1; #don't print VAR names
    $Data::Dumper::Indent = 0; #keep output on one line
    return '(' . join(',', Dumper(@int_out)) . ')';
}

__END__

=head1 Challenge 244, Task 1: Count Smaller, by IanRifkin

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

Example 1
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
Example 2
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
Example 3
Input: @int = (2, 2, 2)
Output: (0, 0, 0)

See https://theweeklychallenge.org/blog/perl-weekly-challenge-244/#TASK1 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl [options]

=head1 OPTIONS

=over 8

=item B<-nums>

A list of numbers

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back




