# Test: perl6 ch-1.p6
use v6.d;

sub MAIN() {
    my $minutes_on = calculate-lights-on();

    say 'Lights on for: ' ~
        $minutes_on ~
        ' minutes';
}

# Calculate the minutes lights were on
sub calculate-lights-on {
    my %time_on; # Sample in minutes
    my $time_re = /\d\d\:\d\d/;

    for data().lines -> $line {
        next unless $line ~~
            /.*?($time_re).*?($time_re)/;

        # Get the time in absolute minutes
        my $t1 = absolute-minutes($0);
        my $t2 = absolute-minutes($1);

        %time_on{$t1 .. ($t2 -1)} = 1;
    }

    return %time_on.elems;
}

# Convert to absolute mins.
sub absolute-minutes($hh_mm) {
    my ($hh, $mm) = $hh_mm.split(':');
    return $hh * 60 + $mm;
}

# The data
sub data {
    return q:to/END/;
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
END
}
