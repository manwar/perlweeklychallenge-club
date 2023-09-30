#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Fri 29 Sep 2023 08:15:33 PM EDT
# Version 0.0.1

# begin-no-weave
# always use the latest version of Raku
use v6.*;
# end-no-weave

=begin pod
=TITLE The Perl Weekly Challenge

=SUBTITLE Submitted By: Mark Anderson

=head2 Challenge #236 Task 2, Array Loops

You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

=defn
To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.

=head3 Example 1

=begin code :lang<bash>
Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
Output: 3

To determine the 1st loop, start at index 0, the number at that index is 4,
proceed to index 4, the number at that index is 15, proceed to index 15 and so
on until you're back at index 0.

Loops are as below:
[4 15 1 6 13 5 0]
[3 8 7 18 9 16 12 17 2]
[14 11 19 10]

=end code

=head3 Example 2

=begin code :lang<bash>
Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
Output: 6

Loops are as below:
[0]
[1]
[13 9 14 17 18 15 5 8 2]
[7 11 4 6 10 16 3]
[12]
[19]
=end code

=head3 Example 3

=begin code :lang<bash>
Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
Output: 1

Loop is as below:
[9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]
=end code


=head2 The Solution


=end pod

=begin pod

=end pod


multi MAIN (#| A list of unique integers
            *@input where .all ~~ Int &&
                          .unique.elems == .elems,

            #| Show debug prints when True
            Bool :v($verbose) = False # no-weave-this-line
        ) {
=begin pod

=end pod

    my Int @ints        = @input>>.Int;
    my Int $num-elems   = @ints.elems;
    my Int $start-index = 0;
    my Int $cur-index   = $start-index;

=begin pod
For type safety, we will create a subset to represent an array of unique
integers.

=end pod

    my $cur-loop  = [];
    my @all-loops = [];

=begin pod
We will create a pointer to the first index of the array and attempt to find
a loop that starts with that element. If we find a loop, we will push it to an array of loops. If we

=end pod

    LOOP:
    while $start-index.defined {
=begin pod

=end pod

        my $cur-value  = @ints[$cur-index];
        my $next-index = $cur-value;

=begin pod

=end pod

        $cur-loop.push: $cur-value;
        @ints[$cur-index] = Nil;

        #begin-no-weave
        if $verbose {
            dd @ints;
            dd $start-index;
            dd $cur-index;
            dd $next-index;
            dd $cur-value;
            dd $cur-loop;
        } # end of if $verbose
        #end-no-weave

=begin pod

=end pod

        given $next-index {
=begin pod

=end pod

            when * ≥ $num-elems {
                #begin-no-weave
                say "\e[31mFound singular loop[s]:\e[0m ",
                    $cur-loop.map({"[$_]"}).join(' ') if $verbose;
                #end-no-weave
                @all-loops.push: $_ for |$cur-loop;
            }
=begin pod

=end pod

            when $start-index {
                # begin-no-weave
                say "\e[32mFound a loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                # end-no-weave
                @all-loops.push: $cur-loop;
            }

=begin pod

=end pod

            default {
                #begin-no-weave
                say "\e[33mContinuing loop:\e[0m ",
                    $cur-loop.join(" ") if $verbose;
                #end-no-weave
                $cur-index = $cur-value;
                next LOOP;
            }
        } # end of given $next-index
=begin pod

=end pod

        $cur-loop = [];
        $start-index = $cur-index = @ints.first(*.defined, :k);

        # begin-no-weave
        say "\e[34m\nStarting new loop at index $start-index\e[0m"
            if $start-index.defined && $verbose;
        # end-no-weave
    } # end of while $start-index.defined

    #begin-no-weave
    say "\n\n\e[35mAll loops:\n" ~ @all-loops.join("\n") ~ "\e[0m\n"
        if $verbose;
    #end-no-weave
=begin pod

=end pod


    say @all-loops.elems;
    return @all-loops.elems;
} # end of multi MAIN ( )


=begin pod

=head1 AUTHOR

Shimon Bollinger  (deoac.shimon@gmail.com)

=comment Source can be located at:
Z<Challenge 236|https://github.com/deoac/perlweeklychallenge-club/tree/master/challenge-236/shimon-ben-avraham raku>

Comments and Pull Requests are welcome.

=head1 LICENCE AND COPYRIGHT

© 2023 Shimon Bollinger. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
See L<perlartistic|http://perldoc.perl.org/perlartistic.html>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=end pod

# begin-no-weave
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
    note "\e[31mFound a singular loop:\e[0m [$i]" if $verbose;
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
# end-no-weave

