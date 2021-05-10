#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @paths;
push @paths, "/a/";
push @paths, "/a/b/./c/";
push @paths, "/a/b//c/";
push @paths, "/a/b/c/../d/..";
push @paths, "/a/b/c/../..";
push @paths, "/a/b/c/";

for my $path (@paths) {
    my $cpath = canonical_path($path);
    say <<"END";
        path:       $path
        canonical:  $cpath
END
}

sub canonical_path ($path) {
    while ($path =~ m{/\w+/\.\.}mix
        || $path =~ m{//}mix
        || $path =~ m{/\./}mix )
    {
        $path =~ s{/\w+/\.\.}{/}mix;
        $path =~ s{//}{/}mix;
        $path =~ s{/\./}{/}mix;
    }
    $path =~ s{/$}{}mix;
    $path = qq{/$path} unless $path =~ m{^/}mix;
    return $path;
}
