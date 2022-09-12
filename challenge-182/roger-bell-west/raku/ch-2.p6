#! /usr/bin/perl6

use Test;

plan 1;

is(commonpath([
                     "/a/b/c/1/x.pl",
                     "/a/b/c/d/e/2/x.pl",
                     "/a/b/c/d/3/x.pl",
                     "/a/b/c/4/x.pl",
                     "/a/b/c/d/5/x.pl"
                 ]), "/a/b/c", 'example 1');

sub commonpath(@p) {
    my @pa;
    my @pl;
    for @p -> $sp {
        my @q = split("/",$sp);
        @pl.push(@q.elems);
        @pa.push(@q);
    }
    my @out;
    for (0..min(@pl)-1) -> $cl {
        my $ex = False;
        my $tx = @pa[0][$cl];
        for (@pa) -> @pe {
            if (@pe[$cl] ne $tx) {
                $ex = True;
                last;
            }
        }
        if ($ex) {
            last;
        }
        @out.push($tx);
    }
    return @out.join("/");
}
