#!/usr/bin/env raku
# https://theweeklychallenge.org/blog/perl-weekly-challenge-162/
# https://en.wikipedia.org/wiki/ISBN

sub MAIN( Str $isbn ) {
    my @digits = $isbn.trans( (/<[ \s \- ]>/  => '') ).comb;
    given @digits.elems {
        when 13 { 
            my $digit-to-check = @digits.pop;
            my $checkdigit = checksum(@digits);
            if $digit-to-check == $checkdigit {
                say "Your checkdigit '$digit-to-check'",
                    " matches our calculated digit '$checkdigit'";
            } else {
                say "Your checkdigit '$digit-to-check'",
                    " does NOT match our calculated digit '$checkdigit'";
            }
        }
        when 12 {
            my $checkdigit = checksum(@digits);
            say "Your checkdigit is '$checkdigit'";
        }
        default { say "Not a valid ISBN: '$isbn'" };
    }
}

sub checksum( @digits where {(.all ~~ /^\d$/) and (@digits.elems == 12 )}) {
    my $checkdigit = (@digits Z* <1 3 1 3 1 3 1 3 1 3 1 3>).sum mod 10;
    return $checkdigit == 0 ?? 0 !! 10 - $checkdigit; 
}
