#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese);

##
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
##
##
##
## Performance of different methods
## ================================
##
## We will look at some different versions of the code
## Whether we use an array or string to accumulate the resultant path
## Whether we use "readable" code or Perl hacks and tricks
## To see what aspects of our code makes it faster or slower
##
## Methods:
##   * "Long form" Perl...
##     * canonical_path_double      - Using a double loop
##     * canonical_path_array       - Using backtracking instead of inner loop
##     * canonical_path_string      - Use a string as the accumulator and mapping
##     * canonical_path_string_fast - As above - but using substr/rindex
##
##   * "One-liner" perl {arrays}
##     * canonical_path_compact      - short version of array code
##     * canonical_path_compact_opt  - optimized version of above - 1-less regex
##     * canonical_path_compact_glob - as opt but with global var
##
##   * "One-liner" perl {strings}
##     * canonical_path_shortest - most compact method
##     * canonical_path_short    - compact method
##     * canonical_path_fast     - replace one of the regex with equality checks
##     * canonical_path_fastest  - replace other regex with substr/rindex
##     * canonical_path_global   - as fastest but with global variable...
##
## Timings for these:
##
##                 Rate @-sh $-st $-sh @&2l $&fa $-fa @&ft $&ft @-ft @-gl $-ft $-gl
## @-short     20,877/s   --  -6%  -8% -15% -25% -32% -38% -43% -45% -45% -50% -51%
## $-shortest  22,124/s   6%   --  -2% -10% -21% -28% -34% -40% -41% -42% -47% -48%
## $-short     22,573/s   8%   2%   --  -8% -19% -27% -33% -39% -40% -41% -46% -47%
## @-&-2loop   24,631/s  18%  11%   9%   -- -12% -20% -26% -33% -35% -35% -41% -42%
## $-&-fast    27,933/s  34%  26%  24%  13%   --  -9% -16% -24% -26% -27% -34% -35%
## $-fast      30,769/s  47%  39%  36%  25%  10%   --  -8% -17% -18% -19% -27% -28%
## @-&-fastest 33,445/s  60%  51%  48%  36%  20%   9%   --  -9% -11% -12% -20% -22%
## $-&-fastest 36,900/s  77%  67%  63%  50%  32%  20%  10%   --  -2%  -3% -12% -14%
## @-fastest   37,736/s  81%  71%  67%  53%  35%  23%  13%   2%   --  -1% -10% -12%
## @-global    38,168/s  83%  73%  69%  55%  37%  24%  14%   3%   1%   --  -9% -11%
## $-fastest   42,017/s 101%  90%  86%  71%  50%  37%  26%  14%  11%  10%   --  -2%
## $-global    42,735/s 105%  93%  89%  74%  53%  39%  28%  16%  13%  12%   2%   --

## What we see is:
##  * that the optimized string code is faster than the array code,
##    by around 12-15%
##  * using compact "1-liner" code can be approximately 10%
##    faster.
##  * but using less regex's and replacing them with
##    eq/ne for comparisons and `substr`/`rindex` for
##    replacement/trimming improves the speed the most.
##     * approx 25-30% for removing the comparison regex for checking
##       `' '` or `'.'` and replacing with two `eq`/`ne`
##     * approx 30-40% for removing the substitute of the string
##       from the last `'/'` to the end of the string, with `rindex`
##       and the the four parameter version of `subst`.
##     * combining the two seems to double the performance!
##  * switching from local to global variables gets a minor
##    gain (about 1-2%) again due to memory management.
##
## Conclusion
##
## So short code is interesting - but is not by a long shot the
## most efficient especially in respect of converting regexes into
## `substr`/`index`/`rindex`, allocation of variables, even if we
## keep it to a 1-liner.
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
is( canonical_path_double(       $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_array(        $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_string(       $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_string_fast(  $_->[0]), $_->[1], $_->[2] ) foreach @examples;
### One liners (array)...
is( canonical_path_compact(      $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_compact_opt(  $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_compact_glob( $_->[0]), $_->[1], $_->[2] ) foreach @examples;
### One liners (string)...
is( canonical_path_shortest(     $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_short(        $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_fast(         $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_fastest(      $_->[0]), $_->[1], $_->[2] ) foreach @examples;
is( canonical_path_global(       $_->[0]), $_->[1], $_->[2] ) foreach @examples;
done_testing();

cmpthese( 100_000, {
## Code
  '@&2l' => sub { canonical_path_double(       $_->[0] ) foreach @examples },
  '$&fa' => sub { canonical_path_string(       $_->[0] ) foreach @examples },
  '@&ft' => sub { canonical_path_array(        $_->[0] ) foreach @examples },
  '$&ft' => sub { canonical_path_string_fast(  $_->[0] ) foreach @examples },
## Array 1-liner
  '@-sh' => sub { canonical_path_compact(      $_->[0] ) foreach @examples },
  '@-ft' => sub { canonical_path_compact_opt(  $_->[0] ) foreach @examples },
  '@-gl' => sub { canonical_path_compact_glob( $_->[0] ) foreach @examples },
## String 1-liner
  '$-st' => sub { canonical_path_shortest(     $_->[0] ) foreach @examples },
  '$-sh' => sub { canonical_path_short(        $_->[0] ) foreach @examples },
  '$-fa' => sub { canonical_path_fast(         $_->[0] ) foreach @examples },
  '$-ft' => sub { canonical_path_fastest(      $_->[0] ) foreach @examples },
  '$-gl' => sub { canonical_path_global(       $_->[0] ) foreach @examples },
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
  my @parts          = split m{/}, $directory_path;
  my @directory_names;
  foreach my $part ( @parts ) {
    next if $part eq '';
    next if $part eq '.';
    if($part eq '..' ) {
      pop @directory_names;
    } else {
      push @directory_names,$part;
    }
  }
  return join '/','',@directory_names;
}

sub canonical_path_compact {
  my @d=();
  /^\.?$/||('..'eq$_?pop@d:push@d,$_)for split/\//,shift;
  return join'/','',@d;
}

my @g;
sub canonical_path_compact_glob {
  @g=();
  ''ne$_&&'.'ne$_&&('..'eq$_?pop@g:push@g,$_)for split/\//,shift;
  return join'/','',@g;
}

sub canonical_path_compact_opt {
  my @d=();
  ''ne$_&&'.'ne$_&&('..'eq$_?pop@d:push@d,$_)for split/\//,shift;
  return join'/','',@d;
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

sub canonical_path_string_fast {
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
      substr $canonical_path,
             rindex( $canonical_path, '/' ),
             ~0, '';                             ## If so remove parent directory
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
/^\.?$/?0:'..'ne$_?$a.="/$_":$a=~s#/[^/]+$## for split'/',shift;
$a
}


sub canonical_path_shortest {
## only ternary - use `x` to add/not add the path
## depending on whether the directory name is "."
## or //. This is the shortest script in terms of
## bytes - but also the slowest string version.
$a='';
'..'ne$_?$a.="/$_"x!/^\.?$/:$a=~s#/[^/]+$## for split'/',shift;
$a
}


sub canonical_path_fast {
## Skip the regex for ''/'.' and replace with compares
$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.="/$_":$a=~s#/[^/]+$##)for split'/',shift;
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

$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.='/'.$_:substr$a,rindex($a,'/'),~0,'')for split'/',shift;
$a
}

my $s;

sub canonical_path_global {
## Minor speed up by using a global variable - this
## is I think due to memory allocation for variables
## this can be something useful to know in very tight
## loops...
$s='';
'.'ne$_&&''ne$_&&('..'ne$_?$s.='/'.$_:substr$s,rindex($s,'/'),~0,'')for split'/',shift;
$s
}



