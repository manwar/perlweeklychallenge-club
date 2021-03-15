#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Permute;

my $B = $ARGV[0] || "101100101";
my $S = $ARGV[1] || 3;

die "(length of $B) " . ( length $B ) . " % $S = " . ( ( length $B ) % $S ) . ", must be 0"
  if ( ( length $B ) % $S != 0 );

my @substrings   = get_sequences($B);
my $permutations = get_permutations($S);
my %result       = %{ get_number_of_flips( $permutations, \@substrings ) };

print_output( $B, $S, \%result, \@substrings );

sub get_number_of_flips {
    my ( $p, $s ) = @_;

    my @sequences = @$s;

    my $shortest_distance;
    my $shortest_target = $sequences[0];

    while ( my @res = $p->next ) {
        my $sum = 0;

        foreach (@sequences) {
            my $bits = join "", @res;
            $sum += hemming_distance( $_, $bits );
        }

        if ( !$shortest_distance || $sum < $shortest_distance ) {
            $shortest_distance = $sum;
            $shortest_target   = join "", @res;
        }
    }

    return { target => $shortest_target, flips => $shortest_distance };
}

sub get_sequences {
    my ($b) = @_;

    my @digits = split //, $b;

    my @substrings;
    while (@digits) {
        my $sequence;
        for ( my $i = 0 ; $i < $S ; $i++ ) {
            $sequence .= shift @digits;
        }
        push @substrings, $sequence;
    }

    return @substrings;
}

sub get_permutations {
    my ($number_of_digits) = @_;

    my @tmp;
    for ( 1 .. $number_of_digits ) {
        push @tmp, 0;
        push @tmp, 1;
    }

    return Algorithm::Permute->new( \@tmp, $number_of_digits );
}

sub hemming_distance {
    my ( $first, $second ) = @_;

    my @a = split "", $first;
    my @b = split "", $second;

    my $distance = 0;

    my $i = 0;
    foreach (@a) {
        if ( $a[$i] ne $b[$i] ) {
            $distance++;
        }
        $i++;
    }

    return $distance;
}

sub print_output {
    my ( $b, $s, $result, $substrings ) = @_;

    print "Input: \$B = $b, \$S = $s\nOutput: $result->{flips}\n\nBinary Substrings:\n";

    @substrings = @$substrings;

    foreach (@substrings) {
        my $distance = hemming_distance( $_, $result->{target} );
        print "\"$_\": $distance flip ";
        print "to make it $result->{target}" if ( $distance > 0 );
        print "\n";
    }
}
