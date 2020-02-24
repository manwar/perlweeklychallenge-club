#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my ($size) = @ARGV;
die "$size isn't an int! \n" if $size =~ /\D/;
$size = 3 unless $size;
say "set cache size to $size";

set(1, 3);
set(2, 5);
set(3, 7);
get(2);
get(1);
get(4);
set(4, 9);
get(3);

my (%cache, @keys);

sub set {
    my ($key, $value) = @_;
    push @keys, $key;
    $cache{$key} = $value;
    say "key order.. @keys";
}

sub get {
    my $key = shift;
    say $cache{$key};
    say "key order.. @keys";
}
