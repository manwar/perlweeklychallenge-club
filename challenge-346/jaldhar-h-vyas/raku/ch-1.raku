#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $max = 0;
    my @stack = (-1);

    for $str.comb.kv -> $i, $c {
        if $c eq q{(} {
            @stack.push($i);
        } else {
            @stack.pop;
            if @stack.elems == 0 {
                @stack.push($i);
            } else {
                my $len = $i - @stack[*-1];
                if $len > $max {
                    $max = $len;
                }
            }
        }
    }

    say $max;
}
