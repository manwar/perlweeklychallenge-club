#!raku

#
# Perl Weekly Challenge 272
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
#

sub MAIN( Str $ip is copy
	  where { $ip ~~ /^ ( \d ** 1..3 '.' ) ** 3 \d ** 1..3  / } ) {

    $ip .= subst( '.', '[.]', :g );
    $ip.say;
}
