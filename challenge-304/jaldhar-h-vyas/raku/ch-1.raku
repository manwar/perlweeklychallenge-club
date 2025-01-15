#!/usr/bin/raku

sub MAIN(
    $n,
    *@args
) {
    my @digits = @args;
    my $replacements = 0;

    for 1 .. @digits.end -> $i {
        if @digits[$i - 1] == 0 && @digits[$i] == 0  {
            @digits[$i] = 1;
            $replacements++;
        }
    }

    my $result = False;

    if $replacements >= $n {
        $result = True;

        for 1 .. @digits.end -> $i {
            if @digits[$i - 1] == 1 && @digits[$i] == 1 {
                $result = False;
                last;
            }
        }
    }

    say $result;
}
