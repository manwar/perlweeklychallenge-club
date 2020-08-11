#!/usr/bin/perl6

sub MAIN( Str $var ) {
    my $newvar = $var;
    $($newvar) = 42;

    say "$var = ", $($newvar);
}