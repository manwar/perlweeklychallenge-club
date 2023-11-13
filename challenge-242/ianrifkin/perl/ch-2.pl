use v5.30.3;
use warnings;
use strict;

use Getopt::Long;
use Pod::Usage;

# You are given two arrays of integers.
# Write a script to find out the missing members in each other arrays.

my $man = 0;
my $help = 0;
GetOptions ('help|?' => \$help, man => \$man)
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;


# Example 1
my @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0]);
say matrix_flip(@matrix);

# Example 2
@matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]);
say matrix_flip(@matrix);

sub matrix_flip {
    my @matrix_rows = @_;
    my @new_matrix = ();
    
    foreach my $row (@matrix_rows) {
	#the actual flipping - use reverse to swap order and the map to flip values
	my @new_row = '[' . join (", ", reverse map {$_ == 0 ? 1 : 0} @{$row}) . ']';
	push (@new_matrix, @new_row);
    }
    return '(' . join (", ", @new_matrix) . ')';
}


__END__

=head1 Challenge 242, Task 2, by IanRifkin: Flip Matrix

Given a "n x n" binary matrix, this script will flip the given matrix by revering each row then inverting each member.

See https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK2 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-2.pl

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back




    
