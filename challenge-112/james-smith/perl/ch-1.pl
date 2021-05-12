#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

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

## We will look at some different versions of the code
## Whether we use an array or string to accumulate the resultant path
## Whether we use "readable" code or Perl hacks and tricks
## To see what aspects of our code makes it faster or slower
##
## Methods:
##   * "Long form" Perl...
##     * canonical_path_double - Using a double loop
##     * canonical_path_array  - Using backtracking instead of inner loop
##     * canonical_path_string - Use a string as the accumulator and mapping
##
##   * "One-liner" perl {arrays}
##     * canonical_path_compact     - short version of array code
##     * canonical_path_compact_opt - optimized version of above - 1-less regex
##
##   * "One-liner" perl {strings}
##     * canonical_path_shortest - most compact method
##     * canonical_path_short    - compact method
##     * canonical_path_fast     - replace one of the regex with equality checks
##     * canonical_path_fastest  - replace other regex with substr/rindex
##

##
my @examples = (
  [ '/a/',                   '/a',     'Remove trailing slash (empty trailing dir)' ],
  [ '//a',                   '/a',     'Remove empty dir as start' ],
  [ '/a/b//c/',              '/a/b/c', 'Remove empty dir "//"' ],
  [ '/a/./b/./c/',           '/a/b/c', 'Remove "." dir ...' ],
  [ '/a/b/c/../..',          '/a',     'Two ".." together at end' ],
  [ '/a/b/../c/..',          '/a',     'Two ".." separated (one in middle)' ],
  [ '/a/../b/../c/./.',      '/c',     'Two ".." separated (both in middle)' ],
  [ '/a/b/../../c',          '/c',     'Two ".." together in middle' ],
  [ '/a/../b/../c/..',       '',       'Same no of ".." as dir' ],
  [ '/a/b/c/../../..',       '',       'Same no of ".." as dir - all at end' ],
  [ '/a/../b/../c/../../..', '',       'More ".." than dirs' ],
  [ '/../../../a/',          '/a',     '".." at start, no other ".."' ],
  [ '/../../a/../c/.',       '/c',     '".." at start, other ".."' ],
);

## Code examples..
is( canonical_path_double(      $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_array(       $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_string(      $_->[0]), $_->[1], $_->[2] ) foreach @examples;
## One liners (array)...
is( canonical_path_compact(     $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_compact_opt( $_->[0]), $_->[1], $_->[2] ) foreach @examples;
## One liners (string)...
is( canonical_path_shortest(    $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_short(       $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_fast(        $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_fastest(     $_->[0]), $_->[1], $_->[2] ) foreach @examples;

done_testing();

cmpthese( 100_000, {
## Code
  '@-2loops'   => sub { canonical_path_double(      $_->[0] ) foreach @examples },
  '$-code'     => sub { canonical_path_string(      $_->[0] ) foreach @examples },
  '@-code'     => sub { canonical_path_array(       $_->[0] ) foreach @examples },
## Array 1-liner
  '@-fast'     => sub { canonical_path_compact_opt( $_->[0] ) foreach @examples },
  '@-short'    => sub { canonical_path_compact(     $_->[0] ) foreach @examples },
## String 1-liner
  '$-short'    => sub { canonical_path_short(       $_->[0] ) foreach @examples },
  '$-shortest' => sub { canonical_path_shortest(    $_->[0] ) foreach @examples },
  '$-fast'     => sub { canonical_path_fast(        $_->[0] ) foreach @examples },
  '$-fastest'  => sub { canonical_path_fastest(     $_->[0] ) foreach @examples },
  'A'  => sub { a(     $_->[0] ) foreach @examples },
});

sub canonical_path_double {
  ## This was my original function, basically loop until you find a ".."
  ## process it;
  ## Then restart the loop if you have removed the ".."
  ## This is one of the few times that labels are useful allowing
  ## to jump out of the inner loop and go to the next iteration of
  ## the outer loop...
  ## We then use "last" to jump out of the outer loop once no '..'s are
  ## found except in the first position...
  my $directory_path = shift;
  my @directory_names   = grep { $_ ne '' &&  ## Remove "empty" directory names
                                 $_ ne '.' }   ## Remove directories with name "."
                          split m{/},          ## Split path into directories
                          $directory_path;

  OUTER: while(1) {
    foreach (1..$#directory_names) {
      next unless $directory_names[$_] eq '..';
      splice @directory_names,$_-1,2;
      next OUTER;
    }
    last;
  }
  shift @directory_names if @directory_names && $directory_names[0] eq '..';
  return join '/','',@directory_names;
}

sub canonical_path_array {
  my $directory_path = shift;
  my @directory_names   = grep { $_ ne '' &&   ## Remove "empty" directory names
                                 $_ ne '.' }   ## Remove directories with name "."
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
## Make shorted by using regex and ternarys
$a=1,@_=grep{!/^\.?$/}split/\//,shift;
$_[$a]ne'..'?$a++:$a?splice@_,--$a,2:shift while$a<@_;
join'/','',@_
}

sub canonical_path_compact_opt {
## Remove the regex in the grep and use ternarys...
$a=1,@_=grep{''ne$_&&'.'ne$_}split/\//,shift;
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


sub canonical_path_short {
## Converting if statements into ternary operators
## Shorter by using regex rather than, interpolation
## and `$` rather than `/Z`
$a='';
/^\.?$/?0:'..'ne$_?$a.="/$_":$a=~s{/[^/]+$}{} for split/\//,shift;
$a
}


sub canonical_path_shortest {
## only ternary - use `x` to add/not add the path
## depending on whether the directory name is "."
## or //. This is the shortest script in terms of
## bytes - but also the slowest string version.
$a='';
'..'ne$_?$a.="/$_"x!/^\.?$/:$a=~s{/[^/]+$}{} for split/\//,shift;
$a
}


sub canonical_path_fast {
## Skip the regex for ''/'.' and replace with compares
$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.="/$_":$a=~s{/[^/]+$}{})for split/\//,shift;
$a
}


sub canonical_path_fastest {
## we avoid regular expressions here by using `rindex` - to look
## for the last slash in the string and removing it along with
## the characters after it.
## We use the 4 parameter version of `substr` here. This replaces
## the substring that is found with this fourth parameter.
##
## `substr $string, $offset, $length, $replace`
##
## There is a catch here - that the 3rd parameter has to
## set the length of string to be removed (or `-n`) if you want
## it to be to the end - but this only works if `n > 0` so there
## is no simple way to remove everything to the end of the
## string - to do this we have to specify a length greate than
## all possible lenghts. We can use "~0" which is the
## 1s-complement of 0 - which gives the largest +ve perl integer
## In this case - 18,446,744,073,709,551,615. This is approx
## 16 EB (Exabytes) - I think that should be enough!
##
## This appears
$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.='/'.$_:substr$a,rindex($a,'/'),~0,'')for split/\//,shift;
$a
}


