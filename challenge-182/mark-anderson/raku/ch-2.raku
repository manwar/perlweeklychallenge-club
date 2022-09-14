#!/usr/bin/env raku
use Test;

is common-path(< /a/b/c/1/x.pl
                 /a/b/c/d/e/2/x.pl
                 /a/b/c/d/3/x.pl
                 /a/b/c/4/x.pl
                 /a/b/c/d/5/x.pl >), '/a/b/c';

is common-path(< /a/b/c/d/e 
                 /a/b/c/d/f/g
                 /a/b/c/d
                 /a/b/c/d/
                 /a/b/c/d/x >), '/a/b/c/d';

is common-path(< /a/e/c
                 /a/e/e/
                 /a/d/f
                 /a/e/f
                 /a/e/g/ >), '/a';

is common-path(< /a/b/c
                 /b/c/d
                 /b/c/e
                 /b/d/e/
                 /c/d/e >), '/';

is common-path(< /a/b/c
                 /a/c/d
                 /
                 /a/d/e/
                 /a/d/e >), '/';

sub common-path(+@dirs)
{
    @dirs .= map({ .split('/').List });
    my $z  = ([Zeq] @dirs).List;
    my $i  = $z.first({ .not }, :k) || $z.elems;
    @dirs.head[^$i].join('/') || '/'
}
