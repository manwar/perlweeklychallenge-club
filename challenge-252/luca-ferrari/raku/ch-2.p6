#!raku

#
# Perl Weekly Challenge 252
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
#

sub MAIN( $n where { $n >= 3 && $n ~~ Int  } ) {
    my @nums;

    if $n %% 2 {
	@nums.push: $_, $_ * -1 for 1 .. ( $n / 2 );
    }
    else {
	@nums.push: $_, $_ * -1 for 1 .. ( ( $n - 2 ) / 2 );
	my $next = @nums.max + 1;
	@nums.push: $next, $next + 1, ( $next + $next + 1 ) * -1;
    }

    @nums.join( ',' ).say;
}
