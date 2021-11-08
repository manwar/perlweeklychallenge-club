#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/ TASK #1
my $d = shift || 0;
my $f = BinaryFOO->new();
say $f->nibble_swap($d);
exit;

package BinaryFOO;
sub new {
    return bless {}, shift;
}
sub dec_to_bin {
    my $self = shift;
    my $dec  = shift;
    return sprintf "%b", $dec;
}
sub bin_to_dec {
    my $self = shift;
    my $bin  = shift;
    return oct("0b".$bin);
}
sub is_palidrome {
    my $self = shift;
    my $bin  = shift;
    return ($bin eq reverse($bin));
}
sub nibble_split {
    my $self = shift;
    my $bin  = shift;

    # make sure we have an octet (8 char length minimum)
    $bin = '0'x8 . $bin;
    $bin = substr($bin,-8);
    # split into 2 nibbles
    return (substr($bin,0,4), substr($bin,-4));
}
sub nibble_swap {
    my $self = shift;
    my $dec  = shift;
    return "$dec is greater than 255" if ($dec > 255);
    my @n = $self->nibble_split($self->dec_to_bin($dec));
    return $self->bin_to_dec($n[1].$n[0]);
}
1;

__END__

./ch-1.pl 
0
./ch-1.pl 101
86
./ch-1.pl 18
33
./ch-1.pl 255
255
./ch-1.pl 15 # 00001111 => 11110000
240
./ch-1.pl 240 
15

