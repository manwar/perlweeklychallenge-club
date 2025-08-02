#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(shuffle);

while (<>) {
    print for map { jumble($_) } split /\b/;
}

sub jumble {
    my $word = shift;
    return $word if length $word < 4;
    return $word if $word !~ /\w/;
    my @letters = split //, $word;
    return $letters[0] . (join '', shuffle @letters[1 .. $#letters - 1]) . $letters[-1];
}

__END__
