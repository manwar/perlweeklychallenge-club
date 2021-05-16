#!/usr/bin/env raku

sub challenge(Str $path is copy) returns Str {
  die "Must be an absolute path" unless $path.starts-with('/');

  $path = $path.substr(1);
  $path = $path.subst(/\/ ** 2..*/, '/', :global);
  $path = $path.substr(0, *-1) if $path.ends-with('/');

  my @output;
  for $path.split('/') -> $dir {
    given $dir {
      when '.' { Nil }
      when '..' {
        die "Illegal path" if @output.elems == 0;
        @output.pop;
      }
      default { @output.push($dir) }
    }
  }
  '/' ~ @output.join('/')
}

multi sub MAIN(Str $path) {
  say challenge($path);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
  ('/a/', '/a'),
  ('/a/b//c/', '/a/b/c'),
  ('/a/b/c/../../', '/a'),
  ('/a/b/./c/./d/', '/a/b/c/d')
  );

  for @tests -> ($input, $expected) {
    is(challenge($input), $expected);
  }

  done-testing;
}
