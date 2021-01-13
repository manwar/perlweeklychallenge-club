#!/usr/bin/perl
use 5.020;
use warnings;

sub isLeader {
    my ($n, @arr) = @_;

    for my $elem (@arr) {
        if ($n <= $elem) {
            return undef;
        } 
    }

    return 1;
}

my $l = scalar @ARGV - 1;
say join q{, },
   @ARGV[ grep {  isLeader($ARGV[$_], @ARGV[($_ + 1) .. $l]) } 0 .. $l ];