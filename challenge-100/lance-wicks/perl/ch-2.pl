use strict;
use warnings;

use lib './lib';
use Triangle;

my $tri = Triangle->new;

# usage:
# perl ch-2.pl [[1], [2,4], [6,4,9], [5,1,7,2]]
# perl ch-2.pl [[3], [3,1], [5,2,3], [4,3,1,3]]

my @triangle = parse(@ARGV);

print "The minimum path sum: ";
print $tri->min_path_sum( \@triangle );
print "\n";

sub parse {
    my @rows = @_;
    my @triangle;

    for my $row (@rows) {
        $row =~ s/\[//g;
        $row =~ s/\]//g;

        my @values = split ',', $row;
        push @triangle, \@values;
    }

    return @triangle;
}
