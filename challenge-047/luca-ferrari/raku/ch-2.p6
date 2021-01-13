#!env raku
#
# Perl Weekly Challenge 47
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/>
#
# Task 2
# Gapful Number
#
# Write a script to print first 20 Gapful Numbers greater than or equal to 100.
# Please check out the page for more information about Gapful Numbers.
# From <https://oeis.org/A108343>
# Gapful numbers >= 100: numbers that are divisible by the number
# formed by their first and last digit.
# Numbers up to 100 trivially have this property and are excluded.



sub MAIN( Int:D :$limit = 20 ) {

    my @found;
    for 100 .. Inf {
        $_ ~~ / ^ $<first>=\d \d+ $<last>=\d $ /;
        my $divisor = ( $/<first> ~ $/<last> ).Int;
        @found.push: $divisor if $_ %% $divisor && ! @found.grep: { $_ == $divisor };
        last if @found.elems == $limit;
    }

    "Here it is what I found, first $limit Gapful Numbers:\n".say;
    @found.sort.join( "\n\t" ).say;
}
