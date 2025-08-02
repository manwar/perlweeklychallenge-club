#!/usr/bin/perl6

sub time2minutes($time) {
    my ($hours, $minutes) = $time.split(q{:});
    return $hours * 60 + $minutes;
}

sub MAIN() {
    my $earliest = ∞;
    my $latest = -∞;

    for './guestbook.txt'.IO.lines -> $line {
        my ($in, $out) = ($line.words)[3,5].map({ time2minutes($_) });
        if $in < $earliest {
            $earliest = $in;
        }

        if $out > $latest {
            $latest = $out;
        }
    }

    say 'The lights were on for ', $latest - $earliest, ' minutes.';
}
