#! /usr/bin/env raku

unit sub MAIN ($routes, :s(:$source), :d(:$destination), :v(:$verbose));

my @routes = $routes.split("|")>>.words>>.Array;
my %next;

if $verbose
{
  say ":Source: $source";
  say ":Routes: { @routes.raku }";
  say ":Destination: $destination";
}

for @routes -> @route
{
  my $first = @route.shift;

  while @route
  {
    my $second = @route.shift;

    next if $first eq $second;

    %next{$first}.push: $second;
    %next{$second}.push: $first;
    
    $first = $second;
  }
}

unless %next{$source}
{
  say ":Source not in route(s)" if $verbose;
  say '-1';
  exit;
}

unless %next{$destination}
{
  say ":Destination not in route(s)" if $verbose;
  say '-1';
  exit;
}

say ":Tree: { %next.raku }" if $verbose;

my @paths = ($source.Str);

while @paths.elems
{
  say ":Queue of Paths: { @paths.raku }" if $verbose;

  my @path = | @paths.shift;

  my $current = @path.tail;

  say ":Path: { @path.raku } (current end pos: { $current.raku }) with nexts: { %next{$current}.raku }" if $verbose;

  my $exits = %next{$current} // next;

  for @$exits -> $next
  {
    my @copy = @path.clone;

    next if $next eq any @copy;

    @copy.push: $next;

    say ":Path: { @copy.raku } (former end pos: { $current.raku })" if $verbose;

    if $next eq $destination
    {
      say "({ @copy.join(",") })";
      exit;
    }

    @paths.push: @copy;
  }
}

say "-1";
