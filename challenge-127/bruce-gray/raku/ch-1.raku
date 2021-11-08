use Test;

sub sets_are_disjoint { + not @^S1 ∩ @^S2 }

my @tests =
    ( 0 => ( (1, 2, 5, 3, 4), (4, 6, 7, 8, 9) ) ),
    ( 1 => ( (1, 3, 5, 7, 9), (0, 2, 4, 6, 8) ) ),
    ( 1 => ( (             ), (             ) ) ),
;
plan +@tests;
for @tests {
    my ($expected, $input) = .kv;
    is sets_are_disjoint(|$input), $expected;
}
