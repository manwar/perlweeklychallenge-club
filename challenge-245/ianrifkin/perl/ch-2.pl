use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;
use Algorithm::Permute;
use Algorithm::Combinatorics qw(partitions);


# Task 2: Largest of Three

my $man = 0;
my $help = 0;
GetOptions ('help|?' => \$help, man => \$man
    )
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Example 1
my @ints = (8, 1, 9);
say largest(@ints);
# Output: 981

# Example 2
@ints = (8, 6, 7, 1, 0);
say largest(@ints);
# Output: 8760

# Example 3
@ints = (1);
say largest(@ints);
# Output: -1
    
sub largest {
    my @ints = @_; #input array of indidviual ints

    # form an an array of all the possible numbers to try
    my @numbers_to_try; 
    # use Algorithm::Combinatoric::partitions to generate all the combinations of numbers
    # e.g. for 9,8,1 it is: 981, 98, 91, 9, 81, 8, 1
    my @parts = partitions(\@ints);
    for (my $i=0; $i<@parts-1; $i++) {
	foreach ( @{$parts[$i]} ) {
	    my @parts = $_;
	    # use Algorithm::Permute to take the partitions and create every order of the numbers
	    # e.g. for an input of 91 it would output 91 and 19
	    my $p_iterator = Algorithm::Permute->new ( \@{$parts[0]} );
	    while (my @perm = $p_iterator->next) {
		push(@numbers_to_try, join('', @perm));
	    }	    
	}
    }

    # Use array of potential numbers in numerical descending sort order
    # to determine if any are divisible by 3
    foreach my $num_2_try (sort { $b <=> $a } @numbers_to_try) {
	# return the first (biggest) number found
	return $num_2_try unless $num_2_try % 3;
    }
    return -1 #default return value of -1 if no number found
}

__END__

=head1 Challenge 245, Task 2: Largest of Three, by IanRifkin

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the given integers in any order which is also multiple of 3. Return -1 if none found.

Example 1
Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0
Example 2
Input: @ints = (8, 6, 7, 1, 0)
Output: 8760
Example 3
Input: @ints = (1)
Output: -1

See https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK2 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl [options]

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back




