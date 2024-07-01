#!/usr/bin/raku

sub MAIN(
    $sentance
) {
    my $repeat = 1;

    $sentance
        .words
        .map({
            /^ (<-[AaEeIiOoUu]>) (\S+)/ ?? "$1$0" !! $_;
        })
        .map({
            $_ ~ 'ma' ~ ('a' x $repeat++);
        })
        .join(q{ })
        .say;
}