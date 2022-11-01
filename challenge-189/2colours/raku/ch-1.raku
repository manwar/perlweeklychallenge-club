#!/usr/bin/env raku

subset ArrayOfCharacters of Str where /^ 'qw/' (<[a..z]>) ** 0..* % \s+ '/' $/;
subset Character of Str where /^ \' (<[a..z]>) \' $/;

sub MAIN(
  $array, #= qw// style @array as string
  $in-target #= character enclosed in apostrophes
) {
  die 'Invalid @array argument.' unless $array ~~ ArrayOfCharacters;
  my @array = ~<<$0;
  die 'Invalid $target argument' unless $in-target ~~ Character;
  my $target = ~$0;
  @array
    .grep: * after $target andthen
    .so ?? .min !! $target andthen
    .say; 
}