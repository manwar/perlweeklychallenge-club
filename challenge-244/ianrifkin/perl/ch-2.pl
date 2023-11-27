use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;
use Algorithm::Combinatorics qw(partitions);
use List::Util qw( min max );
use Data::Dumper;

# Task 2: Group Hero

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
my @nums;
# if values provided at cmd line split on comma
if ( $str_input ) {
    say reverse_pairs(split(/,/, $str_input));    
}
# else set default values from example if no cmd line input
else {
    # Example 1
    @nums = (2, 1, 4);
    say group_hero(@nums);
}

sub group_hero {
    my @nums = @_;
    my $group_hero = 0;

    my @parts = partitions(\@nums);
    for (my $i=0; $i<@parts-1; $i++) {
	foreach ( @{$parts[$i]} ) {
	    my @parts = $_;
	    my $min = min @{$parts[0]};
	    my $max = max @{$parts[0]};	    
	    $group_hero += $max**2 * $min;
	}
    }
    return $group_hero;
}

__END__

=head1 Challenge 244, Task 2: Count Smaller, by IanRifkin

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations; power is defined as the square of the largest number in a sequence, multiplied by the smallest.

Example 1
Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

See https://theweeklychallenge.org/blog/perl-weekly-challenge-244/#TASK2 for more information on this challenge

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




