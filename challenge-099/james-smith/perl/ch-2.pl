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
  my $f = substr $sub, 0, 1, q();
  return scalar @{[ $str =~ m{$f}g ]} if $sub eq q();
  my $res = 0;
  $res += uniq_subseq( $str, $sub ) while $str=~s{.*?$f}{};
  return $res;
}

say q();

print join "\n", display_uniq_subseq( 'littleit',  'lit' ), q(), q();
print join "\n", display_uniq_subseq( 'london',    'lon' ), q(), q();
print join "\n", display_uniq_subseq( 'abcabcabc', 'abc' ), q(), q();

sub display_uniq_subseq {
  my( $str, $sub, $prev ) = ( @_, q() ); ## adding q() means previous is defined in first loop....

  return ($prev =~s{\]\[}{}gr).$str if $sub eq q(); ## If we have exhausted the substring we return the previous part (by collapse []s)

  my( $r, $t, @res ) = ( '\A(.*?)('.(substr $sub, 0, 1, q()).')', q() ); ## regex collects anything before the matched letter & the matched letter

  while( $str =~ s{$r}{} ) {
    my($a,$b) = ($1,$2);
    push @res, display_uniq_subseq( $str, $sub, $prev.$a.'['.$b.']' );
    $prev .= $a.$b; ## put the match onto the previous string, and continue to next match
  }
  return @res;
}

sub uniq_subseq_cache {
  my( $str, $sub ) = @_;
  my $k = "$str-$sub";
  return $c->{$k} if exists $c->{$k};
  my $f = substr $sub, 0, 1, q();
  return $c->{$k} = scalar @{[ $str =~ m{$f}g ]} if $sub eq q();
  my $res = 0;
  $res += uniq_subseq( $str, $sub ) while $str=~s{.*?$f}{};
  return $c->{$k} = $res;
}

