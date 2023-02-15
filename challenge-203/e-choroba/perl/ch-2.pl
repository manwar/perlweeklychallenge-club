#!/usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

use File::Find qw{ find };

sub copy_directory($source, $target) {
    my @dirs;
    find({no_chdir => 1,
          wanted   => sub {
              push @dirs, $target . $_ =~ s/^$source//r
                  if $_ ne $source && -d $_ }},
         $source);
    mkdir for @dirs;
}

sub prepare_env {
    mkdir for qw( a a/b a/b/c x x/y ), map "a/b/c/$_", 1 .. 5;
    open my $touch, '>', "a/b/c/$_/$_.txt" for qw( 1 2 3 5 );
}

sub cleanup {
    0 == system 'rm -rf a x' or die $!;
}

use Test2::V0;
plan 2;

{   prepare_env();
    copy_directory('a/b/c', 'x/y');
    my @found;
    find({wanted => sub { push @found, $_ unless /^\.{1,2}$/; }}, 'x/y');
    is \@found, bag { item $_ for 1 .. 5 }, 'Example 1';
    cleanup();
}

{   prepare_env();
    copy_directory('a', 'x/y');
    my @found;
    find({no_chdir => 1,
          wanted => sub { push @found, $_ }}, 'x/y/b/c');
    is \@found, bag { item "x/y/b/c/$_" for 1 .. 5;
                      item 'x/y/b/c'; },
        'Recursion';
    cleanup();
}
