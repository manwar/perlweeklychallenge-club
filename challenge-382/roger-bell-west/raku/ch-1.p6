#! /usr/bin/raku

use Test;

plan 3;

is-deeply(is_adjacentsquared(32, hamiltoniancycle(32)), True, 'example 1');
is-deeply(hamiltoniancycle(15), [], 'example 2');
is-deeply(is_adjacentsquared(34, hamiltoniancycle(34)), True, 'example 3');

sub isqrt($n) {
  my $k=$n +> 1;
  my $x=1;
  while ($x) {
    my $k1=($k+$n/$k) +> 1;
    if ($k1 >= $k) {
      $x=0;
    }
    $k=$k1;
  }
  return $k;
}

sub is_adjacentsquared($param, @hc) {
    my @hcs = @hc.sort({$^a <=> $^b});
    unless (all((1 .. $param) «==» @hcs)) {
        return False;
    }
    for 0 .. $param - 2 -> $i {
        my $pn = @hc[$i] + @hc[$i + 1];
        my $sn = isqrt($pn);
        if ($pn != $sn * $sn) {
            return False;
        }
    }
    my $pn = @hc[0] + @hc[*-1];
    my $sn = isqrt($pn);
    if ($pn != $sn * $sn) {
        return False;
    }
    True;
}

sub hamiltoniancycle($a) {
    if ($a < 31) {
        return [];
    }
    my %perfectsquares = Set.new((1 .. $a).map({$_ ** 2}));
    my %neighbours;
    for 1 .. $a -> $x {
        for %perfectsquares.keys -> $y {
            if ($y > $x) {
                my $z = $y - $x;
                if ($z <= $a) {
                    unless (%neighbours{$x}:exists) {
                        %neighbours{$x} = SetHash.new;
                    }
                    %neighbours{$x}{$z}++;
                    unless (%neighbours{$z}:exists) {
                        %neighbours{$z} = SetHash.new;
                    }
                    %neighbours{$z}{$x}++;
                }
            }
        }
    }
    my @stack;
    @stack.push([1]);
    while (@stack.elems > 0) {
        my @lst = (@stack.pop).flat;
        if (@lst.elems == $a) {
            if (%perfectsquares{@lst[0] + @lst[*-1]}:exists) {
                return @lst;
            }
        } else {
            my %ls = Set(@lst);
            for %neighbours{@lst[*-1]}.keys -> $candidate {
                unless (%ls{$candidate}:exists) {
                    my @nlst = @lst.clone;
                    @nlst.push($candidate);
                    @stack.push(@nlst);
                }
            }
        }
    }
    [];
}
