#! /usr/bin/env raku

unit sub MAIN (*@S where @S.elems > 1, :v(:$verbose), :n(:$no-duplicates));

die "Non-unique string not allowed" if $no-duplicates && @S.elems != @S.unique.elems;

for @S.permutations -> @perm
{
  say ": perm: { @perm.join(", ") }" if $verbose;

  if is-circle(@perm)
  {
    say 1;
    exit;
  }
}

say 0;

sub is-circle (@list is copy)
{
  my $first       = @list.shift;
  my $first-start = $first.substr(0,1);
  my $second;

  while @list
  {
    $second = @list.shift;
    return False if $first.substr(*-1,1) ne $second.substr(0,1);
    $first  = $second;
  }
    
  return True if $first-start eq $second.substr(*-1,1);
  return False;
}
