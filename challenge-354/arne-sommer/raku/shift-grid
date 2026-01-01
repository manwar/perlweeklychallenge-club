#! /usr/bin/env raku

unit sub MAIN ($matrix,
               UInt :$k where $k > 0,
               :v(:$verbose));

class matrix
{
  has     @.values;
  has Int $.width;

  method new($string)
  {
    my @matrix = $matrix.split("|")>>.words>>.Numeric;

    die "No data" unless @matrix[0].elems;
    die "Uneven row lenghts" unless [==] @matrix>>.elems;
     
    return self.bless(values => @matrix[*;*], width => @matrix[0].elems);
  }

  method matrix
  {
    return @.values.batch($.width);
  }

  method gist
  {
    return "(\n" ~ self.matrix.map({ "  [" ~ @_.join(", ") ~ "]\n" }).join ~ ")";
  }

  method shift(Int $count)
  {
    @.values.unshift(@.values.pop) for ^$count;
  }

}

my $m = matrix.new($matrix);

if $verbose {
  say ": Pre-shift:";
  print $m.gist.lines.map({ ": $_\n"}).join;
}

$m.shift($k);

say $m;
