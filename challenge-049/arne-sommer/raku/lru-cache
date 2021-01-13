#! /usr/bin/env raku

use lib 'lib';
use Cache::LRU;

unit sub MAIN (Int $limit = 3, :$verbose);

say ": Cache size: $limit" if $verbose;

my $lru = Cache::LRU.new(:$limit, :$verbose);

loop
{
  given prompt "Command (h for help): "
  {
     when /^c[apacity]?$/ { say $lru.get-limit; }
     when /^c[apacity]? \s+ [\= \s+]? (\d+) $/ { $lru.set-limit($0.Int); }
     when /^s[et]?\((\d+) \, \s* (\d+) \) $/ { $lru.set($0.Int, $1.Int); }
     when /^s[et]? \s+ (\d+) \, \s* (\d+) $/ { $lru.set($0.Int, $1.Int); }
     when /^g[et]?\((\d+) \)$/ { say $lru.get($0.Int); }
     when /^g[et]? \s+ (\d+)$/ { say $lru.get($0.Int); }
     when 'd'|'dump' { $lru.dump if $lru.head; }
     when 'data' { $lru.dump2 if $lru.head; }
     when 'h'|'help' { help; }
     when 'quit'|'q' { exit; }
     default { say "- Illegal command. Use 'h' for help"; }
  }
}

sub help
{
  ;
}