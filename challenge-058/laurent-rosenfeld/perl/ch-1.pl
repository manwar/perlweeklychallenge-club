use strict;
use warnings;
use feature "say";
use Test::More tests => 5;

sub cmp_versions {
    my ($v1, $v2) = @_;
    s/_/.00/g for ($v1, $v2);
    my @a1 = split /[._]/, $v1;
    my @a2 = split /[._]/, $v2;
    $a1[2] = 0 unless defined $a1[2];
    $a2[2] = 0 unless defined $a2[2];
    $a1[0] <=> $a2[0] || $a1[1] cmp $a2[1] || $a1[2] cmp $a2[2];
}

is cmp_versions('0.1', '1.1'), -1, "Two-part version numbers";
is cmp_versions('2.0', '1.2'), 1, "Two-part version numbers";
is cmp_versions('1.2', '1.2.5'), -1, "Two-part and three-part version numbers";
is cmp_versions('1.2.1', '1.2_1'), 1, "With underscore";
is cmp_versions('1.2.1', '1.2.1'), 0, "Three-part version numbers";
