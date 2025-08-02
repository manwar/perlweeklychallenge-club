#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ [$_.words] });
    my $maxOnes = 0;
    my $maxRow = 0;

    for @matrix.keys -> $row {
        my $ones = @matrix[$row].grep({ $_ == 1 }).elems;
        if $ones > $maxOnes {
            $maxOnes = $ones;
            $maxRow = $row + 1;
        }
    }

    say $maxRow;
}