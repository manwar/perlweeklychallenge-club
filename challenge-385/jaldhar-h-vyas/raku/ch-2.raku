#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $level = 0;
    my $result = q{};

    for $str.comb -> $c {
        if $c eq q{(} {
            if $level > 0 {
                $result ~= $c;
            }
            $level++;
        }
        elsif $c eq q{)} {
            $level--;
            if $level > 0 {
                $result ~= $c;
            }
        }
    }

    say "\"$result\"";
}
