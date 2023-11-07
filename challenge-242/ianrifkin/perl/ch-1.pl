use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;
use Data::Dumper;

# You are given two arrays of integers.
# Write a script to find out the missing members in each other arrays.

my $man = 0;
my $help = 0;
GetOptions ('help|?' => \$help, man => \$man)
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Example 1
my @arr1 = (1, 2, 3);
my @arr2 = (2, 4, 6);
say find_members(\@arr1, \@arr2);

#Example 2
@arr1 = (1, 2, 3, 3);
@arr2 = (1, 1, 2, 2);
say find_members(\@arr1, \@arr2);

sub find_members {
    my ($arr1, $arr2) = @_;

    my @result_hashes = (
	{map { $_ => check_if_exists($_, $arr2) } @{$arr1}},
	{map { $_ => check_if_exists($_, $arr1) } @{$arr2}}
	);

    # Parse hashed results into an @output array
    # output array will have two values (one for each input)
    my @output = ();    
    foreach (@result_hashes) {
	my %h = %{$_};
	my @tmp_out = ();
	# Select the hash key if the value is false
	# --meaning that the number did not exist in the other array
	foreach my $key ( keys %h ) { 
	    push(@tmp_out, $key) unless $h{$key};
	}
	# The step of putting \@tmp_out into @output
	# -- is so we have separation from results of
	# -- the two inputs
	push(@output, \@tmp_out) if @tmp_out;
    }

    # Return the @output array in the desired format
    $Data::Dumper::Terse = 1; #don't print VAR names
    $Data::Dumper::Indent = 0; #keep output on one line
    return '(' . join(',', Dumper(@output)) . ')';
}

sub check_if_exists {
    my ($k, $arr) = @_;
    return 1 if grep /$k/, @{$arr};
    return 0;
}

__END__

=head1 Challenge 242, Task 1, by IanRifkin: Missing Members

Given an input of two arrays, this script will find the missing members from each input array.

Example 1 inputs: (1, 2, 3) and (2, 4, 6)

Example 2 inputs: (1, 2, 3, 3) and (1, 1, 2, 2)

See https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK1 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back




