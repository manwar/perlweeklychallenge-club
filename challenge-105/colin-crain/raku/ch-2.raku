#!/usr/bin/env perl6
#
#
#       name-game.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $name = 'Katie') ;

make_song($name);

sub make_song ($name) {
    
    $name ~~ m:i/ (<-[aeiouy]>?) (.*) /;
    my ($h, $t) = ( $0, $1.lc );
    
    
    say qq:to/END/; 
        {$name}, {$name}, bo-{$h~~/b/??''!!'b'}{$t},
        Bonana-fanna fo-{$h~~/f/??''!!'f'}{$t}
        Fee fi mo-{$h~~/m/??''!!'m'}{$t}
        {$name}!
    END
}
