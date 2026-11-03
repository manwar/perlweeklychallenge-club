#!/usr/bin/raku

sub MAIN(
    $start,
    $current,
    $csv
) {
    my @streams = $csv.IO.lines.map({ [$_.split(',')] });

    my $elapsed = ($current - $start) * 1000;
    my $runtime = 0;

    LOOP: loop {
        for @streams -> ($length, $description) {
            if $elapsed >= $runtime && $elapsed <= $runtime + $length {
                say $description;
                my $position = ($elapsed - $runtime) div 1000;
                say sprintf('%02d:%02d:%02d', $position div 3600,
                    $position mod 3600 div 60, $position mod 60);
                last LOOP;
            }
            $runtime += $length;
        }
    }
}
