#!nusr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

is( encrypt('playfair example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif' );
is( encrypt('playfajr example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif' );
is( decrypt('perl and raku',    'siderwrdulfipaarkcrw'),            'thewexeklychallengex' );
is( encrypt('abc','xxx'),                                           'xxxxxx' );
is( decrypt('abc','xxxxxx'),                                        'xxxxxx' );
is( encrypt_cache('playfair example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif' );
is( encrypt_cache('playfajr example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif' );
is( decrypt_cache('perl and raku',    'siderwrdulfipaarkcrw'),            'thewexeklychallengex' );
is( encrypt_cache('abc','xxx'),                                           'xxxxxx' );
is( decrypt_cache('abc','xxxxxx'),                                        'xxxxxx' );

done_testing();

cmpthese( 100_000, {
  'nc' => sub { encrypt('playfair example', 'hide the gold in the tree stump'); },
  'c'  => sub { encrypt_cache('playfair example', 'hide the gold in the tree stump'); },
} );

sub _crypt {
  my( $o, $key, $p, $out, @r, %l ) = ( shift, shift, 0, '' );               ## Initialise variables and get mapping...
  exists $l{$_} || ( $l{$_}=[int $p/5,($p++)%5] )                           ## %l maps letter to position
    for grep { /[a-z]/ } split ( //, $key =~s/j/i/gr ), 'a'..'i', 'k'..'z'; ## values are ["row no", "column no"]
  $r[ $l{$_}[0] ][ $l{$_}[1] ] = $_ for keys %l;                            ## @r maps position to letter, first
                                                                            ## index row, 2nd column.
  my @seq = grep {/[a-z]/} split //, lc shift =~ s{j}{i}gr;                 ## Prep sequence, remove non-letters,
                                                                            ## lower case, convert "j" to "i"
  while( my($m,$n) = splice @seq,0,2 ) {                                    ## Loop through letter pairs
    unshift(@seq,$n), $n='x' if $n && $n eq $m && $o == 1;                  ## Deal with case when both letters the same
                                                                            ## (Only do when encrypting..)
    $n ||= 'x';                                                             ## Pad if required...

    $out.= $m eq 'x' && $n eq 'x' ? 'xx'                                    ## Can still have a pair if first value is
                                                                            ## "x" because this is then padded by "x"
         : $l{$m}[0] eq $l{$n}[0] ? $r[ $l{$m}[0]      ][($l{$m}[1]+$o)%5]. ## Same row    - shift down  (or up)
                                    $r[ $l{$n}[0]      ][($l{$n}[1]+$o)%5]
         : $l{$m}[1] eq $l{$n}[1] ? $r[($l{$m}[0]+$o)%5][ $l{$m}[1]      ]. ## Same column - shift right (or left)
                                    $r[($l{$n}[0]+$o)%5][ $l{$n}[1]      ]
         :                          $r[ $l{$m}[0]      ][ $l{$n}[1]      ]. ## o/w - other corners of square
                                    $r[ $l{$n}[0]      ][ $l{$m}[1]      ]
         ;
  }
  $out;
}

sub encrypt { return _crypt  1, @_; }
sub decrypt { return _crypt -1, @_; }

sub _crypt_cache {
  my( $o, $key, $p, $out, @r, %l ) = ( shift, shift, 0, '' );               ## Initialise variables and get mapping...
  state $cache = {};
  if( exists $cache->{$key} ) {
    @r = @{$cache->{$key}[0]};
    %l = %{$cache->{$key}[1]};
  } else {
    exists $l{$_} || ( $l{$_}=[int $p/5,($p++)%5] )                           ## %l maps letter to position
      for grep { /[a-z]/ } split ( //, $key =~s/j/i/gr ), 'a'..'i', 'k'..'z'; ## values are ["row no", "column no"]
    $r[ $l{$_}[0] ] [$l{$_}[1] ] = $_ for keys %l;                            ## @r maps position to letter, first
    $cache->{$key} = [ \@r, \%l ]
  }
  my @seq = grep {/[a-z]/} split //, lc shift =~ s{j}{i}gr;                 ## Prep sequence, remove non-letters,
                                                                            ## lower case, convert "j" to "i"
  while( my($m,$n) = splice @seq,0,2 ) {                                    ## Loop through letter pairs
    unshift(@seq,$n), $n='x' if $n && $n eq $m && $o == 1;                  ## Deal with case when both letters the same
                                                                            ## (Only do when encrypting..)
    $n ||= 'x';                                                             ## Pad if required...

    $out.= $m eq 'x' && $n eq 'x' ? 'xx'                                    ## Can still have a pair if first value is
                                                                            ## "x" because this is then padded by "x"
         : $l{$m}[0] eq $l{$n}[0] ? $r[ $l{$m}[0]      ][($l{$m}[1]+$o)%5]. ## Same row    - shift down  (or up)
                                    $r[ $l{$n}[0]      ][($l{$n}[1]+$o)%5]
         : $l{$m}[1] eq $l{$n}[1] ? $r[($l{$m}[0]+$o)%5][ $l{$m}[1]      ]. ## Same column - shift right (or left)
                                    $r[($l{$n}[0]+$o)%5][ $l{$n}[1]      ]
         :                          $r[ $l{$m}[0]      ][ $l{$n}[1]      ]. ## o/w - other corners of square
                                    $r[ $l{$n}[0]      ][ $l{$m}[1]      ]
         ;
  }
  $out;
}

sub encrypt_cache { return _crypt_cache  1, @_; }
sub decrypt_cache { return _crypt_cache -1, @_; }

