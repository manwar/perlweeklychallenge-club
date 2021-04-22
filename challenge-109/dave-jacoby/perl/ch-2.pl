#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my $map = <<'END';
              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘
END

four_squares( 1 .. 7 );

sub four_squares ( @array ) {
    my $array = join ', ', @array;
    my $ap    = Algorithm::Permute->new( \@array );
    while ( my @perm = $ap->next ) {
        my $b1   = _box_1(@perm);
        my $b2   = _box_2(@perm);
        next if $b1 != $b2;
        my $b3 = _box_3(@perm);
        next if $b1 != $b3;
        my $b4 = _box_4(@perm);
        next if $b1 != $b4;

        my $a = $perm[0];
        my $b = $perm[1];
        my $c = $perm[2];
        my $d = $perm[3];
        my $e = $perm[4];
        my $f = $perm[5];
        my $g = $perm[6];

        say <<"END";
        a = $a          e = $e
        b = $b          f = $f
        c = $c          g = $g
        d = $d      
        Box1 = a + b     = $a + $b     = $b1
        Box2 = b + c + d = $b + $c + $d = $b2
        Box3 = d + e + f = $d + $e + $f = $b3
        Box4 = f + g     = $f + $g     = $b4
END

    }

}

sub _box_1( @array ) {
    return $array[0] + $array[1];
}

sub _box_2( @array ) {
    return $array[1] + $array[2] + $array[3];
}

sub _box_3( @array ) {
    return $array[3] + $array[4] + $array[5];
}

sub _box_4( @array ) {
    return $array[5] + $array[6];
}
