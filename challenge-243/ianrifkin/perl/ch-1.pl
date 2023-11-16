use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;

# Challenge 243, Task 1: Reverse Pairs

my $man = 0;
my $help = 0;
my $str_input;
GetOptions ('help|?' => \$help, man => \$man,
	    "nums=s" => \$str_input)
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
    my @nums = (1, 3, 2, 3, 1);
    say reverse_pairs(@nums);

    #Example 2
    @nums = (2, 4, 3, 5, 1);
    say reverse_pairs(@nums);    
}

sub reverse_pairs {
    my @nums = @_;
    my $pairs_found = 0;
    for (my $i = 0; $i < @nums-1; $i++) {
	for (my $j = $i+1; $j < @nums; $j++) {
	    $pairs_found++ if ($nums[$i] > $nums[$j] * 2);
	}
    }
    return $pairs_found;
}

__END__

=head1 Challenge 243, Task 1, by IanRifkin: Reverse Pairs

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].

See https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK1 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl [options]

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-nums>

An optional comma separated list of positive integers (else defaults to values from examples)

=back




