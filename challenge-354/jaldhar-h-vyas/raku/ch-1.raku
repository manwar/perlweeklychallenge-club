#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @sorted = @ints.sort({ $^a <=> $^b });
    my %mins;

    for 1 .. @sorted.end -> $i {
        my $minAbsDiff = @sorted[$i] - @sorted[$i - 1];
        %mins{$minAbsDiff}.push( [ @sorted[$i - 1], @sorted[$i] ] );
    }

    %mins{ %mins.keys.min }
        .map({ q{[} ~ $_.join(q{', '}) ~ q{]} })
        .join(q{, })
        .say;
}
