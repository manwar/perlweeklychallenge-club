#!/usr/bin/raku

sub MAIN(*@args) {
    my (%first, %last);

    for @args -> $arg {
        %first{$arg.substr(0, 1)} = True;
        %last{$arg.substr(*-1, 1)} = True;
    }

    for %first.keys -> $key {
        unless %last{$key}:exists {
            say 0;
            exit;
        }
    }
    say 1;
}

