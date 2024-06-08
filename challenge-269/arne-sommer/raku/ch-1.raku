#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ UInt && all(@ints) > 0, :v(:$verbose));

for @ints.combinations(2..*) -> @combination
{
  my $or       = [+|] @combination;
  my $binary   = $or.fmt('%b');
  my $trailing = so ($binary ~~ /.0$/);

  say ": Combination: { @combination.join(",") } -> or: $or -> binary: $binary | trailing 0: $trailing" if $verbose;

  if $trailing
  {
    say True;
    exit;
  }
}

say False;
