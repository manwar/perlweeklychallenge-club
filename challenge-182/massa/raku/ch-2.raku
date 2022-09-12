use v6.d;

my sub parents(\f) {
  $_ = f.IO.cleanup;
  [ reverse gather { .Str.take if .d; loop { $_.=parent; .Str.take; last when '/' } } ]
}

@*ARGS.map(&parents).&zip.grep({ last unless [eq] $_; True }).tail.tail.say

