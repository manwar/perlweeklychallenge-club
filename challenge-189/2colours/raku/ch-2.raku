#!/usr/bin/env raku


subset ArrayOfPosInt of Str where /^ '(' (<[1..9]><[0..9]>*) ** 0..* % [\s* ',' \s*] ')' $/;

sub MAIN(
  $array, #= (x, y, z) style positive integer @array as string 
) {
  die 'Invalid @array argument.' unless $array ~~ ArrayOfPosInt;
  my @array = +<<$0;
  my %positions = @array.antipairs.classify(*.key, as => *.value);
  my $array-degree = %positions.map(*.value.elems).max; 
  my @common-value-ranges <==
    %positions
    .grep: *.value == $array-degree andthen
    .map: *.value.minmax;
  my $slice-size = @common-value-ranges>>.elems.min;
  my @solution-ranges = @common-value-ranges.grep(* == $slice-size);
  @array[@solution-ranges>>.Slip].map(*.raku).join(' or ').say;
}