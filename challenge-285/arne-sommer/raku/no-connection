#! /usr/bin/env raku

unit sub MAIN (*@routes where @routes.elems > 0, :v(:$verbose));

my %outgoing;

for @routes -> $route
{
  my ($from, $to) = $route.split(/\s+/);

  say ": Route from '$from' to '$to'" if $verbose;

  %outgoing{$from}++;
  %outgoing{$to} = 0 unless defined %outgoing{$to};
}

if $verbose
{
  for sort keys %outgoing -> $key
  {
    say ": '$key' has %outgoing{$key} outgoing connectiuon(s)" if $verbose;
  }
}

say %outgoing.grep( *.value == 0 )>>.key.join(", ");
