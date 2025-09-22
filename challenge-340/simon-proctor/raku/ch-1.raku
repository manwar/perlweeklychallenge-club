#!/usr/bin/env raku

subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    is strip-dupes('abbaca'), 'ca';
    is strip-dupes('azxxzy'), 'ay';
    is strip-dupes('aaaaaaaa'), '';
    is strip-dupes('aabccba'), 'a';
    is strip-dupes('abcddcba'), '';
    done-testing;
}

multi sub MAIN( Str() $s ) { strip-dupes($s).say; } 

sub strip-dupes( Str $s is copy ) {
    my $old = $s;
    repeat {
        $old = $s;
        $s ~~ s:g/(.)$0//;
    } until ( $old ~~ $s );
    $s;
}

