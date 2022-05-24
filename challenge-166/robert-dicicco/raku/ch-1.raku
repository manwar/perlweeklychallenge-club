use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-05-23
# Challenge 166 Hexadecimal Words ( Raku )

my %letters = 'a'=>'a','b'=>'b','c'=>'c','d'=>'d','e'=>'e','f'=>'f','o'=>'0','l'=>'1','i'=>'1','s'=>'5','t'=>'7';
my $found = 0;
my $selection = 0;

sub MAIN( UInt $selection ) {
  die "Length Selection Error. Selection must be between 2 and 8 inclusive" if ($selection < 2 or $selection > 8);

  MY_LOOP:
  for 'Words.txt'.IO.lines  {
    my $line_lc = $_;
    $line_lc = $line_lc.trim.lc;
    next MY_LOOP if $line_lc.chars != $selection;

    my @arr = $line_lc.comb;

    for ( @arr ) -> $letter {
      if %letters{$letter}  { $found++; }
    }

    if $found == $selection {
      $line_lc ~~ tr/olist/01157/;
      print "$line_lc ";
    }

    $found = 0;
  }

}
