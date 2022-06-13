#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(brilliant(20),
          [4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121,
           143, 169, 187, 209, 221, 247, 253, 289, 299],
          'example 1');

sub genprimes($mx) {
    my @primes;
    {
        my $primesh=(2,3).SetHash;
        loop (my $i=6;$i <= $mx+1; $i += 6) {
            for ($i-1,$i+1) -> $j {
                if ($j <= $mx) {
                    $primesh{$j}=True;
                }
            }
        }
        my $p=2;
        my @q=[2,3,5,7];
        my $mr=floor(sqrt($mx));
        while ($p <= $mr) {
            if ($primesh{$p}:exists) {
                my $i=$p*$p;
                while ($i <= $mx) {
                    $primesh{$i}:delete;
                    $i += $p;
                }
            }
            if (@q.elems < 2) {
                @q.push(@q[*-1]+4);
                @q.push(@q[*-1]+2);
            }
            $p=@q.shift;
        }
        @primes=$primesh.keys.sort;
    }
    return @primes;
}

sub brilliant($ct) {
  my $base = 1;
  my $out = SetHash.new;
  while (1) {
    my @pl = grep {$_ >= $base}, genprimes($base * 10);
    for (0..@pl.end) -> $ai {
      for ($ai..@pl.end) -> $bi {
        $out.set( @pl[$ai] * @pl[$bi] );
      }
    }
    if ($out.elems >= $ct) {
      last;
    }
    $base *= 10;
  }
  my @o = $out.keys.sort({ $^a <=> $^b });
  splice @o,$ct;
  return @o;
}
