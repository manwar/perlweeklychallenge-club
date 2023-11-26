use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;

# Challenge 243, Task 2: Floor Sum

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
    say sum_floors(split(/,/, $str_input));    
}
# else set default values from example if no cmd line input
else {
    # Example 1
    @nums = (2, 5, 9);
    say sum_floors(@nums);

    #Example 2
    @nums = (7, 7, 7, 7, 7, 7, 7);
    say sum_floors(@nums);
}
    
sub sum_floors {
    my @nums = @_;
    my $sum_floors = 0;
    for (my $i = 0; $i < @nums; $i++) {
	for (my $j = 0; $j < @nums; $j++) {
	    $sum_floors += int($nums[$i] / $nums[$j]);
	}
    }
    return $sum_floors;
}

__END__

=head1 Challenge 242, Task 2, by IanRifkin: Floor Sum

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.

See https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK2 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl [options]

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-nums>

An optional comma separated list of integers (else defaults to values from examples)

=back




