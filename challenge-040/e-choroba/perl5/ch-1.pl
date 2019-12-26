#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use utf8;

binmode *STDOUT, ':encoding(UTF-8)';

my @arrays = ([qw[ I L O V E Y O U ]],
              [qw[ 2 4 0 3 2 0 1 9 ]],
              [qw[ ! ? £ $ % ^ & * ]]);

for my $i (0 .. $#{ $arrays[0] }) {
    say join ' ', $i, map $_->[$i], @arrays;
}
