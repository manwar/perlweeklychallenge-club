#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( canonical_path('/a/'),                   '/a',     'Remove trailing slash (empty trailing dir)' );
is( canonical_path('//a'),                   '/a',     'Remove empty dir as start' );
is( canonical_path('/a/b//c/'),              '/a/b/c', 'Remove empty dir "//"' );
is( canonical_path('/a/./b/./c/'),           '/a/b/c', 'Remove "." dir ...' );
is( canonical_path('/a/b/c/../..'),          '/a',     'Two ".." together at end' );
is( canonical_path('/a/b/../c/..'),          '/a',     'Two ".." separated (one in middle)' );
is( canonical_path('/a/../b/../c/./.'),      '/c',     'Two ".." separated (both in middle)' );
is( canonical_path('/a/b/../../c'),          '/c',     'Two ".." together in middle' );
is( canonical_path('/a/../b/../c/..'),       '/',      'Same no of ".." as dir' );
is( canonical_path('/a/b/c/../../..'),       '/',      'Same no of ".." as dir - all at end' );
is( canonical_path('/a/../b/../c/../../..'), '/',      'More ".." than dirs' );
is( canonical_path('/../../../a/'),          '/a',     '".." at start, no other ".."' );
is( canonical_path('/../../a/../c/.'),       '/c',     '".." at start, other ".."' );

is( canonical_path_compact('/a/'),                   '/a',     'Remove trailing slash (empty trailing dir)' );
is( canonical_path_compact('//a'),                   '/a',     'Remove empty dir as start' );
is( canonical_path_compact('/a/b//c/'),              '/a/b/c', 'Remove empty dir "//"' );
is( canonical_path_compact('/a/./b/./c/'),           '/a/b/c', 'Remove "." dir ...' );
is( canonical_path_compact('/a/b/c/../..'),          '/a',     'Two ".." together at end' );
is( canonical_path_compact('/a/b/../c/..'),          '/a',     'Two ".." separated (one in middle)' );
is( canonical_path_compact('/a/../b/../c/./.'),      '/c',     'Two ".." separated (both in middle)' );
is( canonical_path_compact('/a/b/../../c'),          '/c',     'Two ".." together in middle' );
is( canonical_path_compact('/a/../b/../c/..'),       '/',      'Same no of ".." as dir' );
is( canonical_path_compact('/a/b/c/../../..'),       '/',      'Same no of ".." as dir - all at end' );
is( canonical_path_compact('/a/../b/../c/../../..'), '/',      'More ".." than dirs' );
is( canonical_path_compact('/../../../a/'),          '/a',     '".." at start, no other ".."' );
is( canonical_path_compact('/../../a/../c/.'),       '/c',     '".." at start, other ".."' );

done_testing();

sub canonical_path {
  ## Initialize:
  ##   Set pointer to 1;
  ##   Split path into directories
  ##     - remove empty directories and also "." directories {current dir}

  my( $p, @parts ) = ( 1, grep { $_ ne '' && $_ ne '.' } split m{/}, $_[0] );

  ## Process paths...
  ## If the directory isn't ".." we just move on to the next one...
  ## If it is the first entry of the list we just shift it off.
  ## Otherwise we splice it out of the array, along withe previous directory
  ##     `splice @parts, $p-1, 2`
  ##   and then backtrack one space..
  ##   this means the splice can be written as:
  ##     `splice @parts, --$p, 2`
  ## Repeat this until we get to the end of the array - there will be no more '..'s in the
  ## list...

  $parts[$p] ne '..' ? $p++ : $p ? splice @parts, --$p, 2 : shift @parts while $p < @parts;

  ## Finally return our string which consists of a "/" followed by all the
  ## directories left joing with "/"s...

  return '/'.join '/',@parts;
}

sub canonical_path_compact {
my($p,@d)=(1,grep {''ne$_&&'.'ne$_}split/\//,shift);
$d[$p]ne'..'?$p++:$p?splice@d,--$p,2:shift@d while$p<@d;
'/'.join'/',@d;
}


