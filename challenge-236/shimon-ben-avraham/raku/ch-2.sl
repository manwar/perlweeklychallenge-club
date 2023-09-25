#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 25 Sep 2023 04:22:22 PM EDT
# Version 0.0.1

# begin-no-weave
# always use the latest version of Raku
use v6.*;
# end-no-weave

=begin pod
=TITLE Challenge # 236 Task 2, Array Loops

=head1 Submitted By: Mark Anderson

=head1 The Challenge

You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

=defn
To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.

=head2 Example 1

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

=head2 Example 2

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

=head2 Example 3

=begin code :lang<bash>
Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
Output: 1

Loop is as below:
[9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]
=end code


=head1 The Solution
=end pod


#| The actual program starts here.
multi MAIN ( ) {
    ;
} # end of multi MAIN ( )


=begin pod

=head1 AUTHOR

Shimon Bollinger  (deoac.shimon@gmail.com)

Source can be located at: https://github.com/deoac/... . Comments and
Pull Requests are welcome.

=head1 LICENCE AND COPYRIGHT

© 2023 Shimon Bollinger. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
See L<perlartistic|http://perldoc.perl.org/perlartistic.html>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=end pod

#| Run with the option '--test' to test the program
multi MAIN (:$test!) {
    use Test;

    my @tests = [
        %{ got => '', op => 'eq', expected => '', desc => 'Example 1' },
    ];

    for @tests {
#        cmp-ok .<got>, .<op>, .<expected>, .<desc>;
    } # end of for @tests
} # end of multi MAIN (:$test!)

my %*SUB-MAIN-OPTS =
  :named-anywhere,             # allow named variables at any location
  :bundling,                   # allow bundling of named arguments
#  :coerce-allomorphs-to(Str),  # coerce allomorphic arguments to given type
  :allow-no,                   # allow --no-foo as alternative to --/foo
  :numeric-suffix-as-value,    # allow -j2 as alternative to --j=2
;

#| Run with '--pod' to see all of the POD6 objects
multi MAIN(Bool :$pod!) {
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            $pod-block.raku.say;
        }
    }
} # end of multi MAIN (:$pod)

#| Run with '--doc' to generate a document from the POD6
#| It will be rendered in Text format
#| unless specified with the --format option.  e.g.
#|       --format=HTML
multi MAIN(Bool :$doc!, Str :$format = 'Text') {
    run $*EXECUTABLE, "--doc=$format", $*PROGRAM;
} # end of multi MAIN(Bool :$man!)


