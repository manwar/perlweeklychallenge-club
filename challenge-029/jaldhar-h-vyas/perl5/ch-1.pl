#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub expand {
    my ($string) = @_;
    $string =~ / \{(.+)\} /msx;
 
    return map {
        (my $expansion = $string) =~ s/\{(.+)\}/$_/msx;
        $expansion;
    } split /,\s*/, $1;
}

say for expand($ARGV[0] // q{});