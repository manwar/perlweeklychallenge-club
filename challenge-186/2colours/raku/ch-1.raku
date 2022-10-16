#!/usr/bin/env raku

sub zip(@a, @b) {
  flat @a Z @b
}

sub MAIN('test') {
  say zip <1 2 3>, <a b c>;
  say zip <<'work it' 'make it' 'do it' 'makes us'>>, <harder better faster stronger>;
}
