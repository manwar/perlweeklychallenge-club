#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Thu 28 Sep 2023 10:26:18 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;


subset UniqueIntArray of Array where .elems == 0 ||
                                     .unique.elems == .elems and .all ~~ IntStr;

multi MAIN (#| A list of unique integers
            *@input where .all ~~ Int &&
                          .unique.elems == .elems,

            #| Show debug prints when True
            Bool :v($verbose) = False
        ) {

    my Int @ints        = @input>>.Int;
    my Int $num-elems   = @ints.elems;
    my Int $start-index = 0;
    my Int $cur-index   = $start-index;

    my UniqueIntArray $cur-loop;
    my UniqueIntArray @all-loops;

    LOOP:
    while $start-index.defined {

        my $cur-value  = @ints[$cur-index];
        my $next-index = $cur-value;

        $cur-loop.push: $cur-value;
        @ints[$cur-index] = Nil;

        if $verbose {
            dd @ints;
            dd $start-index;
            dd $cur-index;
            dd $next-index;
            dd $cur-value;
            dd $cur-loop;
        } # end of if $verbose

        given $next-index {

            when * ≥ $num-elems {
                say "\e[31mFound singular loop[s]:\e[0m ",
                    $cur-loop.map({"[$_]"}).join(' ') if $verbose;
                @all-loops.push: for $cur-loop;
            }

            when $start-index {
                say "\e[32mFound a loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                @all-loops.push: $cur-loop;
            }

            default {
                say "\e[33mContinuing loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                $cur-index = $cur-value;
                next LOOP;
            }
        } # end of given $next-index

        $cur-loop = [];
        $start-index = $cur-index = @ints.first(*.defined, :k);

        say "\e[34m\nStarting new loop at index $start-index\e[0m"
            if $start-index.defined && $verbose;
    } # end of while $start-index.defined

    say "\n\n\e[35mAll loops:\n" ~ @all-loops.join("\n") ~ "\e[0m\n"
        if $verbose;

    say @all-loops.elems;
    return @all-loops.elems;
} # end of multi MAIN ( )

# Catch invalid input
multi MAIN (*@input where .all !~~ Int) {
    note "Input must be a list of *integers*";
    exit 1;
} # end of multi MAIN (*@input where .all !~~ Int)

multi MAIN (*@input where .unique.elems != .elems) {
    note "Input must be a list of *unique* integers";
    exit 1;
} # end of multi MAIN (*@input where .unique.elems != .elems)

multi MAIN () {
    note "Input cannot be empty";
    exit 1;
} # end of multi MAIN ()

#| Run with the option '--test' to, well, run the tests!
multi MAIN (Bool :$test!) {
    use Test;

    #TODO Handle edge cases.
    #TODO Test 1 integer array
    my @tests = [
        %{ got => MAIN(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10),
           op => '==', expected => 3, desc => 'Example 1' },
        %{ got => MAIN(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19),
           op => '==', expected => 6, desc => 'Example 2' },
        %{ got => MAIN(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17),
           op => '==', expected => 1, desc => 'Example 3' },
    ];

    plan +@tests;
    for @tests {
        cmp-ok .<got>, .<op>, .<expected>, .<desc>;
    } # end of for @tests
} # end of multi MAIN (:$test!)
