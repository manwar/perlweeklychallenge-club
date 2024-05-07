#!/usr/bin/raku

sub checkMatrix(@matrix) {
    my $left = 0;
    my $right = @matrix[0].end;

    for @matrix.keys -> $row {
        for @matrix[$row].keys -> $col {
            if $col == $left || $col == $right {
                if @matrix[$row;$col] == 0 {
                    return False;
                }
            } else {
                if @matrix[$row;$col] != 0 {
                    return False;
                }
            }
        }
        $left++;
        $right--;
    }

    return True;
}

sub MAIN(
    *@args
) {
    say checkMatrix(@args.map({ [$_.words] }));
}