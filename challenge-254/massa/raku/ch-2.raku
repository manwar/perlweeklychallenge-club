#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Reverse Vowels

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given a string, $s.

Write a script to reverse all the vowels (a, e, i, o, u) in the given string.

=head3 Example 1:

    Input => "Raku"
    Output => "Ruka"

=head3 Example 2:

    Input => "Perl"
    Output => "Perl"

=head3 Example 3:

    Input => "Julia"
    Output => "Jaliu"

=head3 Example 4:

    Input => "Uiua"
    Output => "Auiu"

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION($_) {
    my @reversed-vowels = .lc.flip.comb.grep: /<[aeiou]>/;
    .lc.comb.map({ /<[aeiou]>/ ?? @reversed-vowels.shift !! $_ }).join.samecase($_)
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input => "Raku", output => "Ruka" },
        %{ input => "Perl", output => "Perl" },
        %{ input => "Julia", output => "Jaliu" },
        %{ input => "Uiua", output => "Auiu" },
    ;

    .<input>.&SOLUTION.&is-eqv: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


