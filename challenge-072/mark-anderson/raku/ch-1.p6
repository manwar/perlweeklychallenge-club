#!/usr/bin/env raku

unit sub MAIN(UInt $N where 1 <= $N <= 10);

my $factorial = [*] 1 .. $N;

my $ans = do if $factorial ~~ /(0+)$/ { $0.to - $0.from } else { 0 }

my $end = do if $ans <= 1 { q{} } else { "es" }

say $ans ~ ' as $N! = ' ~ "$factorial has $ans trailing zero" ~ $end;
