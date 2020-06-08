#! /usr/bin/perl6

my $S="perlweeklychallenge";
my @W = ("weekly", "challenge", "perl");

#$S="perlandraku";
#@W = ("python","ruby","haskell");

my $sl=chars($S);

my @l;
my $done=0;

while (!$done) {
  my @c;
  if (@l) {
    @c=map {$_},(shift @l).flat;
  }
  my $cc=join('',@c);
  for @W -> $wc {
    my $ccw=$cc ~ $wc;
    my $ccwl=chars($ccw);
    if ($ccwl <= $sl) {
      with index($S,$ccw) -> $i {
        if ($i==0) {
          my @q=@c;
          push @q,$wc;
          push @l,@q;
          if ($ccwl == $sl) {
            $done=1;
            last;
          }
        }
      }
    }
  }
  unless (@l) {
    last;
  }
}

if (@l) {
  say join(', ',map {'"' ~ $_ ~ '"'},@l[@l.end].flat);
} else {
  say 0;
}
