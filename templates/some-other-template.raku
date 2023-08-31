#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 

=SUBTITLE
=head2 Submitted by

=CHALLENGE
=head2

=head3 Example 1:

=head3 Example 2:

=head3 Example 3:

=head3 Example 4:

=head3 Example 5:

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub my-sub () {
;
} # end of sub my-sub ()

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => (), output => Nil, text => 'Example ' },
    ];

    for @tests {
        is my-sub( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )


