use v6
use Test;
plan 5;

sub cmp-versions ($v1 is copy, $v2 is copy) {
    constant %order = reverse Order.enums;
    s:g/_/.00/ for $v1, $v2;
    my @a1 = split /<[._]>/, $v1;
    my @a2 = split /<[._]>/, $v2;
    $_[2] = 0 unless defined $_[2] for @a1, @a2;
    return %order{@a1[0] <=> @a2[0] || @a1[1] <=> @a2[1]
        || @a1[2] cmp @a2[2]};
}

is cmp-versions('0.1', '1.1'), -1, "Two-part version numbers";
is cmp-versions('2.0', '1.2'), 1, "Two-part version numbers";
is cmp-versions('1.2', '1.2.5'), -1, "Two-part and three-part version numbers";
is cmp-versions('1.2.1', '1.2_1'), 1, "With underscore";
is cmp-versions('1.2.1', '1.2.1'), 0, "Three-part version numbers";
