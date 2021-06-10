#!/usr/bin/env raku

use Test;
plan 3;

is IO::Spec::Unix.canonpath("/a/"), "/a";

is IO::Spec::Unix.canonpath("/a/b//c/"), "/a/b/c";

is IO::Spec::Unix.canonpath("/a/b/c/../..", :parent), "/a";
