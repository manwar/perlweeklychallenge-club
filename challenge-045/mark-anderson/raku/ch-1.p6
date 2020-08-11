#!/usr/bin/env perl6

# Usage: perl6 ch-1.p6 the quick brown fox jumps over the lazy dog

sub MAIN(*@args) {
    my $string = @args.join || "thequickbrownfoxjumpsoverthelazydog";

    my @array.push: [.split({}, :skip-empty)] for $string.comb(8);

    @array[*-1].push: " " for @array[*-1].elems..7;

    @array = [Z] @array;

    $_ = .join.trim-trailing for @array;

    say @array.join: " ";
}
