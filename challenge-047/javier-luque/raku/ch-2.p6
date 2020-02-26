# Test: perl6 ch-2.p6
use v6.d;

sub MAIN () {
    my $n = 100;
    my $p = 0;

    while ($p < 20) {
        $n ~~ /^(\d)\d*(\d)$/;
        my $g_divisor = $0 ~ $1;

        if ($n %% $g_divisor) {
            $p++;
            say $n ~ ' / ' ~ $g_divisor ~
                ' = ' ~ ($n / $g_divisor);
        }

        $n++;
    }
}
