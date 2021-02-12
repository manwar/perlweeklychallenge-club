#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;

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

is( uniq_subseq_cache('littleit','lit'),    5 );
is( uniq_subseq_cache('london','lon'),      3 );
is( uniq_subseq_cache('abc','abc'),         1 );
is( uniq_subseq_cache('abcabc','abc'),      4 );
is( uniq_subseq_cache('abcabcabc','abc'),   10 );
is( uniq_subseq_cache('abcabcabcabc','abc'),20 );
is( uniq_subseq_cache('abcabcabcabcabc','abc'),35 );
is( uniq_subseq_cache('abcabcabcabcabcabc','abc'),56 );
is( uniq_subseq_cache('abcabcabcabcabcabcabc','abc'),84 );
is( uniq_subseq_cache('abcabcabcabcabcabcabcabc','abc'),120 );
is( uniq_subseq_cache('abcabcabcabcabcabcabcabcabc','abc'),165 );

done_testing();

sub uniq_subseq {
  my( $result, $haystack, $needle ) = ( 0, @_ );
  my $first = substr $needle, 0, 1, q();
  return scalar @{[ $haystack =~ m{$first}g ]} if $needle eq q();
  $result += uniq_subseq( $haystack, $needle ) while $haystack=~s{.*?$first}{};
  return $result;
}

say q();

print join "\n", display_uniq_subseq( 'littleit',  'lit' ), q(), q();
print join "\n", display_uniq_subseq( 'london',    'lon' ), q(), q();
print join "\n", display_uniq_subseq( 'abcabcabc', 'abc' ), q(), q();

sub display_uniq_subseq {
  my( $haystack, $needle, $prev ) = ( @_, q() ); ## adding q() means previous is defined in first loop....

  return ($prev =~s{\]\[}{}gr).$haystack if $needle eq q(); ## If we have exhausted the substring we return the previous part (by collapse []s)

  my( $regexp, @result ) = ( '\A(.*?)('.(substr $needle, 0, 1, q()).')' ); ## regex collects anything before the matched letter & the matched letter

  while( $haystack =~ s{$regexp}{} ) {
    my($pre_match,$match) = ($1,$2);
    push @result, display_uniq_subseq( $haystack, $needle, $prev.$pre_match.'['.$match.']' );
    $prev .= $pre_match.$match; ## put the match onto the previous string, and continue to next match
  }
  return @result;
}

sub uniq_subseq_cache {
  state $cache;
  my( $result, $cache_key, $haystack, $needle ) = ( 0, "$_[0]-$_[1]", @_ );
  my $first = substr $needle, 0, 1, q();
  return $cache->{$cache_key} if exists $cache->{$cache_key};
  return $cache->{$cache_key} = scalar @{[ $haystack =~ m{$first}g ]} if $needle eq q();
  $result += uniq_subseq_cache( $haystack, $needle ) while $haystack=~s{.*?$first}{};
  return $cache->{$cache_key} = $result;
}

