#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 236 Task 1: Exact Change
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

sub sort_num( @values ) {
    return sort { $a <=> $b } @values;
}

sub exact_change_1( @bills ) {
    @bills = sort_num @bills;
    my %cash = ();
    for ( @bills ) {
	vsay "we are given \$$_";
	my $change_to_return = $_ - 5;

	if ( $change_to_return == 0 ) {
	    vsay "    no need to return any change";
	    ++$cash{$_};
	    next;
	}

	# Start returning change with the highest bills available.
	for ( reverse sort_num keys %cash ) {
	    while ( $cash{$_} && $_ <= $change_to_return ) {
		vsay "    returning a \$$_ bill";
		--$cash{$_};
		$change_to_return -= $_;
	    }
	}

	# Check whether we returned all the necessary change.
	if ( $change_to_return > 0 ) {
	    vsay "    we don't have the right change";
	    return 0; 
	}

	# Accept  the customer's bill.
	++$cash{$_};
	vsay "    accepting the customer's \$$_ bill";
	vsay "    cash now: ", join( " ",
	    map { ( "\$$_" ) x $cash{$_} } sort_num keys %cash );
    }
    return 1;
}

sub exact_change_2( @bills ) {
    @bills = sort_num @bills;
    my %cash = ();
    for ( @bills ) {

	# Accept  the customer's bill.
	++$cash{$_};

	# We need to give this change:
	my $change_to_return = $_ - 5;

	# Starting with the highest bills available,
	# return bills that are lower than or equal to
	# the change we need to return.
	for ( reverse sort_num keys %cash ) {
	    while ( $cash{$_} && $_ <= $change_to_return ) {
		--$cash{$_};
		$change_to_return -= $_;
	    }
	}
	#
	# No success.
	return 0
	    if $change_to_return > 0;
    }
    return 1;
}

sub exact_change( @bills ) {

    # Keep a count of the bills we have, separately for each value. 
    my %cash = ();

    # Serve all the customers,
    # making sure we accept the lowest bills first, for getting change.
    for ( sort_num @bills ) {

	# Accept  the customer's bill.
	++$cash{$_};

	# We need to give this change:
	my $change_to_return = $_ - 5;

	# Starting with the highest value available,
	# return bills that are lower than or equal to
	# the change we need to return.
	for ( reverse sort_num keys %cash ) {
	    while ( $_ <= $change_to_return && $cash{$_} ) {
		--$cash{$_};
		$change_to_return -= $_;
	    }
	}

	# No success if we couldn't return the correct change.
	return 0
	    if $change_to_return > 0;
    }
    # Success.
    return 1;
}

run_tests;
