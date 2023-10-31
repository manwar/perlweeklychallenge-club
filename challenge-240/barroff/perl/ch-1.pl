#!/usr/bin/env perl

use v5.38;

sub acronym ( $chk, @str ) {
    lc($chk) eq join( '', map { substr( lc($_), 0, 1 ) } @str ) ? 1 : 0;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say acronym(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is acronym( "ppp", ( "Perl", "Python", "Pascal" ) ), 1,
          'works for "ppp" and ("Perl", "Python", "Pascal")';
        is acronym( "rp", ( "Perl", "Raku" ) ), 0,
          'works for "rp"  and ("Perl", "Raku")';
        is acronym( "oac", ( "Oracle", "Awk", "C" ) ), 1,
          'works for "oac" and ("Oracle", "Awk", "C")';
    }
}

MAIN();
