#!raku

#
# Perl Weekly Challenge 364
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-364>
#

sub MAIN( Str $string ) {
    my $result = $string;
    $result .= subst( / '()' /, 'o', :g );
    $result .= subst( / '(al)' /, 'al', :g );
    say $result;
}
