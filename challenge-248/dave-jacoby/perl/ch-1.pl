#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min };

my @examples = (

    { str => "loveleetcode", char => "e" },
    { str => "aaab",         char => "b" },

);

for my $example (@examples) {
    my @output = shortest_distance($example);
    my $output = join ',', @output;

  # my $input  = join ",\n\t", map { qq{"$_"} }    # quote surname
  #     map  { $_->[0] }                           # remove surname element
  #     sort { $a->[1] cmp $b->[1] }               # sort on surname
  #     map { [ $_, ( reverse split /\s/, $_ )[0] ]
  #     }    # start schartzian transform on surname
  #     sort { $a cmp $b } $example->@*; # sort alphabetically for consistency
  # my $output = join "\n\t",
  #     map  { qq{$_ -> $output{$_}} }    # combine santa and giftee
  #     map  { $_->[0] }                  # remove surname element
  #     sort { $a->[1] cmp $b->[1] }      # sort on surname
  #     map {
  #     [ $_, ( reverse split /\s/, $_ )[0] ]
  #     }    # start schartzian transform on surname
  #     sort { $a cmp $b } keys %output; # sort alphabetically for consistency

    say <<~"END";
    Input:  \$str = "$example->{str}", \$char = "$example->{char}"
    Output: ($output)
    END

}

# 1) everybody gets matched
# 2) nobody gets matched to themself
sub shortest_distance ($input) {
    my $str   = $input->{str};
    my $char  = $input->{char};
    my @input = grep { $char eq substr $str, $_, 1 } 0 .. length $str;
    my @output;

    for my $i ( 0 .. -1 + length $str ) {
        my $c = substr $str, $i, 1;
        push @output, min map { abs $_ - $i } @input;
    }

    return @output;
}
