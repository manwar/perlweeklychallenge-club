use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-29
# Challenge 180 First Unique Character ( Raku )

my %letters;
my @arr;
my $index;

my @strs = ('Long Live Perl','Perl Weekly Challenge');

for ( @strs ) -> $str {

  $index = 0;

  print "Input: \$s = \"$str\"\n";

  mysetup($str);

  myprocess();

}

sub mysetup($str) {

  %letters = ();

  @arr = $str.comb;

  for (@arr) {

    $_ = lc($_);

    if ! %letters{$_} {

      %letters{$_} = 1;

    } else {

      %letters{$_}++;

    }

  }

}

sub myprocess {

  while $index <= @arr.end {

    if (%letters{@arr[$index]} == 1) {

      print("Output: $index as \"@arr[$index]\" is the first unique character\n\n");

      last;

    }

    $index++;

  }

}
