#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @set = (
    [qw/2 6 1 3/], # 2
    [qw/9 3 7 1 6/], # 3
    [qw/17 1/], # 1
    [qw/3 9 12 /] # none
    );

say noble($_) foreach @set;


sub noble {
    my $L = shift;
    @{$L} = sort {$a <=> $b} @{$L};

    my $noble = 0;
    say 'Given set: ', "@{$L}";
    my $last_index = scalar @{$L} - 1;

    foreach my $i (0 .. $#{$L}) {
        $noble = $_->[$i] if $_->[$i] == $last_index - $i;
    }

    return "No Noble integer." unless $noble;
    return "$noble is the Noble integer. \n";
}
