#!/usr/bin/env raku
use Test;

is common-path(< /a/b/c/1/x.pl
                 /a/b/c/d/e/2/x.pl
                 /a/b/c/d/3/x.pl
                 /a/b/c/4/x.pl
                 /a/b/c/d/5/x.pl >), '/a/b/c';

is common-path(< /ab/bc/cd/de/ef 
                 /ab/bc/cd/de/fg/gh/hi
                 /ab/bc/cd/de
                 /ab/bc/cd/de/xy >), '/ab/bc/cd/de';

is common-path(< /a/b/c
                 /a/c/e
                 /a/d/z >), '/a';

is common-path(< /a/b/c
                 /b/c/d
                 /c/d/e >), q{};

sub common-path(+@dirs)
{
    @dirs .= map({ .split('/').List });
    my $z  = ([Zeq] @dirs).List;
    my $i  = $z.first({ not $_ }, :k) || $z.elems;
    @dirs.head[^$i].join('/')
}
