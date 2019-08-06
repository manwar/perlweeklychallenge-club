#! /usr/bin/perl6

for @*ARGS -> $in {
  say join(' ',splitchange($in));
}

sub splitchange ($in) {
   return map {$_.Str}, $in ~~ m:g/(.) {} :my $c = $0; ($c*)/;
}
