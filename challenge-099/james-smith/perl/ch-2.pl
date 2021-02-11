#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $c ={};

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
  my( $str, $sub ) = @_;
  my $f = substr $sub,0,1,'';
  return scalar @{[ $str =~ m{$f}g ]} if $sub eq q();
  my $res = 0;
  $res += uniq_subseq($str,$sub) while $str=~s{.*?$f}{};
  return $res;
}

sub uniq_subseq_cache {
  my( $str, $sub ) = @_;
  my $k = "$str-$sub";
  return $c->{$k} if exists $c->{$k};
  my $f = substr $sub,0,1,'';
  return $c->{$k} = scalar @{[ $str =~ m{$f}g ]} if $sub eq q();
  my $res = 0;
  $res += uniq_subseq($str,$sub) while $str=~s{.*?$f}{};
  return $c->{$k} = $res;
}

