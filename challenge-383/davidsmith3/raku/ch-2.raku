#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 383 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Nearest RGB

You are given a 6-digit hex color.

Write a script to round the RGB channels to the nearest web-safe value and return the nearest RGB color.

00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)

=head3 Example 1:

Input: $color = "#F4B2D1"
Output: "#FF99CC"

Red: F4 (Decimal 244), closer to 255 => FF
Green: B2 (Decimal 178), closer to 153 => 99
Blue: D1 (Decimal 209), closer to 204 => CC
So the nearest RGB: "#FF99CC"

=head3 Example 2:

Input: $color = "#15E6E5"
Output: "#00FFCC"

Red: 15 (Decimal 21), closer to 0 => 00
Green: E6 (Decimal 230), closer to 255 => FF
Blue: E5 (Decimal 229), closer to 204 => CC

=head3 Example 3:

Input: $color = "#191A65"
Output: "#003366"

Red: 19 (Decimal 25), closer to 0 => 00
Green: 1A (Decimal 26), closer to 51 => 33
Blue: 65 (Decimal 101), closer to 102 => 66

=head3 Example 4:

Input: $color = "#2D5A1B"
Output: "#336633"

Red: 2D (Decimal 45), closer to 51 => 33
Green: 5A (Decimal 90), closer to 102 => 66
Blue: 1B (Decimal 27), closer to 51 => 33

=head3 Example 5:

Input: $color = "#00FF66"
Output: "#00FF66"

Red: 00 (Decimal 0), closer to 0 => 00
Green: FF (Decimal 255), closer to 255 => FF
Blue: 66 (Decimal 102), closer to 102 => 66

=end pod

my $hex-digit = / <[A..F0..9]> /;

sub nearest-rgb(Str:D $color --> Str:D) {
    my $match = $color ~~ / ^ '#' ($hex-digit ** 2) ** 3 $ /;
    die "Unexpected input $color" unless $match;
    '#' ~ $0.map({ :16(~$_).round(51).fmt('%02X') }).join;
}

#| return the nearest web-safe color
multi MAIN(Str:D $color) {
    say nearest-rgb($color);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "#F4B2D1", output => "#FF99CC" ));
    @tests.push(%( input => "#15E6E5", output => "#00FFCC" ));
    @tests.push(%( input => "#191A65", output => "#003366" ));
    @tests.push(%( input => "#2D5A1B", output => "#336633" ));
    @tests.push(%( input => "#00FF66", output => "#00FF66" ));
    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "abc" ));
    @should-throw.push(%( input => "#ffffff" ));  # require uppercase
    @should-throw.push(%( input => "#000" ));     # require six digit format

    plan @tests + @should-throw + 3;
    for @tests {
        is nearest-rgb(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { nearest-rgb(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '#191A65', :out, :err);
    is $proc.out.slurp(:close).trim, '#003366', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
