use v5.36;

ARG: for (@ARGV) {
    my $s = 0;
    for my $d (reverse 0 .. 9) {
        say($d), next ARG if ($s += /$d/) == 2;
    }
    say -1;
}
