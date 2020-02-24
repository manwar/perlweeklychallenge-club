#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my ($int) = @ARGV;
die "$int isn't an int! \n" if $int =~ /\D/;
say "checking $int";

for (my $i = 1;;$i++){
    my $bin = sprintf("%b", $i);
    say "$bin is the smallest 0/1 multiple of $int" and last unless $bin % $int;
}
