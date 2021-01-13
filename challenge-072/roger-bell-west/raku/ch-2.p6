#! /usr/bin/perl6

range('input.txt',4,12);

sub range($fn,$a,$b) {
  my $n=0;
  my $fh=open :r,$fn;
  for $fh.lines {
    $n++;
    if ($n > $b) {
      last;
    }
    if ($n>=$a) {
      say $_;
    }
  }
  close $fh;
}
