use v5.36;
sub task2 ( $word ) {
    my @c = split '', $word;

    my @k = grep { $c[$_] =~ /[aeiou]/i } keys @c;

    @c[@k] = reverse @c[@k];

    return ucfirst lc join '', @c;
}


my @tests = (
    [ qw<Raku  Ruka> ],
    [ qw<Perl  Perl> ],
    [ qw<Julia Jaliu> ],
    [ qw<Uiua  Auiu> ],

    [ qw<Bcdf  Bcdf> ],
    [ qw<Alphabet  Elphabat> ],
    [ qw<Zoologicoarchaeologist Ziologecaarchoiologost> ],
);
use Test::More; plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is task2($in), $expected, "$in -> $expected";
}
