#! /usr/bin/perl6

my $minlen=5;

my $y;
my @grid;
my @searchspaces;
my $fh=open :r,@*ARGS[0] or die "Can't open puzzle file\n";
for $fh.lines {
  .chomp;
  (my $line=$_) ~~ s:global/\s+//;
  $line=lc($line);
  if (defined $y) {
    if ($y != chars($line)) {
      die "Not a rectangular grid\n";
    }
  } else {
    $y = chars($line);
  }
  push @searchspaces,$line; # horizontal forward
  push @grid,$line.comb;
  push @searchspaces,join('',reverse(@grid[@grid.end])); # horizontal backward
}
close $fh;
my $x=@grid.elems;

for (0..$y-1) -> $i {
  my @q=map {@grid[$_][$i]}, (0..$x-1);
  push @searchspaces,join('',@q); # vertical forward
  push @searchspaces,join('',reverse @q); # vertical backward
}

{
  # +x +y diagonals
  my $mxy=max($x,$y)-1;
  for (-$y+$minlen-1..$x-$minlen+1) -> $xi {
    my @seq=map {($xi+$_,$_)}, grep {$xi+$_ >= 0 && $xi+$_ < $x && $_ < $y}, (1..$mxy);
    if (@seq.elems >= $minlen) {
      my @q=map {@grid[$_.[0]][$_.[1]]}, @seq;
      push @searchspaces,join('',@q);
      push @searchspaces,join('',reverse @q);
    }
  }
  # -x +y diagonals
  for (-$y+$minlen-1..$x-$minlen+1) -> $xi {
    my @seq=map {[$xi+$_,$y-$_]}, grep {$xi+$_ >= 0 && $y-$_ >= 0 && $xi+$_ < $x}, (1..$mxy);
    if (@seq.elems >= $minlen) {
      my @q=map {@grid[$_.[0]][$_.[1]]}, @seq;
      push @searchspaces,join('',@q);
      push @searchspaces,join('',reverse @q);
    }
  }
}

my @found;
$fh=open :r,@*ARGS[1] or die "Can't open wordlist file\n";
for $fh.lines {
  .chomp;
  if (chars($_) >= $minlen) {
    my $w=lc($_);
    for (@searchspaces) -> $ss {
      with index($ss,$w) -> $ix {
        push @found,$w;
        last;
      }
    }
  }
}
say join(', ',sort @found);
