#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @fib = (1,1); push @fib,$fib[-2]+$fib[-1] for 1..50;
print "@fib";
my @TESTS = (
  [ 11,   'AA K' ],
  [ 1115, 'AAAE AAO AKE KAE KO' ],
  [ 124324141, 'ABDCBDADA ABDCBDNA ABDCXADA ABDCXNA AXCBDADA AXCBDNA AXCXADA AXCXNA LDCBDADA LDCBDNA LDCXADA LDCXNA' ],
  [ 1111111111, 'AAAAAAAAAA AAAAAAAAK AAAAAAAKA AAAAAAKAA AAAAAAKK AAAAAKAAA AAAAAKAK AAAAAKKA AAAAKAAAA AAAAKAAK AAAAKAKA AAAAKKAA AAAAKKK AAAKAAAAA AAAKAAAK AAAKAAKA AAAKAKAA AAAKAKK AAAKKAAA AAAKKAK AAAKKKA AAKAAAAAA AAKAAAAK AAKAAAKA AAKAAKAA AAKAAKK AAKAKAAA AAKAKAK AAKAKKA AAKKAAAA AAKKAAK AAKKAKA AAKKKAA AAKKKK AKAAAAAAA AKAAAAAK AKAAAAKA AKAAAKAA AKAAAKK AKAAKAAA AKAAKAK AKAAKKA AKAKAAAA AKAKAAK AKAKAKA AKAKKAA AKAKKK AKKAAAAA AKKAAAK AKKAAKA AKKAKAA AKKAKK AKKKAAA AKKKAK AKKKKA KAAAAAAAA KAAAAAAK KAAAAAKA KAAAAKAA KAAAAKK KAAAKAAA KAAAKAK KAAAKKA KAAKAAAA KAAKAAK KAAKAKA KAAKKAA KAAKKK KAKAAAAA KAKAAAK KAKAAKA KAKAKAA KAKAKK KAKKAAA KAKKAK KAKKKA KKAAAAAA KKAAAAK KKAAAKA KKAAKAA KKAAKK KKAKAAA KKAKAK KKAKKA KKKAAAA KKKAAK KKKAKA KKKKAA KKKKK' ],
 [ 123123123123, 'ABCABCABCABC ABCABCABCAW ABCABCABCLC ABCABCAWABC ABCABCAWAW ABCABCAWLC ABCABCLCABC ABCABCLCAW ABCABCLCLC ABCAWABCABC ABCAWABCAW ABCAWABCLC ABCAWAWABC ABCAWAWAW ABCAWAWLC ABCAWLCABC ABCAWLCAW ABCAWLCLC ABCLCABCABC ABCLCABCAW ABCLCABCLC ABCLCAWABC ABCLCAWAW ABCLCAWLC ABCLCLCABC ABCLCLCAW ABCLCLCLC AWABCABCABC AWABCABCAW AWABCABCLC AWABCAWABC AWABCAWAW AWABCAWLC AWABCLCABC AWABCLCAW AWABCLCLC AWAWABCABC AWAWABCAW AWAWABCLC AWAWAWABC AWAWAWAW AWAWAWLC AWAWLCABC AWAWLCAW AWAWLCLC AWLCABCABC AWLCABCAW AWLCABCLC AWLCAWABC AWLCAWAW AWLCAWLC AWLCLCABC AWLCLCAW AWLCLCLC LCABCABCABC LCABCABCAW LCABCABCLC LCABCAWABC LCABCAWAW LCABCAWLC LCABCLCABC LCABCLCAW LCABCLCLC LCAWABCABC LCAWABCAW LCAWABCLC LCAWAWABC LCAWAWAW LCAWAWLC LCAWLCABC LCAWLCAW LCAWLCLC LCLCABCABC LCLCABCAW LCLCABCLC LCLCAWABC LCLCAWAW LCLCAWLC LCLCLCABC LCLCLCAW LCLCLCLC' ],
#  [ '111111111111111111111111111111111', '' ],
  [ 127,  'ABG LG' ],
  [ 100010010, '' ],
);

is( "@{[ decoded_rec(   $_->[0]) ]}", $_->[1] ) foreach @TESTS;
is( "@{[ decoded_nonrec($_->[0]) ]}", $_->[1] ) foreach @TESTS;
is( "@{[ decoded_nonrec_fib($_->[0]) ]}", $_->[1] ) foreach @TESTS;

done_testing();

cmpthese( -5, {
  'rec' => sub { decoded_rec( $_->[0] ) for @TESTS; },
  'fib' => sub { decoded_nonrec_fib( $_->[0] ) for @TESTS; },
  'non' => sub { decoded_nonrec( $_->[0] ) for @TESTS; },
});

sub decoded_rec {
  return $_[0] eq '' ? '' : $_[0] eq '0' ? () : chr(64 + $_[0]) if 2 > length $_[0];
  my($f,$s,$r) = split m{}, $_[0], 3;
  $r ||= '';
  ( $f      && $s                ? ( map { chr(           $f + 64 ) . $_ } decoded_rec($s.$r) ) : (),
    $f == 1 || $f == 2 && $s < 7 ? ( map { chr( $f * 10 + $s + 64 ) . $_ } decoded_rec($r   ) ) : () );
}

sub decoded_nonrec {
  my @res;
  O: for my $s ( 0 .. 1 << length $_[0]-1 ) {
    my($n,$res,$x) = ($_[0],'');
    while($n) {
      #warn "** $n";
        $s & 1  ? ( ($x = substr $n,0,1,'') eq '0' ? (next O) : ($res .= chr $x + 64) )
      : $n < 10 ? (next O)
      :           ( ($x = substr $n,0,2,'') < 10 || $x > 26 ? (next O) : ($res .= chr $x + 64) );
      $s>>=1, $n eq '' && ( $s ? next O : last );
    }
    unshift @res, $res;
  }
  sort @res
}

sub decoded_nonrec_fib {
  my($s,$l,@res,$t,$k,$n,$res,$x) = ( $fib[length $_[0]], length $_[0] );
  O: for (;$s>0;) {
    ($t,$k,$n,$res) = ($s,$l,$_[0],'');
    while( $n ) {
      $t <= $fib[--$k]
    ? (
        ($x = substr $n,0,1,'') ? ($res.=chr $x+64) : ($s-=$fib[$k+1],next O)
      )
    : $n < 10 ? ($s-=$fib[$k+1],next O)
    : ( ($x = 0+substr $n,0,2,'') < 10 || $x > 26 ? ($s-=$fib[$k-1],next O) : ($t-=$fib[$k],$res .= chr $x + 64,$k--) );
    }
    $s--;
    unshift @res, $res;
  }
  @res
}

