#! /usr/bin/perl6

# Write a script that can wrap the given paragraph at a specified
# column using the greedy algorithm.

my $width=72;

my $s=$width;
my @w;
for lines() {
  .chomp;
  if ($_ eq '') {
    if (@w) {
      print join(' ',@w),"\n";
      @w=();
      $s=$width;
    }
    print "\n";
  } else {
    for split ' ',$_ -> $w {
      my $lw=chars($w);
      if ($lw+1 > $s) {
        print join(' ',@w),"\n";
        @w=($w);
        $s=$width-$lw;
      } else {
        push @w,$w;
        $s-=($lw+1);
      }
    }
  }
}
if (@w) {
  print join(' ',@w),"\n";
}
