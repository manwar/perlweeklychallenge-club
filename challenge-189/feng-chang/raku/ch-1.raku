#!/bin/env raku

unit sub MAIN(*@C);

my $c = @C.pop;
put do given @C.grep(* gt $c).min {
    when 'a'..'z' { $_ }
    default       { $c }
}
