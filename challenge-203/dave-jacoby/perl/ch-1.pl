#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };
use Getopt::Long;

my $verbose = 0;

GetOptions(
    'verbose'  => \$verbose,
);


my @examples = (

    [ 1, 2, 3, 6 ],
    [ 1, 1, 1, 3, 5 ],
    [ 3, 3, 6, 4, 5 ]
);

for my $e (@examples) {
    my $list = join ',', $e->@*;
    my $out  = special_quadrant($e);
    say <<"END";
    Input:  \@array = ($list)
    Output: $out
END
}

sub special_quadrant ( $arrayref, $pos = 0, $resultref = [] ) {
    my $output;

    # case: resultref is the right size
    if ( scalar $resultref->@* == 4 ) {
        my @results = $resultref->@*;
        my $sum     = sum0 @results[ 0, 1, 2 ];
        if ( $sum == $results[3] ) {
            say join ' ', @results if $verbose;
            return 1;
        }
        return 0;
    }

    # case: we've run out of data
    return 0 if !defined $arrayref->[$pos];

    my $newref = [];
    $newref->@* = $resultref->@*;
    $output +=
        special_quadrant( $arrayref, $pos + 1, $newref ); # don't include this
    push $newref->@*, $arrayref->[$pos];
    $output +=
        special_quadrant( $arrayref, $pos + 1, $newref );    # include this
    return $output;
}

sub is_odd ( $n ) {
    return $n % 2 ? 1 : 0;
}
