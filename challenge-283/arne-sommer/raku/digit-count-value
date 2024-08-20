#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ UInt && @ints.elems > 0,
	       :a(:$all),
               :v(:$verbose) = $all);

my $bag    = @ints>>.Int.Bag;
my $status = True;

say ": Bag: { $bag.raku }" if $verbose;

for ^@ints.elems -> $index
{
  my $val   = @ints[$index];
  my $count = $bag{$index};

  my $is-ok = $val == $count;
  say ": \@ints[{ $index }] = { $val }, the digit { $index } occurs { $count } time(s) | { $is-ok ?? "OK" !! "Not OK" }" if $verbose;

  unless $is-ok
  {
    $status = False;
    last unless $all;
  }
}

say $status;
