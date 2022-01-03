#!/usr/bin/env perl6
#
#
#       zip-ties-and-dotted-eyes.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

sub dot ( @a1, @a2 ) {
    [+] [Z*] @a1, @a2;
}



say my @a1 = 1, 2, 3;
say my @a2 = 2, 4, 6;   ## a1 • a2 = 28
say dot( @a1, @a2 );
