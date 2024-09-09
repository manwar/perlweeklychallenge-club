#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @words;
open my $self, '<', __FILE__ or die $!;
while (<$self>) {
    push @words, split;
}
say $words[ rand @words ];
