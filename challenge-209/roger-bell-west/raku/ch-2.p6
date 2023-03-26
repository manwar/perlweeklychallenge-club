#! /usr/bin/raku

use Test;

plan 2;

is-deeply(mergeaccount([['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com', 'a1@a.com']]), [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'], ['B', 'b1@b.com']], 'example 1');
is-deeply(mergeaccount([['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com'], ['B', 'b2@b.com', 'b1@b.com']]), [['A', 'a1@a.com', 'a2@a.com'], ['A', 'a3@a.com'], ['B', 'b1@b.com', 'b2@b.com']], 'example 2');

sub mergeaccount(@a) {
  my @aname;
  my $id = 0;
  my %r;
  for @a -> $acc {
    @aname.push($acc[0]);
    for (1..$acc.end) -> $i {
        %r{$acc[$i]}.push($id);
    }
    $id++;
  }
  my %m;
  for (%r.values) -> $idlist {
    if ($idlist.elems > 1) {
      my $root = $idlist[0];
      while (%m{$root}:exists) {
        $root = %m{$root};
      }
      for (1..$idlist.end) -> $i {
        %m{$idlist[$i]} = $root;
      }
    }
  }
  my %staging;
  my %prefix;
  for (0..@a.end) -> $id {
    my $ii = $id;
    while (%m{$ii}:exists) {
      $ii = %m{$ii};
    }
    my $acc = @a[$id];
    if (%prefix{$ii}:!exists) {
      %prefix{$ii} = $acc[0];
    }
    for (map {$acc[$_]}, 1..$acc.end) -> $addr {
      %staging{$ii}{$addr} = 1;
    }
  }
  my @out;
  for (%staging.keys) -> $k {
    @out.push([%prefix{$k}, sort keys %staging{$k}]».List.flat.Array);
  }
  @out = sort {$^a[0] cmp $^b[0] ||
                 $^a[1] cmp $^b[1]}, @out;
  return @out;
}
