#!raku

#
# Perl Weekly Challenge 236
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
#

sub MAIN( *@cash where { @cash.grep( * % 5 == 0 ).elems == @cash.elems } ) {

    my %remainder;
    %remainder{ $_ } = 0 for 5,10,20;

    for @cash -> $current_cash {
	%remainder{ $current_cash }++;
	next if $current_cash == 5;


	if ( $current_cash == 10 and %remainder{ 5 } > 0 ) {
	    %remainder{ 5 }--;
	}
	elsif $current_cash == 20  {
	    if %remainder{ 10 } > 0 && %remainder{ 5 } > 0 {
		%remainder{ 5 }--;
		%remainder{ 10 }--;
	    }
	    elsif %remainder{ 10 } == 0 && %remainder{ 5 } > 3 {
		%remainder{ 5 } -= 3;
	    }
	    else {
		'False'.say and exit;
	    }
	}
	else {
	    # cannot proceed
	    'False'.say and exit;
	}

    }

    'True'.say;
}
