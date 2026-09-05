#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 389 Task 1

Submitted by: Reinier Maliepaard
=head2 Reorder Notes

You are given an array [composer, notes, permutation], reconstruct the melody by using each permutation value as the destination position of the corresponding note. Use no explicit for, foreach, or while loops. Output each result as COMPOSER => reordered notes.

ASSUMPTION: Input is valid; the notes array and permutation array have identical lengths, and the permutation contains each position from 1 to N exactly once.

=head3 Example 1:

Input: $melody = ['Bach', <C D E F# G A B>, [7, 1, 6, 2, 5, 3, 4]]
Output: BACH => D F# A B G E C

Note 1 (C)  moves to position 7.
Note 2 (D)  moves to position 1.
Note 3 (E)  moves to position 6.
Note 4 (F#) moves to position 2.
Note 5 (G)  moves to position 5.
Note 6 (A)  moves to position 3.
Note 7 (B)  moves to position 4.

=head3 Example 2:

Input: $melody = ['Beethoven', <C D F# G Ab>, [1, 3, 5, 2, 4]]
Output: BEETHOVEN => C G D Ab F#

Note 1 (C)  stays at position 1.
Note 2 (D)  moves to position 3.
Note 3 (F#) moves to position 5.
Note 4 (G)  moves to position 2.
Note 5 (Ab) moves to position 4.

=head3 Example 3:

Input: $melody = [ 'Brahms', <C Db Eb F G Ab Bb C D>, [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
Output: BRAHMS => F Bb Db D Ab C Eb G C

=head3 Example 4:

Input: $melody = [ 'Bruckner', <G F# Bb C D Eb F>, [4, 7, 2, 6, 1, 5, 3] ]
Output: BRUCKNER => D Bb F G Eb C F#

=head3 Example 5:

Input: $melody = ['Berg', <C#>, [1]]
Output: BERG => C#

=end pod

sub reorder-notes(Str:D $composer, @notes, @permutation --> Str) {
    $composer.uc ~
    ' => ' ~
    @notes.pairs.sort({ @permutation[.key] }).map({ .value }).join(" ");
}

#| Given composer, one or more notes, and the permutation array, return the reordered notes
multi MAIN(Str:D $composer, *@rest) {
    my @notes = @rest.grep(/^ \D+ $/);
    my @permutation = @rest.grep(/^ \d+ $/);
    say reorder-notes($composer, @notes, @permutation);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ['Bach', <C D E F# G A B>, [7, 1, 6, 2, 5, 3, 4]],
                   output => "BACH => D F# A B G E C" ));
    @tests.push(%( input => ['Beethoven', <C D F# G Ab>, [1, 3, 5, 2, 4]],
                   output => "BEETHOVEN => C G D Ab F#" ));
    @tests.push(%( input => ['Brahms', <C Db Eb F G Ab Bb C D>, [9, 3, 7, 1, 8, 5, 2, 6, 4] ],
                   output => "BRAHMS => F Bb Db D Ab C Eb G C" ));
    @tests.push(%( input => ['Bruckner', <G F# Bb C D Eb F>, [4, 7, 2, 6, 1, 5, 3] ],
                   output => "BRUCKNER => D Bb F G Eb C F#" ));
    @tests.push(%( input => ['Berg', ["C#"], [1]],
                   output => "BERG => C#" ));

    plan @tests + 3;
    for @tests {
        is reorder-notes(|.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'Mozart', 'A', 'B', '2', '1', :out, :err);
    is $proc.out.slurp(:close).trim, 'MOZART => B A', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
