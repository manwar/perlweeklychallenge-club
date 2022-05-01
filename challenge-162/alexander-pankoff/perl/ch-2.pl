#!/usr/bin/env perl

=pod
Task 2: Wheatstone-Playfair
Submitted by: Roger Bell_West

Implement encryption and decryption using the Wheatstone-Playfair cipher.

Examples:

  (These combine I and J, and use X as padding.)
 
  encrypt("playfair example", "hide the gold in the tree stump") = "bmodzbxdnabekudmuixmmouvif"
 
  decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"
=cut

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();

use lib File::Spec->catdir( $FindBin::RealBin,
    qw'.. .. .. challenge-001 alexander-pankoff perl lib' );

package challenge162::ch2;

run() unless caller();

sub run() {
    say WheatstonePlayfairCipher::encrypt( "playfair example",
        "Hide the gold in the tree stump" );
    say WheatstonePlayfairCipher::decrypt( "Perl and Raku",
        "siderwrdulfipaarkcrw" );

}

package WheatstonePlayfairCipher {

    use List::Util qw(uniq);
    use My::String::Util qw(implode explode);
    use My::List::Util qw(flatten zip chunks_of without);

    sub encrypt ( $keyphrase, $cleartext ) {
        my @keytable = _build_keytable($keyphrase);
        _run_ciper( $cleartext, \@keytable );
    }

    sub decrypt ( $keyphrase, $ciphertext ) {
        my @keytable = _build_keytable($keyphrase);
        _run_ciper( $ciphertext,
            [ reverse( map { [ reverse(@$_) ] } @keytable ) ] );
    }

    sub _run_ciper ( $input, $keytable ) {
        $input =~ s/[^a-z]//gi;

        # Split same chars in an even position using an 'x'. 'xx' will be kept
        # as is and later treated by the same row rule.
        while ( $input =~ s/^((?:.{2})*?)([^x])\2/$1$2x$2/i ) { }

        my @chars = explode( lc($input) );
        if ( @chars % 2 ) {
            push @chars, 'x';
        }

        my @bigrams = chunks_of( 2, @chars );

        my @transformed_bigrams =
          map { _transform_bigram( $_, $keytable ) } @bigrams;

        my $transformed = implode( flatten(@transformed_bigrams) );
        return $transformed;
    }

    sub _transform_bigram ( $bigram, $keytable ) {
        my ( $first, $second ) = @$bigram;

        my %positions =
          flatten( zip( [ flatten( @{$keytable} ) ], [ 0 .. 24 ] ) );
        $positions{'j'} = $positions{'i'};

        my $real_pos = sub($x) { ( int( $x / 5 ), $x % 5 ) };

        my ( $first_row,  $first_col )  = $real_pos->( $positions{$first} );
        my ( $second_row, $second_col ) = $real_pos->( $positions{$second} );

        if ( $first_row == $second_row ) {
            return [
                $keytable->[$first_row][  ( $first_col + 1 ) % 5 ],
                $keytable->[$second_row][ ( $second_col + 1 ) % 5 ],
            ];
        }

        if ( $first_col == $second_col ) {
            return [
                $keytable->[ ( $first_row + 1 ) % 5 ][$first_col],
                $keytable->[ ( $second_row + 1 ) % 5 ][$second_col],
            ];
        }

        return [
            $keytable->[$first_row][$second_col],
            $keytable->[$second_row][$first_col],
        ];

    }

    sub _build_keytable($keyphrase) {
        $keyphrase = lc($keyphrase);
        $keyphrase =~ s/[^a-z]//g;
        $keyphrase =~ s/j/i/g;
        my @alphabet = ( 'a' .. 'i', 'k' .. 'z' );
        my @keyphrase_letters =
          uniq( explode( lc($keyphrase) ) );
        my @remaining = without( \@alphabet, \@keyphrase_letters );

        return chunks_of( 5, @keyphrase_letters, @remaining );
    }
}

