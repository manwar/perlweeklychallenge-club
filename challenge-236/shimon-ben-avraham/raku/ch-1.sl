#! /usr/bin/env raku

# Perl Weekly Challenge #236 Task 1
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 25 Sep 2023 04:25:50 PM EDT
# Version 0.0.1

# begin-no-weave
# always use the latest version of Raku
use v6.*;
# end-no-weave

=begin pod
=TITLE Challenge # 236 Task 1, Exact Change

=head1 Submitted by: Mohammad S Anwar

=head1 The Challenge

You are asked to sell juice each costs $5. You are given an array of bills. You
can only sell ONE juice to each customer but make sure you return exact change
back. You only have $5, $10 and $20 notes. You do not have any change in hand
at first.

Write a script to find out if it is possible to sell to each customers with
correct change.

=head2 Example 1

=begin code :lang<bash>
Input: @bills = (5, 5, 5, 10, 20)
Output: true

From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.
=end code

=head2 Example 2

=begin code :lang<bash>
Input: @bills = (5, 5, 10, 10, 20)
Output: false

From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bill.
For the last customer, we can not give the change of $15 back because we only have two $10 bills.
Since not every customer received the correct change, the answer is false.

=end code

=head2 Example 3
=begin code :lang<bash>

Input: @bills = (5, 5, 5, 20)
Output: true

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


