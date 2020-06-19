#!/usr/bin/env raku

use v6;

sub MAIN (
    Str $target #= String to search for palindromes.
) {
    my $found = False;
    for ^$target.codes -> $start {
        my @palindromes = find-palindromes( $target.substr( $start ) );
        if @palindromes.grep( so * ) {
            $found = True;
            for @palindromes { .join(", ").say };
        }
    }
    say -1 if ! $found;    
}

sub infix:<|,|> (@a,@b) { |@a, |@b }

sub find-palindromes( Str $target ) {
    my @out;
    for 2..$target.codes -> $length {
        my $check = $target.substr( 0, $length );
        if $check ~~ $check.flip {
            my @rest = find-palindromes( $target.substr( $length ) );
            @out = @out |,| ( [ [ $check, ], ] X|,| @rest );
        }
    }
    return @out || [[],];
}
