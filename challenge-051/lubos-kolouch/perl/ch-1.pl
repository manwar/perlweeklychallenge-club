#!/usr/bin/perl
use strict;
use warnings;

sub find_unique_triplets {
    my ( $target, @list ) = @_;
    @list = sort { $a <=> $b } @list;

    my @triplets;
    my $len = scalar @list;

    for ( my $i = 0 ; $i < $len - 2 ; $i++ ) {
        my $left  = $i + 1;
        my $right = $len - 1;

        while ( $left < $right ) {
            my $sum = $list[$i] + $list[$left] + $list[$right];

            if ( $sum == $target ) {
                push @triplets, [ $list[$i], $list[$left], $list[$right] ];
                $left++;
                $right--;
            }
            elsif ( $sum < $target ) {
                $left++;
            }
            else {
                $right--;
            }
        }
    }

    return \@triplets;
}

my @L      = ( -25, -10, -7, -3, 2, 4, 8, 10 );
my $target = 0;

my $triplets = find_unique_triplets( $target, @L );
foreach my $triplet ( @{$triplets} ) {
    print "[" . join( ", ", @{$triplet} ) . "]\n";
}
