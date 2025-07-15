#!raku

#
# Perl Weekly Challenge 330
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
#

sub MAIN( Str $sentence is copy  ) {
    my @parts;
    for $sentence.split( ' ' )  {
	@parts.push:  $_.Str.chars >= 3 ?? $_.tc !! $_.lc;
    }

    @parts.join( ' ' ).say;
}
