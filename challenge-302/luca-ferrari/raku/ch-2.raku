#!raku

#
# Perl Weekly Challenge 302
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-302>
#

sub MAIN() {

    my @nums = -3, 2, -3, 2, 4;
    for 0 .. Inf -> $start {
	my $current = $start;
	my $ok = True;

	for @nums {
	    $current += $_;
	    if ( $current < 1 ) {
		$ok = False;
		last;
	    }
	}

	$start.say and exit if ( $ok );
    }
}
