#!raku

#
# Perl Weekly Challenge 364
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-364>
#

sub MAIN( Str $string where { $string ~~ / ^ <[0 .. 9 #]>+ $ / }) {
    my $result = $string;
    my @alphabet = 'a' .. 'z';
    $result .= subst( / ( <[1..2]> <[0..6]> ) '#'/,
		      { @alphabet[ $/[0].Int - 1 ] } ,
						     :g );

    $result .= subst( / (<[1 .. 9 ]>) /, { @alphabet[ $/[ 0 ].Int - 1 ] }, :g );
    say $result;
}
