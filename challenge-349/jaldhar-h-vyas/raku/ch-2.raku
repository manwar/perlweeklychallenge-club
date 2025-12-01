#!/usr/bin/raku

sub follow($path) {
    my $col = 0;
    my $row = 0;

    for $path.comb -> $direction {
        given $direction {
            when 'U' {
                $row--;
            }
            when 'D' {
                $row++;
            }
            when 'L' {
                $col--;
            }
            when 'R' {
                $col++
            }
            default {
            }
        }

        if $col == 0 && $row == 0 {
            return True;
        }
    }

    return False;
}

sub MAIN(
    $path
) {
    say follow($path);
}