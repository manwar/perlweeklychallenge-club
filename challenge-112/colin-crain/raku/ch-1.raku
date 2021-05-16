#!/usr/bin/env perl6
#
#
#       where-are-my-friends.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;


use Test;
plan 3;

is canonical("/a/"), "/a"             , 'ex-1';
is canonical("/a/b//c/"), "/a/b/c"    , 'ex-2';
is canonical("/a/b/c/../.."), "/a"    , 'ex-3';


sub canonical($path) {
    my $clean = IO::Spec::Unix.canonpath("$path");
    
    repeat {} while $clean ~~ s| '/' <-[/]>* '/..' ||;
    return $clean;
}
