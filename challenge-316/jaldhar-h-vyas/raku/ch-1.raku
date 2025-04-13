#!/usr/bin/raku

sub MAIN(
    *@list
) {
    my $circular = True;

    for 1 .. @list.end -> $i {
        if @list[$i].substr(0, 1) ne @list[$i - 1].substr(*-1, 1) {
            $circular = False;
            last;
        }
    }

    say $circular;
}
