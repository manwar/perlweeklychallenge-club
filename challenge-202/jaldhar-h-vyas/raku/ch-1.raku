#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my $result = 0;

    for 0 .. @args.end - 2 -> $i {
        if @args[$i] % 2 && @args[$i + 1] % 2 && @args[$i + 2] % 2 {
            $result = 1;
            last;
        }
    }

    say $result;
}