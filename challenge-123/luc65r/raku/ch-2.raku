#!/usr/bin/env raku

unit sub MAIN(*@coordinate where +* == 8);

my Complex @pts = map { Complex.new($^x, $^y) }, @coordinate;
my Complex $center = @pts.sum / 4;
my Complex $v = @pts[0] - $center;
say +so @pts ≡ ($v, -$v, $v.conj, -$v.conj) »+» $center;
