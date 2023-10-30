#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Sat 30 Sep 2023 10:08:24 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;


multi MAIN (#| A list of unique integers
            *@input where .all ~~ Int &&
                          .unique.elems == .elems,
            #| Show debug prints when True
            Bool :v($verbose) = False
        ) {

    my Int @ints          = @input>>.Int;
    my Int $num-elems     = @ints.elems;
    my Int $start-pointer = 0;
    my Int $cur-index     = $start-pointer;

    my @cur-loop  = [];
    my @all-loops = [];

    INDEX:
    while $start-pointer.defined {

        my $cur-value  = @ints[$cur-index];
        my $next-index = $cur-value;

        @cur-loop.push: $cur-value;
        @ints[$cur-index] = Nil;
        if $verbose {
            dd @ints;
            dd $start-pointer;
            dd $cur-index;
            dd $next-index;
            dd $cur-value;
            dd @cur-loop;
        } # end of if $verbose

        given $next-index {

            when * ≥ $num-elems {
                say "\e[31mFound single-item loop[s]:\e[0m ",
                    @cur-loop.map({"[$_]"}).join(' ') if $verbose;
                @all-loops.push: $_ for @cur-loop;
            } # end of when * ≥ $num-elems

            when $start-pointer {
                say "\e[32mFound a loop:\e[0m ",
                    @cur-loop.join(" ") if $verbose;
                @all-loops.push: @cur-loop.clone;
            } # end of when $start-pointer

            default {
                say "\e[33mContinuing loop:\e[0m ",
                    @cur-loop.join(" ") if $verbose;
                $cur-index = $cur-value;
                next INDEX;
            } # end of default

        } # end of given $next-index

        @cur-loop = [];
        $start-pointer = $cur-index = @ints.first(*.defined, :k);

        say "\e[34m\nStarting new loop at index $start-pointer\e[0m"
            if $start-pointer.defined && $verbose;
    } # end of while $start-pointer.defined

    say "\n\n\e[35mAll loops:\n" ~ @all-loops.join("\n") ~ "\e[0m\n"
        if $verbose;

    print "Number of loops: " if $verbose;
    say @all-loops.elems;

    return @all-loops.elems;
} # end of multi MAIN ( )


# multi MAINs to catch invalid input
# The weird matching syntax is because !~~ does not play well with Junctions.
multi MAIN (Bool :$v = False,
            *@input where !(.all ~~ IntStr)) is hidden-from-USAGE {
    note "Input must be a list of *integers*";
    exit 1;
} # end of multi MAIN (*@input where .all !~~ Int)

multi MAIN (*@input where .unique.elems != .elems,
            Bool :v(:$verbose) = False) is hidden-from-USAGE {
    note "Input must be a list of *unique* integers";
    exit 1;
} # end of multi MAIN (*@input where .unique.elems != .elems)

multi MAIN (Bool :v(:$verbose) = False) is hidden-from-USAGE {
    note "Input cannot be empty";
    exit 1;
} # end of multi MAIN ()

#| Handle the case of a single integer array
multi MAIN (Int $i!, Bool :v(:$verbose) = False) is hidden-from-USAGE {
    note "\e[31mFound a single-item loop:\e[0m [$i]" if $verbose;
    say 1;
} # end of multi MAIN (Int $i!

#| Use the option '--test' to run the program with the three examples.
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
