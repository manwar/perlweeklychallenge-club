#!/usr/bin/raku

sub MAIN (
    *@array  where { @array.elems > 1; } #= array of Integers
) {
    my %degrees;

    for @array -> $n {
        %degrees{$n}++;
    }

    my $degree = %degrees{%degrees.keys.sort({ %degrees{$^b} <=> %degrees{$^a} }).first};

    my @results;
    for %degrees.keys.grep({ %degrees{$_} == $degree }) -> $key {
        my $start = @array.first($key, :k);
        my $end = @array.first($key, :k, :end);
        @results.push(@array[$start .. $end]);
    }

    say q{(} ~ @results.sort({$^a.elems <=> $^b.elems }).first.join(q{, }) ~ q{)};
}