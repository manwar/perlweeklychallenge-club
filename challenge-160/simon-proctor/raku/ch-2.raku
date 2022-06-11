#!/usr/bin/env raku

#| Given a list of numbers print any equilibrium indicies. Print -1 if there are none
sub MAIN( *@a ) {
    my $out = -1;
    my $e = @a.end; for ( 0..$e ) -> $i {
        if ( ([+] @a[^$i]) ~~ ([+] @a[$i^..$e]) ) {
            say $i;
            $out = '';
        }
    }
    say $out if $out;
}
