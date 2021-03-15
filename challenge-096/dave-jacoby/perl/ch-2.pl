#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{min};

my @input;
push @input, [qw{ kitten sitting }];
push @input, [qw{ sunday monday }];
push @input, [qw{ slight lights }];
push @input, [qw{ fed feed }];
push @input, [qw{ test test }];
push @input, [qw{ test text }];

for my $x (@input) {
    edit_distance( $x->@* );
}

# I first found the Levenshtein distance when poking in the center of
# perlbrew. This is how it knows, when you type `perlbrew xeec` to
# suggest you try `perlbrew exec` instead. This gives us the first
# part, the number of changes you'd need to get from S1 to S2. I thought
# about but never implemented it as a kind-of 404 page for endpoints:
# you look like you're looking for "index" but typed "idnex", for example.

# What we don't get from editdist is WHICH changes those would be.
# therefore, it's a half-solution for this problem.

sub edit_distance ( $s1, $s2 ) {
    editdist( $s1, $s2 );
}

# let's try to make this a whole solution
sub editdist ( $s1, $s2 ) {
    my @s1 = split //, $s1;
    my @s2 = split //, $s2;
    my @d;
    $d[$_][0] = $_ for ( 0 .. @s1 );
    $d[0][$_] = $_ for ( 0 .. @s2 );

    # this creates a two-dimensional array that starts like this:
    #   [0,1,2,3,4,5,6]
    #   [1, , , , , , ]
    #   [2, , , , , , ]
    #   [3, , , , , , ]
    #   [4, , , , , , ]
    #   [5, , , , , , ]
    # which gets filled in iteratively in the nested loops below

    for my $i ( 1 .. @s1 ) {
        for my $j ( 1 .. @s2 ) {

            # Let's understand this. For a particular i and j position
            # if the two agree, D[i][j] equals D[-i][-j]

            # if they don't however, we find the value above
            # the value before and the one above and before, find
            # the lowest, and add one.

            # this means that $d[-1][-1] would have the total

            $d[$i][$j] = (
                  $s1[ $i - 1 ] eq $s2[ $j - 1 ]
                ? $d[ $i - 1 ][ $j - 1 ]
                : 1 + min(
                    $d[ $i - 1 ][$j],
                    $d[$i][ $j - 1 ],
                    $d[ $i - 1 ][ $j - 1 ]
                )

            );
        }
    }

    print <<"END";

    Input: S1: $s1 
           S2: $s2
    Change Count:  $d[-1][-1]
END

    my @operations = find_changes( \@d, \@s1, \@s2 );

    my $c = 1;
    for my $operation ( reverse @operations ) {
        say qq{        Operation $c: $operation};
        $c++;
    }

    # returns the last column of the last row, which SHOULD
    # be the min changes.
    return $d[-1][-1];
}

# d  = 2-dimensional array, result of LD
# s1 = array of first input
# s2 = array of second input
# i  = current row
# j  = current column

sub find_changes ( $d, $s1, $s2, $i = -1, $j = -1 ) {

    # -1 means implicit end of array, which gets turned
    # into explicit end of array
    $i = $i == -1 ? -1 + scalar $d->@*       : $i;
    $j = $j == -1 ? -1 + scalar $d->[-1]->@* : $j;

    # zero means that there are no more changes
    return if $d->[$i][$j] == 0;

    my $v  = $d->[$i][$j];
    my $v1 = $d->[ $i - 1 ][ $j - 1 ];
    my $v2 = $d->[$i][ $j - 1 ];
    my $v3 = $d->[ $i - 1 ][$j];

    my @output;
    if (0) {

        # The impossible situation we never planned for.
        # I LIKE to put an if ( false ) statement first,
        # so it's easy to just move the elsifs around
        # should I decide or discern that I have the order
        # wrong.
    }
    elsif ( $v1 == $v - 1 ) {
        my $c1 = $s1->[ $i - 1 ];
        my $c2 = $s2->[ $j - 1 ];
        push @output, qq{replace '$c1' with '$c2'};
        push @output, find_changes( $d, $s1, $s2, $i - 1, $j - 1 );
    }
    elsif ( $v2 == $v - 1 ) {
        my $c1 = $s1->[ $i - 1 ];
        my $c2 = $s2->[ $j - 1 ];
        if ( $j == scalar $s2->@* ) {
            push @output, qq{insert '$c2' at the end};
        }
        else { push @output, qq{insert '$c2'}; }
        push @output, find_changes( $d, $s1, $s2, $i, $j - 1 );
    }
    elsif ( $v3 == $v - 1 ) {
        my $c1 = $s1->[ $i - 1 ];
        my $c2 = $s2->[ $j - 1 ];
        push @output, qq{remove '$c1' from beginning} if $i == 1;
        push @output, qq{remove '$c1'}                if $i != 1;
        push @output, find_changes( $d, $s1, $s2, $i - 1, $j );
    }
    elsif ( $v1 == $v ) {
        push @output, find_changes( $d, $s1, $s2, $i - 1, $j - 1 );
    }
    elsif ( $v2 == $v ) {
        push @output, find_changes( $d, $s1, $s2, $i, $j - 1 );
    }
    elsif ( $v3 == $v ) {
        push @output, find_changes( $d, $s1, $s2, $i - 1, $j );
    }
    return @output;
}

# -------------------------------------------------------------------
# straight copy of Wikipedia's "Levenshtein Distance"
sub levenshtein_distance {
    my ( $f, $g ) = @_;
    my @a = split //, $f;
    my @b = split //, $g;

    # There is an extra row and column in the matrix. This is the
    # distance from the empty string to a substring of the target.
    my @d;
    $d[$_][0] = $_ for ( 0 .. @a );
    $d[0][$_] = $_ for ( 0 .. @b );

    for my $i ( 1 .. @a ) {
        for my $j ( 1 .. @b ) {
            $d[$i][$j] = (
                  $a[ $i - 1 ] eq $b[ $j - 1 ]
                ? $d[ $i - 1 ][ $j - 1 ]
                : 1 + min(
                    $d[ $i - 1 ][$j],
                    $d[$i][ $j - 1 ],
                    $d[ $i - 1 ][ $j - 1 ]
                )
            );
        }
    }
    return $d[@a][@b];
}

