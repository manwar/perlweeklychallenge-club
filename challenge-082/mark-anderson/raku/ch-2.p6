#
# using the algorithm from 
# https://www.geeksforgeeks.org/find-if-a-string-is-interleaved-of-two-other-strings-dp-33/
#

unit sub MAIN($A, $B, $C where .chars == $A.chars + $B.chars);

say is-interleaved($A, $B, $C);

sub is-interleaved($A, $B, $C) {
    return 1 if [==] ($A.chars, $B.chars, $C.chars, 0);

    return 0 unless $C.chars;

    my ($a, $b, $c)                = map { $_.substr: 0, 1 }, ($A, $B, $C);
    my ($a-rest, $b-rest, $c-rest) = map { $_.substr: 1},     ($A, $B, $C);

    return +($a eq $c and is-interleaved($a-rest, $B, $c-rest)) || 
           +($b eq $c and is-interleaved($A, $b-rest, $c-rest));
}
