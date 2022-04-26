#!nusr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

is( encrypt('playfair example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif' );
is( decrypt('perl and raku',    'siderwrdulfipaarkcrw'),            'thewexeklychallengex' );
is( encrypt('abc','xxx'),                                           'yyyyyy' );
is( decrypt('abc','yyyyyy'),                                        'xxxxxx' );
done_testing();

sub encrypt { return _crypt( 1,@_); }
sub decrypt { return _crypt(-1,@_); }

sub _crypt {
  my($o,$key,$p,$out,@r,%l) = (shift,shift,0,'');                        ## Initialise variables and get mapping...
  ($_ eq 'j' && ($_='i')), exists $l{$_} || ($l{$_}=[int $p/5,($p++)%5]) ## %l maps letter to position
    for grep { /[a-z]/ } split(//,$key),'a'..'i','k'..'z';
  $r[$l{$_}[0]][$l{$_}[1]]=$_ for keys %l;                               ## @r maps position to letter

  my @seq = grep {/[a-z]/} split //, lc shift =~ s{j}{i}gr;              ## Prep sequence

  while(my($m,$n)=splice @seq,0,2) {                                     ## Loop through letter pairs
    unshift(@seq,$n), $n='x' if $n && $n eq $m && $o == 1;               ## Deal with case when both letters the same
                                                                         ## Only do when encrypting..
    $n ||= 'x';                                                          ## Pad if required...
    $out.= $l{$m}[0] eq $l{$n}[0] ? $r[ $l{$m}[0]      ][($l{$m}[1]+$o)%5].
                                    $r[ $l{$n}[0]      ][($l{$n}[1]+$o)%5]
         : $l{$m}[1] eq $l{$n}[1] ? $r[($l{$m}[0]+$o)%5][ $l{$m}[1]      ].
                                    $r[($l{$n}[0]+$o)%5][ $l{$n}[1]      ]
         :                          $r[ $l{$m}[0]      ][ $l{$n}[1]      ].
                                    $r[ $l{$n}[0]      ][ $l{$m}[1]      ]
         ;
  }
  $out;
}

