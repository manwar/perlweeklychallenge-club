#! /usr/bin/perl6

my @seq=@*ARGS;
my $depth=shift @seq;

for (1..$depth) {
  my @o=map {@seq[$_+1]-@seq[$_]}, (0..@seq.end-1);
  @seq=@o;
}

say join(' ',@seq);
