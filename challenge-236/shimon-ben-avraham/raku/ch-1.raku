#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 1
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Sat 30 Sep 2023 11:41:30 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;

multi sub MAIN (
    #| The bills to be used to make change (5, 10, 20)
    *@input where all(@input) ~~ 5|10|20,
    #| Show debug prints when True
    Bool :v($verbose) = False 
    --> Str #Return 'true' if the bills can be used to make change
    ) {

    my Int %bills = (5 => 0, 10 => 0, 20 => 0);
    my Str $retval = 'true';

    for @input -> $bill {
        %bills{$bill}++;

        given $bill {
            when 10 { %bills{5}-- }
            when 20 {
                %bills{5}--;
                %bills{10} > 0
                    ?? (%bills{10} -= 1)
                    !! (%bills{5}  -= 2);
            } # end of when 20
        } # end of given $bills

        note "Received \$$bill, " ~
             "have %bills{5} \$5s, %bills{10} \$10s, and %bills{20} \$20s " ~
             "in the till" if $verbose; #
        if %bills{5} < 0 {
            $retval = 'false';
            last;
        } # end of if %bills{5} < 0
    } # end of for @numbers -> $bill

    say $retval;
    return $retval;;
} # end of multi MAIN (*@input where * == 5|10|20,

# multi MAINs to catch invalid input
multi sub MAIN (*@numbers where all(@numbers) ~~ Int,
                Bool :v(:$verbose)) is hidden-from-USAGE {
    note "The bills can only be 5, 10, or 20 dollars.";
    exit 1;
}

multi sub MAIN(*@args,
               Bool :v(:$verbose)) is hidden-from-USAGE {
    note "Please provide a list of bills.";
    exit 1;
}

#| Use the option '--test' to run the program with the three examples.
multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ got => MAIN(5, 5, 5, 10, 20),
           op => 'eq', expected => 'true', desc => 'Example 1' },
        %{ got => MAIN(5, 5, 10, 10, 20),
           op => 'eq', expected => 'false', desc => 'Example 2' },
        %{ got => MAIN(5, 5, 5, 20),
           op => 'eq', expected => 'true', desc => 'Example 3' },
    ];

    plan +@tests;
    for @tests {
        cmp-ok .<got>, .<op>, .<expected>, .<desc>;
    } # end of for @tests
} # end of multi MAIN (:$test!)