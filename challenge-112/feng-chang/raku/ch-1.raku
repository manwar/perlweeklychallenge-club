#!/bin/env raku

sub MAIN(Str:D $path where * ~~ rx{^'/'}) {
    my @dirs = $path.split(rx{'/'+}).tail(*-1);
    @dirs.pop unless @dirs[*-1];
    my $i = 0;
    try {
        while $i < @dirs.elems {
            given @dirs[$i] {
                when '.'  { @dirs.splice($i, 1) }
                when '..' { @dirs.splice($i-1, 2); --$i; }
                default   { ++$i }
            }
        }

        CATCH {
            $*ERR.put: 'cannot walk beyond root';
            exit;
        }
    }

    put '/', @dirs.join('/');
}
