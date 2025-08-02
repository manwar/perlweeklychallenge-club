#!raku

#
# Perl Weekly Challenge 302
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-302>
#

sub MAIN( Int :$x, Int :$y, *@str ) {

    my %solutions;

    for @str.permutations -> $array {
	my @current-set;

	for $array.Array -> $_ {

	    if ( @current-set.join.grep( * ~~ 0 ).elems <= $y
		&& @current-set.join.grep( * ~~ 1 ).elems <= $x ) {
		@current-set.push: $_;
	    }
	    else {
		last;
	    }

	}

	%solutions{ @current-set.elems }.push: @current-set if ( @current-set );
    }

    %solutions.keys.max.say;
}
