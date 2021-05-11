#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## Please note there is an ambiguity in the question - when then path contains no
## files - as it cannot start with a '/' and not end with a '/' - so we have
## to make a choice do we return '/' or do we return ''.
##
## In our case we decide to return it as the empty string.
## This has the advantage that there is a level of consistency if you do...
##
## $parent_dir.canonical_path('/a');
## or
## $parent_dir.canonical_path('/');
##
## then it will always end without a "/";

is( canonical_path_array('/a/'),                   '/a',     'Remove trailing slash (empty trailing dir)' );
is( canonical_path_array('//a'),                   '/a',     'Remove empty dir as start' );
is( canonical_path_array('/a/b//c/'),              '/a/b/c', 'Remove empty dir "//"' );
is( canonical_path_array('/a/./b/./c/'),           '/a/b/c', 'Remove "." dir ...' );
is( canonical_path_array('/a/b/c/../..'),          '/a',     'Two ".." together at end' );
is( canonical_path_array('/a/b/../c/..'),          '/a',     'Two ".." separated (one in middle)' );
is( canonical_path_array('/a/../b/../c/./.'),      '/c',     'Two ".." separated (both in middle)' );
is( canonical_path_array('/a/b/../../c'),          '/c',     'Two ".." together in middle' );
is( canonical_path_array('/a/../b/../c/..'),       '',       'Same no of ".." as dir' );
is( canonical_path_array('/a/b/c/../../..'),       '',       'Same no of ".." as dir - all at end' );
is( canonical_path_array('/a/../b/../c/../../..'), '',       'More ".." than dirs' );
is( canonical_path_array('/../../../a/'),          '/a',     '".." at start, no other ".."' );
is( canonical_path_array('/../../a/../c/.'),       '/c',     '".." at start, other ".."' );

is( canonical_path_string('/a/'),                   '/a',     'Remove trailing slash (empty trailing dir)' );
is( canonical_path_string('//a'),                   '/a',     'Remove empty dir as start' );
is( canonical_path_string('/a/b//c/'),              '/a/b/c', 'Remove empty dir "//"' );
is( canonical_path_string('/a/./b/./c/'),           '/a/b/c', 'Remove "." dir ...' );
is( canonical_path_string('/a/b/c/../..'),          '/a',     'Two ".." together at end' );
is( canonical_path_string('/a/b/../c/..'),          '/a',     'Two ".." separated (one in middle)' );
is( canonical_path_string('/a/../b/../c/./.'),      '/c',     'Two ".." separated (both in middle)' );
is( canonical_path_string('/a/b/../../c'),          '/c',     'Two ".." together in middle' );
is( canonical_path_string('/a/../b/../c/..'),       '',       'Same no of ".." as dir' );
is( canonical_path_string('/a/b/c/../../..'),       '',       'Same no of ".." as dir - all at end' );
is( canonical_path_string('/a/../b/../c/../../..'), '',       'More ".." than dirs' );
is( canonical_path_string('/../../../a/'),          '/a',     '".." at start, no other ".."' );
is( canonical_path_string('/../../a/../c/.'),       '/c',     '".." at start, other ".."' );

is( canonical_path('/a/'),                   '/a',     'Remove trailing slash (empty trailing dir)' );
is( canonical_path('//a'),                   '/a',     'Remove empty dir as start' );
is( canonical_path('/a/b//c/'),              '/a/b/c', 'Remove empty dir "//"' );
is( canonical_path('/a/./b/./c/'),           '/a/b/c', 'Remove "." dir ...' );
is( canonical_path('/a/b/c/../..'),          '/a',     'Two ".." together at end' );
is( canonical_path('/a/b/../c/..'),          '/a',     'Two ".." separated (one in middle)' );
is( canonical_path('/a/../b/../c/./.'),      '/c',     'Two ".." separated (both in middle)' );
is( canonical_path('/a/b/../../c'),          '/c',     'Two ".." together in middle' );
is( canonical_path('/a/../b/../c/..'),       '',       'Same no of ".." as dir' );
is( canonical_path('/a/b/c/../../..'),       '',       'Same no of ".." as dir - all at end' );
is( canonical_path('/a/../b/../c/../../..'), '',       'More ".." than dirs' );
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
is( canonical_path_compact('/a/../b/../c/..'),       '',       'Same no of ".." as dir' );
is( canonical_path_compact('/a/b/c/../../..'),       '',       'Same no of ".." as dir - all at end' );
is( canonical_path_compact('/a/../b/../c/../../..'), '',       'More ".." than dirs' );
is( canonical_path_compact('/../../../a/'),          '/a',     '".." at start, no other ".."' );
is( canonical_path_compact('/../../a/../c/.'),       '/c',     '".." at start, other ".."' );

done_testing();

sub canonical_path_array {
  my $directory_path = shift;
  my @directory_names   = grep { $_ ne ''  }   ## Remove "empty" directory names
                          grep { $_ ne '.' }   ## Remove directories with name "."
                          split m{/},          ## Split path into directories
                          $directory_path;

  my $pointer = 1;                             ## Initialize pointer to 1

  while( $pointer < @directory_names ) {       ## Keep going till the pointer is
                                               ## after the end of the list...

    if( $directory_names[$pointer] eq '..' ) { ## If we have a ".." name
                                               ## then this means we have to
                                               ## remove it from the list,
                                               ## along with it's parent...

      if( $pointer > 0 ) {                     ## If it is not at the start of
        splice @directory_names, $pointer - 1, 2;  ## the list - we remove it
                                               ## and it's parent directory

        $pointer --;                           ## We back-track one-space as
                                               ## what would have been the next
                                               ## entry has moved backwards to
                                               ## spaces..
      } else {
        shift @directory_names;                ## If it is at the start of the
                                               ## list we remove it.
                                               ## No need to back track as the
                                               ## next entry is now in this
                                               ## location
      }
    } else {                                   ## Finally if the name isn't ".."
      $pointer ++;                             ## We just go onto the next path
                                               ## element
    }
  }

  return join '/','', @directory_names;        ## The final stage is to return
                                               ## the path "joined" together
}

sub canonical_path_compact {
$a=1,@_=grep{!/^\.?$/}split/\//,shift;
$_[$a]ne'..'?$a++:$a?splice@_,--$a,2:shift while$a<@_;
join'/','',@_
}

## This is the "nice version" of the string based method for
## finding the canonical path. Rather than storing the canonical
## path in an array and join to return the value - we use a string
## and use "concatenate" and "regex-replace" to add or remove the
## path as required..

## The highly compressed and optimized version follows with
## `canonical_path`

sub canonical_path_string {
  my $path = shift;
  my @directories    = split m{/},               ## Split path into directory names
                       $path;

  my $canonical_path = '';                       ## Initialize canonical path

  foreach my $directory_name ( @directories ) {  ## For each directory we
    next if $directory_name eq '';               ## Remove "empty" directory names
    next if $directory_name eq '.';              ## Remove directories named "."
                                                 ## (current directory)
    if( $directory_name eq q(..) ) {             ## look to see if it is
                                                 ## ..;
      $canonical_path =~ s{/[^/]+\Z}{};          ## If so remove parent directory
                                                 ## if one is set....
    } else {
      $canonical_path .= q(/) . $directory_name; ## add directory name to end
    }
  }
  return $canonical_path;
}


sub canonical_path {
$a='';
/^\.?$/?0:'..'ne$_?$a.="/$_":$a=~s{/[^/]+$}{}
for split/\//,shift;
$a
}


