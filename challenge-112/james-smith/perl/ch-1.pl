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
is( can_path('/a/../b/../c/../../..'), '/' );
is( can_path('/../../../a/'), '/a' );

done_testing();

sub can_path {
  my($p,@parts) = (1,grep { $_ ne '' && $_ ne '.' } split m{/}, $_[0]);
  $parts[$p] ne '..' ? $p++ : $p>0 ? splice @parts,--$p,2 : shift @parts while $p < @parts;
  return '/'.join '/',@parts;
}

