#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 395 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Word Squares

You are given a list of equal lengths words.

Write a script to arrange a set of words into a grid that reading across any row gives the exact same word as reading down its corresponding column.

=head3 Example 1:

Input: @words = ("MA", "AM", "MY", "ME")
Output: ("MA", "AM")

M A
A M

=head3 Example 2:

Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
Output: ("SUN", "USE", "NET")

S U N
U S E
N E T

=head3 Example 3:

Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
Output: ("BOAT", "OGRE", "AREA", "TEAL")

B O A T
O G R E
A R E A
T E A L


=head3 Example 4:

Input: @words = ("CARD", "AREA", "REAR", "DART")
Output: ("CARD", "AREA", "REAR", "DART")

C A R D
A R E A
R E A R
D A R T


=head3 Example 5:

Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")

H E A R T
E M B E R
A B U S E
R E S I N
T R E N D

=end pod

sub word-squares(@words --> List) {
    return List.new if @words.elems == 0;
    my $n = @words[0].chars;
    if @words.map({ .chars != $n}).any {
        die "Unexpected input {@words} has unequal length words";
    }
    return List.new if @words.elems < $n;
    for @words.combinations($n) -> @c {
        for @c.permutations -> @candidate {
            my $good-columns = 0;
            for 0..^$n -> $i {
                my $column = @candidate.map({ .substr($i, 1) }).join;
                last unless $column eq @candidate[$i];
                $good-columns++;
            }
            return @candidate if $good-columns == $n;
        }
    }
    List.new;
}

#| returns the first found word square found within WORDS
multi MAIN(*@words) {
    say word-squares(@words);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("MA", "AM", "MY", "ME"),
                   output => ("MA", "AM")));
    @tests.push(%( input => ("SUN", "USE", "NET", "SEE", "TEN"),
                   output => ("SUN", "USE", "NET")));
    @tests.push(%( input => ("BOAT", "TEAL", "AREA", "TSAR", "OGRE"),
                   output => ("BOAT", "OGRE", "AREA", "TEAL")));
    @tests.push(%( input => ("CARD", "AREA", "REAR", "DART"),
                   output => ("CARD", "AREA", "REAR", "DART")));
    @tests.push(%( input => ("HEART", "TREND", "EMBER", "RESIN", "ABUSE"),
                   output => ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")));
    @tests.push(%( input => (),
                   output => ()));
    @tests.push(%( input => ("",),
                   output => ()));
    @tests.push(%( input => ("A",),
                   output => ("A",)));
    @tests.push(%( input => ("AB","bA"),
                   output => ("bA", "AB")));
    @tests.push(%( input => ("A", "B"),
                   output => ("A",)));
    @tests.push(%( input => ("AAA", "BBB"),
                   output => ()));
    @tests.push(%( input => ("AAA", "BBB", "CCC"),
                   output => ()));
    my @should-throw;
    @should-throw.push(%( input => ("A", "AB") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply word-squares(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { word-squares(.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'AB', 'BA', :out, :err);
    is $proc.out.slurp(:close).trim, '(AB BA)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
