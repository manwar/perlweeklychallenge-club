#! /usr/bin/env raku

unit sub MAIN (Int $year);

my @animals   = <Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig>;
my @elements  = <Wood Wood Fire Fire Earth Earth Metal Metal Water Water>;

my $animals   = @animals.elems;
my $elements  = @elements.elems;

my $base-year = 1924;
my $year-diff = $year - $base-year;

say "{ @elements[ $year-diff % $elements] } { @animals[ $year-diff % $animals] }"; 
