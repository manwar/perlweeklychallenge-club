#!raku

#
# Perl Weekly Challenge 225
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
#

sub MAIN( *@sentences ) {
    my %data;
    %data{ $_ } = $_.split( /\s/ ).elems for @sentences;
    %data.values.max.say;
}
