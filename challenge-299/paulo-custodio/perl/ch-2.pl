#!/usr/bin/env perl

use Modern::Perl;

my @chars;
while (<>) {
    last if /^\s*$/;
    my @r = split ' ', $_;
    push @chars, \@r;
}
chomp(my $str = scalar(<>));

say word_found($str, @chars) ? "true" : "false";

sub word_found {
    my($str, @chars) = @_;
    return 1 if $str eq '';

    for my $r (0 .. $#chars) {
        for my $c (0 .. $#{$chars[0]}) {
            return 1 if find_snake($r, $c, $str, @chars);
        }
    }

    # not found
    return 0;
}

sub find_snake {
    my($r, $c, $str, @chars) = @_;
    return 1 if $str eq '';
    return 0 if $chars[$r][$c] ne substr($str,0,1);

    $chars[$r][$c] = "#";
    $str = substr($str,1);

    # up
    if ($r > 0) {
        return 1 if find_snake($r-1, $c, $str, @chars);
    }
    # down
    if ($r < $#chars) {
        return 1 if find_snake($r+1, $c, $str, @chars);
    }
    # left
    if ($c > 0) {
        return 1 if find_snake($r, $c-1, $str, @chars);
    }
    # right
    if ($c < $#{$chars[0]}) {
        return 1 if find_snake($r, $c+1, $str, @chars);
    }

    # not found
    return 0;
}
