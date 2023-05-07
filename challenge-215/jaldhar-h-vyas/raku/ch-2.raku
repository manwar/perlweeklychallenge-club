#!/usr/bin/raku

sub MAIN(
    *@ARGS
) {
    my ($count, @numbers) = @ARGS;
    my $replaced = 0;

    for 0 .. @numbers.end -> $i {
        if
            @numbers[$i] == 0 &&
            ($i == 0 || @numbers[$i - 1] == 0) &&
            ($i == @numbers.end || @numbers[$i + 1] == 0)
        {
            @numbers[$i] = 1;
            $replaced++;
        }

        if $replaced == $count {
            say 1;
            exit;
        }
    }

    say 0;
}