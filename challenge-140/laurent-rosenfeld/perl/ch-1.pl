use strict;
use warnings;
use feature "say";

sub add_bin {
    my ($c, $d) = @_;
    ($d, $c) = ($c, $d) if $d > $c;
    my $result = "";
    my @c = reverse split //, $c;
    my @d = reverse split //, $d;
    my $carry = 0;   # carry over
    for my $i (0 .. $#c){
        my $e = $d[$i] // 0;
        my $t = $c[$i] + $e + $carry;
        $result .= $t and $carry = 0 if $t <= 1;
        if ($t == 2) {
            $result .= 0;
            $carry = 1;
        } elsif ($t == 3) {
            $result .= 1;
            $carry = 1;
        }
    }
    $result .= ($carry == 0 ? '' : $carry == 1 ? 1 : '01');
    return scalar reverse $result;
}
for my $test ( [11, 1], [101, 1], [100, 11], [100, 100], [1011, 11]) {
    say "@$test\t=> ", add_bin @$test;
}
