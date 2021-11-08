#! /usr/bin/env raku

unit sub MAIN (Str $file where $file.IO.f && $file.IO.r, :l(:$limit) = 15);

my $missing = (1 .. $limit) (-) $file.IO.lines.map({ /^(\d+)\,/ && $0.Int });

say "Missing row{ $missing.keys > 1 ?? "s" !! "" }: { $missing.keys.sort.join(", ") }";
