#!/usr/bin/env perl
# Perl weekly challenge 112
# Task 1: Canonical path
#
# See https://wlmb.github.io/2021/05/12/PWC112/#task-1-canonical-path
use strict;
use warnings;
use v5.12;
use Cwd qw(cwd);

my $cwd=cwd; # Current working directory, for relative paths
for my $input(@ARGV){ #provide paths in @ARGV
    my $path=$input;
    $path = "$cwd/$path" unless $path=~m{^/}; # relative -> absolute path
    $path.="/"; #add temporal trailing slash as guard
    while($path=~s{//}{/}){}; # remove //
    while($path=~s{/\./}{/}){}; # remove all /.
    while($path=~s{/[^/]+?/\.\./}{/}){}; # remove all /dir/..
    while($path=~s{^/(\.\./)+}{/}){}; # remove all leading  /..
    $path=~s{^(/.*)/$}{$1}; # remove trailing / if not first
    say "Input: $input Output: $path";
}
