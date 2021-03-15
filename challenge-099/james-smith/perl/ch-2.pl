#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Time::HiRes qw(time);
use Test::More;

my $t0 = time;

is( uniq_subseq('littleit','lit'),    5 );
is( uniq_subseq('london','lon'),      3 );
is( uniq_subseq('abc','abc'),         1 );
is( uniq_subseq('abcabc','abc'),      4 );
is( uniq_subseq('abcabcabc','abc'),   10 );
is( uniq_subseq('abcabcabcabc','abc'),20 );
is( uniq_subseq('abcabcabcabcabc','abc'),35 );
is( uniq_subseq('abcabcabcabcabcabc','abc'),56 );
is( uniq_subseq('abcabcabcabcabcabcabc','abc'),84 );
is( uniq_subseq('abcabcabcabcabcabcabcabc','abc'),120 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abc'),165 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabc'),1716 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabc'),5005 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabc'),6188 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabc'),3876 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabc'),1330 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabc'),253 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabc'),25 );
is( uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabcabc'),1 );

my $t1 = time;


uniq_subseq_cache('---'); is( uniq_subseq_cache('littleit','lit'),    5 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('london','lon'),      3 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abc','abc'),         1 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabc','abc'),      4 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabc','abc'),   10 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabc','abc'),20 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabc','abc'),35 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabc','abc'),56 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabc','abc'),84 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabc','abc'),120 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abc'),165 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabc'),1716 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabc'),5005 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabc'),6188 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabcabc'),3876 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabc'),1330 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabc'),253 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabc'),25 );
uniq_subseq_cache('---'); is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabcabc'),1 );

my $t2 = time;

is( scalar display_uniq_subseq('littleit','lit'),    5 );
is( scalar display_uniq_subseq('london','lon'),      3 );
is( scalar display_uniq_subseq('abc','abc'),         1 );
is( scalar display_uniq_subseq('abcabc','abc'),      4 );
is( scalar display_uniq_subseq('abcabcabc','abc'),   10 );
is( scalar display_uniq_subseq('abcabcabcabc','abc'),20 );
is( scalar display_uniq_subseq('abcabcabcabcabc','abc'),35 );
is( scalar display_uniq_subseq('abcabcabcabcabcabc','abc'),56 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabc','abc'),84 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabc','abc'),120 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abc'),165 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabc'),1716 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabc'),5005 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabc'),6188 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabc'),3876 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabc'),1330 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabc'),253 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabc'),25 );
is( scalar display_uniq_subseq('abcabcabcabcabcabcabcabcabc','abcabcabcabcabcabcabcabcabc'),1 );

my $t3 = time;

done_testing();

say q();
print join "\n", display_uniq_subseq('littleit','lit'),q(),q();
print join "\n", display_uniq_subseq('london','lon'),q(),q();
print join "\n", display_uniq_subseq('abc','abc'),q(),q();
print join "\n", display_uniq_subseq('abcabc','abc'),q(),q();
print join "\n", display_uniq_subseq('abcabcabc','abc'),q(),q();
print join "\n", display_uniq_subseq('abcabcabcabc','abc'),q(),q();
print join "\n", display_uniq_subseq('abcabcabcabcabc','abc'),q(),q();

printf "
uniq_subseq           %8.3f
uniq_subseq_cache     %8.3f
display_uniq_subseq   %8.3f
", $t1-$t0, $t2-$t1, $t3-$t2;

sub uniq_subseq {
  my( $result, $haystack, $first, $needle )    =     ( 0, $_[0], $_[1] =~ m{(.)(.*)} );

  return scalar @{[ $haystack =~ m{$first}g ]} if    $needle eq q();

  $result += uniq_subseq( $haystack, $needle ) while $haystack=~s{.*?$first}{};
  return $result;
}

sub uniq_subseq_cache {
  state $cache = {};
  return $cache={} if $_[0] eq '---'; ## Clear the cache to examine speed
                                      ## Can't clear state cookie from
                                      ## outside function....

  my( $result, $cache_key, $haystack, $first, $needle ) = ( 0, "$_[0]-$_[1]", $_[0], $_[1] =~ m{(.)(.*)} );

  return $cache->{$cache_key}                                         if    exists $cache->{$cache_key};

  return $cache->{$cache_key} = scalar @{[ $haystack =~ m{$first}g ]} if    $needle eq q();

  $result += uniq_subseq_cache( $haystack, $needle )                  while $haystack=~s{.*?$first}{};
  return $cache->{$cache_key} = $result;
}

sub display_uniq_subseq {
  my( $haystack, $prev, $regexp, $needle, @result ) = (
    $_[0],          ## haystack (first string)
    @_>2?$_[2]:q(), ## previous string (3rd parameter if it exists)
    $_[1] =~ m{(.)(.*)} ? ('\A(.*?)('.$1.')',$2) : (q(),q()),
    ## The regex for finding matches + the remainder of needle
    ## Slightly more complex than the previous version as we
    ## remove the "optimization" step in the other two functions
  );

  ## If we have exhausted the substring we return the previous part
  ## along with what is left of the haystack.
  ## Note individual mapped letters are surrounded by individual
  ## brackets - to collapse these down to clusters of matched
  ## characters - We collapse adjacent []s by stripping "][".
  ## We again use the "r" modifier to just return the result
  ## of the replacement.
  return ($prev =~s{\]\[}{}gr).$haystack if $regexp eq q();

  ## regex collects anything before the matched letter &
  ## the matched letter
  while( $haystack =~ s{$regexp}{} ) {
    my( $pre_match, $match ) = ($1,$2);
    push @result, display_uniq_subseq(
      $haystack, $needle, $prev.$pre_match.'['.$match.']',
    );
    ## add the match onto the previous string, and
    ## continue to the next match
    $prev .= $pre_match.$match;
  }
  return @result;
}

## and without comments.... [ just 10 lines! ]

sub display_uniq_subseq_without_comments {
  my( $haystack, $prev, $regexp, $needle, @result ) = ( $_[0], @_>2?$_[2]:q(), $_[1] =~ m{(.)(.*)} ? ('\A(.*?)('.$1.')',$2) : (q(),q()) );

  return ($prev =~s{\]\[}{}gr).$haystack if $regexp eq q();

  while( $haystack =~ s{$regexp}{} ) {
    my( $pre_match, $match ) = ($1,$2);
    push @result, display_uniq_subseq_without_comments( $haystack, $needle, $prev.$pre_match.'['.$match.']' );
    $prev .= $pre_match.$match;
  }

  return @result;
}
