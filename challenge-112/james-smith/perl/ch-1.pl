#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( can_path('/a/'), '/a' );
is( can_path('/a/b//c/'), '/a/b/c' );
is( can_path('/a/./b/./c/'), '/a/b/c' );
is( can_path('/a/b/c/../..'), '/a' );
is( can_path('/a/b/../c/..'), '/a' );
is( can_path('/a/../b/../c/..'), '/' );
is( can_path('/a/../b/../c/..'), '/' );
is( can_path('/a/../b/../c/../../..'), '/' );

done_testing();

sub can_path {
  my $l = my @parts = grep { $_ ne '' && $_ ne '.' } split m{/}, $_[0];
  while(--$l>0) {
    if($parts[$l] eq '..' && $parts[$l-1] ne '..' ) {
      splice @parts, $l-1,2;
      $l = @parts;# = @parts;
    }
  }
  shift @parts while @parts && $parts[0] eq '..'; ## Remove any ##
  return '/'.join '/',@parts;
}

