#!raku

#
# Perl Weekly Challenge 365
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
#

sub MAIN( Str $string, Int $base ) {
    my @alphabet = 'a' .. 'z';
    my $number = $string.comb.map( -> $letter { @alphabet.grep( * ~~ $letter, :k ).first.Int + 1 } ).join;

    my $iteration = $base;
    while ( $iteration-- > 0 ) {
	$number = [+] $number.comb;
    }

    $number.say;

}
