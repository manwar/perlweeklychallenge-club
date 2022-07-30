#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

=begin comment
Task 2: Perfect Totient Numbers     Submitted by: Mohammad S Anwar
Generate first 20 Perfect Totient Numbers. See wikipedia page for info.

Output:
3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
2187, 2199, 3063, 4359, 4375, 5571
=end comment

sub ϕ ( Int(Rat) $n where * > 0 ) {
    ($n «×« ( ([1…$n] »÷» $n).grep: { .denominator == $n })).elems;
}

constant @totient = gather { take (Int);  take .&ϕ for 1…∞; }

constant @perfect-totient = gather {
    take (Int);
    for 1…∞ -> $candi {
        my $tot = $candi;
        my @tot;
        until $tot == 1 { @tot.push: $tot = @totient[$tot]; }
        take $candi if $candi == [+] @tot;
    }
}

constant TEST=False;
if TEST {
    my @Test-totient =
        (Int), 1, 1, 2, 2, 4, 2, 6, 4, 6, 4, 10, 4, 12, 6, 8, 8, 16, 6,
        18, 8, 12, 10, 22, 8, 20, 12, 18, 12, 28, 8, 30, 16, 20, 16,
        24, 12, 36, 18, 24, 16, 40, 12, 42, 20, 24, 22, 46, 16, 42,
        20, 32, 24, 52, 18, 40, 24, 36, 28, 58, 16, 60, 30, 36, 32,
        48, 20, 66, 32, 44;

    my @Test-perfect-totient = (Int),
        3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
        2187, 2199, 3063, 4359, 4375, 5571, 6561, 8751, 15723, 19683,
        36759, 46791, 59049, 65535, 140103, 177147, 208191, 441027,
        531441, 1594323, 4190263, 4782969, 9056583, 14348907, 43046721;

    my $ct = 20;
    plan @Test-totient.end + $ct;

    for 1..@Test-totient.end -> $i {
        is ϕ($i), @Test-totient[$i], "totient of $i";
    }

    for 1..$ct -> $i {
        is @perfect-totient[$i], @Test-perfect-totient[$i],
                "\@perfect-totient[$i]";
    }
    done-testing;
    exit;
}

my $ct = 20;
say "The first $ct perfect-totients (ugh, give me 77 seconds or so): ";
for 1..$ct  {
    FIRST {
        print "  @perfect-totient[$_]";
        next;
    }
    print ", @perfect-totient[$_]";
    $*OUT.flush;
    LAST { say '.'}
}

