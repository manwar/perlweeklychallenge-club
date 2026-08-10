#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
383-2: Nearest RGB          Submitted by: Mohammad Sajid Anwar

You are given a 6-digit hex color.  Write a script to round the RGB
channels to the nearest web-safe value and return the nearest RGB color.
Safe RGB values are 0x00, 0x33, 0x66, 0x99, 0xCC, and 0xFF.
=end comment

my @Test =
    # in            exp         in          exp
    "#F4B2D1",  "#FF99CC",      "#15E6E5",  "#00FFCC",
    "#191A65",  "#003366",      "#2D5A1B",  "#336633",
    "#00FF66",  "#00FF66",
;

plan +@Test ÷ 2;

# For a R, G or B value, expressed like 'F9', return the closest pure value.
sub pure4web( Str:D $primary --> Str) {
    my $n = $primary.parse-base: 16;
    given $n {
        when    0..25  { '00' }             # ??? secret magic
        when   26..76  { '33' }
        when  77..127  { '66' }
        when 128..178  { '99' }
        when 179..229  { 'CC' }
        when 230..255  { 'FF' }
        default        { die 'ErrDom' }
    }
}

# Round the three 0-to-255 values of a RGB code using the magic above.
sub task( Str:D(Any) $a where { m/ ^ '#' <[0..9A..F]>**6 $ / } -->Str) {
    my @val = $a.substr(1).comb(2);
    return '#' ~ (@val».&pure4web).Array.join;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;

my $color = "#1ACF19";
say qq{\nInput: \$color = $color\nOutput: "&task($color)"};
