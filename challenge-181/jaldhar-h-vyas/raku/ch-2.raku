#!/usr/bin/raku

sub MAIN() {
    my %temperatures;

    for 'temperature.txt'.IO.lines -> $line {
        chomp $line;
        my ($date, $temperature) = split q{, }, $line;
        %temperatures{$date} = $temperature;
    }

    my $previousTemp = ∞;

    for %temperatures.keys.sort({ $^a cmp $^b }) -> $k {
        if %temperatures{$k} > $previousTemp {
            say $k;
        }
        $previousTemp = %temperatures{$k};
    }
}