#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util qw(min);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [B...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

B...
   list $5, $10 and $20 bills
EOS


### Input and Output

say sell_juice(@ARGV) ? 'true' : 'false';


### Implementation

sub sell_juice {
    # At the beginning, the trays for $5, $10 and $20 bills in our cash
    # register are empty. Counting $20 bills, but never return them.
    (\my %register)->@{5, 10, 20} = (0, 0, 0);
    state $price = 5;

    # Try to sell a juice for every given bill.
    for my $bill (@_) {
        # The amount to be returned.
        my $return = $bill - $price;
        # There is only one case, where the action is not uniquely
        # defined: If we are to return $15, have three or more $5 bills
        # and one or more $10 bills.  In this situation we give one $10
        # bill and one $5 bill.
        for my $tray (10, 5) {
            my $cnt = min $register{$tray}, int $return / $tray;
            # Take the bill(s) from the tray and adjust the to be
            # returned amount.
            $register{$tray} -= $cnt;
            $return -= $cnt * $tray;
        }
        # Put the received bill into its tray.
        $register{$bill}++;
        # Fail if we cannot return the exact change.
        return if $return;
    }
    # Here we succeeded.
    1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  sell_juice(5, 5, 5, 10, 20), 'example 1';
        ok !sell_juice(5, 5, 10, 10, 20), 'example 2';
        ok  sell_juice(5, 5, 5, 20), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok sell_juice(5, 5, 5, 5, 10, 20, 10), 'prefer 1x10 + 1x5 over 3x5';
	}

    done_testing;
    exit;
}
