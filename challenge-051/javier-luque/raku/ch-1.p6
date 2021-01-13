# Test: perl6 ch-1.p6
use v6.d;

sub MAIN() {
    my @L = (-25, -10, -7, -3, 2, 4, 8, 10).sort;

    loop (my $i = 0; $i < @L.elems - 2; $i++) {
        my $start = $i + 1;
        my $end   = @L.elems - 1;
        while ($start < $end) {
            if (@L[$i] + @L[$start] + @L[$end] == 0) {
                say "@L[$i] + @L[$start] + @L[$end] = 0";
                $start = $start + 1;
                $end = $end -1
            } elsif (@L[$i] + @L[$start] + @L[$end] > 0) {
                $end = $end -1;
            } else {
                $start = $start + 1;
            }
        }
    }
}
