#! /usr/bin/env raku

unit sub MAIN (:$verbose);

my @people = 1 .. 50;

my $next = 1;

say ": @people[] [Index: $next]" if $verbose;

while @people.elems > 1
{
  my $killed = @people.splice($next, 1);

  $next++;
  $next = 0 if $next > @people.end;

  say ": @people[] [K:$killed] [Next:$next]" if $verbose;
}

say "Living: @people[]";