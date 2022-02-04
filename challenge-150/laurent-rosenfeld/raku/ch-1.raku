use v6;

sub fibonacci (Int $a, Int $b where $a.chars == $b.chars) {
    my ($c, $d) = $a < $b ?? ($a, $b) !! ($b, $a);
    my @fib = $c, $d, * ~ * ... *.chars >= 51;
    # say @fib;
}
say (fibonacci 1234, 5678)[*-1].comb[50];
