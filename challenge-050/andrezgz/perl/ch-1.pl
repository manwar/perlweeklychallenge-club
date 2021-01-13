#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/
# Task #1
#
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
#
# [2,7], [3,9], [10,12], [15,19], [18,22]
#
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
#
# Similarly it should also merge [15, 19] and [18, 22] together to return [15, 22].
#
# The final result should be something like below:
#
# [2, 9], [10, 12], [15, 22]

use strict;
use warnings;

my $intervals = join ',', @ARGV;
if ($intervals) {
    print merge($intervals);
}
else {
    do_tests();
}

# Test cases borrowed from M. Anwar contributions.
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-050/mohammad-anwar/perl/ch-1.pl
sub do_tests {
    print "TESTS\n";
    test('[1,2]','[1,2]');
    test('[1,2],[3,4]','[1,2],[3,4]');
    test('[3,4],[1,2]','[1,2],[3,4]');

    test('[2,5],[1,2]','[1,5]');
    test('[2,5],[1,3]','[1,5]');
    test('[2,5],[1,5]','[1,5]');
    test('[2,5],[1,6]','[1,6]');
    test('[2,5],[2,3]','[2,5]');
    test('[2,5],[2,5]','[2,5]');
    test('[2,5],[2,6]','[2,6]');
    test('[2,5],[3,4]','[2,5]');
    test('[2,5],[3,5]','[2,5]');
    test('[2,5],[3,6]','[2,6]');
    test('[2,5],[5,6]','[2,6]');

    test('[1,3],[5,7],[-1,0]','[-1,0],[1,3],[5,7]');
    test('[1,3],[5,7],[-1,1]','[-1,3],[5,7]');
    test('[1,3],[5,7],[-1,2]','[-1,3],[5,7]');
    test('[1,3],[5,7],[-1,3]','[-1,3],[5,7]');
    test('[1,3],[5,7],[-1,4]','[-1,4],[5,7]');
    test('[1,3],[5,7],[-1,5]','[-1,7]');
    test('[1,3],[5,7],[-1,6]','[-1,7]');
    test('[1,3],[5,7],[-1,7]','[-1,7]');
    test('[1,3],[5,7],[-1,8]','[-1,8]');

    test('[1,3],[5,7],[1,2]','[1,3],[5,7]');
    test('[1,3],[5,7],[1,3]','[1,3],[5,7]');
    test('[1,3],[5,7],[1,4]','[1,4],[5,7]');
    test('[1,3],[5,7],[1,5]','[1,7]');
    test('[1,3],[5,7],[1,6]','[1,7]');
    test('[1,3],[5,7],[1,7]','[1,7]');
    test('[1,3],[5,7],[1,8]','[1,8]');

    test('[1,3],[5,7],[2,2]','[1,3],[5,7]');
    test('[1,3],[5,7],[2,3]','[1,3],[5,7]');
    test('[1,3],[5,7],[2,4]','[1,4],[5,7]');
    test('[1,3],[5,7],[2,5]','[1,7]');
    test('[1,3],[5,7],[2,6]','[1,7]');
    test('[1,3],[5,7],[2,7]','[1,7]');
    test('[1,3],[5,7],[2,8]','[1,8]');

    test('[1,3],[5,7],[3,3]','[1,3],[5,7]');
    test('[1,3],[5,7],[3,4]','[1,4],[5,7]');
    test('[1,3],[5,7],[3,5]','[1,7]');
    test('[1,3],[5,7],[3,6]','[1,7]');
    test('[1,3],[5,7],[3,7]','[1,7]');
    test('[1,3],[5,7],[3,8]','[1,8]');

    test('[1,3],[5,7],[4,4]','[1,3],[4,4],[5,7]');
    test('[1,3],[5,7],[4,5]','[1,3],[4,7]');
    test('[1,3],[5,7],[4,6]','[1,3],[4,7]');
    test('[1,3],[5,7],[4,7]','[1,3],[4,7]');
    test('[1,3],[5,7],[4,8]','[1,3],[4,8]');

    test('[1,3],[5,7],[5,5]','[1,3],[5,7]');
    test('[1,3],[5,7],[5,6]','[1,3],[5,7]');
    test('[1,3],[5,7],[5,7]','[1,3],[5,7]');
    test('[1,3],[5,7],[5,8]','[1,3],[5,8]');

    test('[1,3],[5,7],[6,6]','[1,3],[5,7]');
    test('[1,3],[5,7],[6,7]','[1,3],[5,7]');
    test('[1,3],[5,7],[6,8]','[1,3],[5,8]');

    test('[1,3],[5,7],[7,7]','[1,3],[5,7]');
    test('[1,3],[5,7],[7,8]','[1,3],[5,8]');

    test('[1,3],[5,7],[8,8]','[1,3],[5,7],[8,8]');

    test('[1,2],[5,6],[3,4]','[1,2],[3,4],[5,6]');
    test('[1,2],[5,6],[2,5]','[1,6]');
    test('[1,1],[2,2],[3,3]','[1,1],[2,2],[3,3]');

    test('[0,6],[7,8],[12,19],[3,8]','[0,8],[12,19]');
    test('[12,14],[15,19],[7,8],[1,12]','[1,14],[15,19]');
    test('[12,17],[18,18],[9,9],[5,17]','[5,17],[18,18]');

    test('[2,7],[3,9],[10,12],[15,19],[18,22]','[2,9],[10,12],[15,22]');
}



sub test {
    my $intervals = shift;
    my $expected = shift;

    my $result = merge($intervals);

    printf "%s %s => %s\n",
           ($result eq $expected) ? '[OK]' : '[ERR]',
           $intervals,
           $result;
}

sub merge {
    my $intervals = shift;
    $intervals =~ s/\s+//; #remove unnecessary spaces

    my %output;

    foreach ( split /\Q],[\E/, $intervals ){
        next unless (/(-?\d+),(-?\d+)/);
        my ($from,$to) = ($1,$2);
        $output{$from} = $to unless exists $output{$from} && $output{$from} >= $to;
    }

    # merge overlapping intervals
    my $prev;
    foreach my $k (sort {$a <=> $b} keys %output){
        if (defined $prev && $output{$prev} >= $k) {
            $output{$prev} = $output{$k} if $output{$k} > $output{$prev};
            delete $output{$k};
        }
        else {
            $prev = $k;
        }

    }

    return join ',', map { qq|[$_,$output{$_}]| }
                     sort {$a <=> $b}
                     keys %output;
}

__END__

./ch-1.pl [0,6],[7,8],[12,19],[3,8]
[0,8],[12,19]

./ch-1.pl [1,3],[5,7],[-1,4]
[-1,4],[5,7]
