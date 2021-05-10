#!/bin/env raku

sub MAIN(Str:D $path where * ~~ rx{^'/'}) {
    my @dirs = $path.split(rx{'/'+}).tail(*-1);     # put all directory names into an array, omit first empty element
    @dirs.pop unless @dirs[*-1];                    # omit last element if it is empty
    my $i = 0;
    try {
        while $i < @dirs.elems {
            given @dirs[$i] {
                when '.'  { @dirs.splice($i, 1) }           # omit '.'
                when '..' { @dirs.splice($i-1, 2); --$i; }  # omit '..' and its upper directory
                default   { ++$i }
            }
        }

        CATCH {
            $*ERR.put: 'cannot walk beyond root';   # guard against excessive '..'s
            exit;
        }
    }

    put '/', @dirs.join('/');
}
