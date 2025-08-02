#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ [$_.words] });
    my $specials = 0;

    for @matrix.keys -> $row {
        for @matrix[$row].keys -> $col {
            if @matrix[$row;$col] == 1 &&
            @matrix[$row;*].sum == 1 &&
            @matrix[*;$col].sum == 1 {
                $specials++;
            }
        }
    }

    say $specials;
}