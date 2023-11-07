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
my @arr1 = (1, 2, 3);
my @arr2 = (2, 4, 6);
say find_members(\@arr1, \@arr2);

#Example 2
@arr1 = (1, 2, 3, 3);
@arr2 = (1, 1, 2, 2);
say find_members(\@arr1, \@arr2);

sub find_members {
    my (@arrays) = @_;

    my $output = 'Everything matches'; #default output string
    my $other_arr = 1; #b/c I need to diff both directions
    for (my $i = 0; $i < @arrays; $i++) {
	my $arr = $arrays[$i];
	my $arr_other = $arrays[$other_arr];

	# Checking what numbers are only in $arr
	my %arr_hash = map {$_=>1} @{$arr_other};
	my @diffs = grep { !$arr_hash{$_} } @{$arr};
	# Making sure each item in array is unique
	my @unique;
	my %seen;
	foreach my $value (@diffs) {
	    if (! $seen{$value}) {
		push @unique, $value;
		$seen{$value} = 1;
	    }
	}
	# Creating output text if applicable
	if ($output eq 'Everything matches') {
	    $output = '[' . join(',', @unique) . ']' if @diffs;
	}
	else {
	    $output .= ', [' . join(',', @unique) . ']' if @diffs;	    
	}
	# now switch to comparing the other direction
	$other_arr = 0;
    }
    # Return output to be printed with paranthesis to match task instructions
    return '(' . $output . ')';
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




