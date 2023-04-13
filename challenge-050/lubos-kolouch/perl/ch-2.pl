#!/usr/bin/perl
use strict;
use warnings;

sub find_noble_integer {
    my @list = @_;
    @list = sort { $a <=> $b } @list;

    for (my $i = 0; $i < scalar @list - 1; $i++) {
        if ($list[$i] == $list[$i + 1]) {
            next;
        }
        if ($list[$i] == scalar(@list) - $i - 1) {
            return $list[$i];
        }
    }
    return;
}

my @L = (2, 6, 1, 3);
my $noble_integer = find_noble_integer(@L);

if (defined $noble_integer) {
    print "Noble Integer: $noble_integer\n";
} else {
    print "No Noble Integer found\n";
}

