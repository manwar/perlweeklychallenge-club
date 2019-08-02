#!/bin/env perl

use Modern::Perl;
use List::Util qw(reduce);

sub common_prefix {
    my ($a, $b) = @_;
    my @a = split //, $a;
    my @b = split //, $b;

    my $r = '';
    my $i = 0;
    while ($a[$i] && $b[$i] && $a[$i] eq $b[$i]) {
        $r .= $a[$i++];
    }

    return $r;
}

chomp(my @paths = <>);
my $common_path = reduce { common_prefix($a, $b) } @paths;

my @c = split //, $common_path;
pop @c while $c[-1] ne '/';
pop @c if @c > 1;

say 'common directory path: ', join('', @c);
