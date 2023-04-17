# The Weekly Challenge 212
# Task 1 Jumping Letters
use v5.30.0;
use warnings;
use List::Util qw/zip/;

sub map_letter {
    my $char = $_[0];
    my $dist = $_[1];
    return chr( ord('A') + (ord($char)-ord('A')+$dist) % 26 ) 
        if $char =~ m/[A-Z]/;
    return chr( ord('a') + (ord($char)-ord('a')+$dist) % 26 ) 
        if $char =~ m/[a-z]/;
}

sub jl {
    my $word = $_[0];
    my @jump = $_[1]->@*;
    die "length not match" unless length $word == scalar @jump;
    return join "", map {map_letter $_->@*} zip [split "", $word], [@jump];
}

use Test::More tests=>2;
ok jl("Perl", [2,22,19,9]) eq "Raku";
ok jl("Raku", [24,4,7,17]) eq "Perl";
