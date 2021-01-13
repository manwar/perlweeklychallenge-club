#! /usr/bin/env raku

subset PositiveInt of Int where * > 0;

unit sub MAIN (*@N where @N.elems && all(@N) ~~ PositiveInt);

my $product = [*] @N;

my @M = @N.map( { $product / $_ });

say '(', @M.join(', '), ')';
