#!/usr/bin/env raku

my @dates = do for 1, 2 {
  prompt("\$date$_ = ").Date
};

if [<=] @dates {
  @dates .= reverse;
}
else {
  print '- ';
}
my $delta-years = [-] @dates>>.year;
@dates[1] .= later: years => $delta-years;
if [<] @dates {
  $delta-years--;
  @dates[1] .= earlier: :1years;
}
my $delta-days = [-] @dates;
my @output-parts;
given $delta-years {
  @output-parts.push: "$_ year" if $_ > 0;
  @output-parts ~= 's' if $_ > 1; 
}
given $delta-days {
  @output-parts.push: "$_ day" if $_ > 0;
  @output-parts ~= 's' if $_ > 1; 
}
say @output-parts.join: ' ';