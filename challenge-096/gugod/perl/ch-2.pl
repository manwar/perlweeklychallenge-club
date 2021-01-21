use v5.18;
use List::Util 'min';

## main
my @examples = (
    [ 'kitten', 'sitting' ],
    [ 'sunday', 'monday' ],
);
for my $x (@examples) {
    my ($S1, $S2) = @$x;
    say "Input: \$S1 = $S1, \$S2 = $S2";
    say "Output: " . edit_distance($S1, $S2);
}
exit;

sub edit_distance {
    return lev(@_);
}

sub lev {
    my ($s1, $s2) = @_;

    return length($s1) if length($s2) == 0;
    return length($s2) if length($s1) == 0;

    my $s1_tail = substr($s1, 1);
    my $s2_tail = substr($s2, 1);
    return lev($s1_tail, $s2_tail) if substr($s1, 0, 1) eq substr($s2, 0, 1);
    return 1 + min(
        lev($s1, $s2_tail),
        lev($s1_tail, $s2),
        lev($s1_tail, $s2_tail),
    );
}
