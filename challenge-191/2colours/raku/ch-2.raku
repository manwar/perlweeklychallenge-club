#!/usr/bin/env raku

constant $limit = 15;
subset ValidInt of Int where 0 < * <= $limit;
sub generate-options(ValidInt $n) {
  ($_ => (1 .. $n).grep(-> $i { $i %% $_ || $_ %% $i }).Set for 1 .. $n)
}

proto count-cutes(%) {*}
multi count-cutes(% () --> 1) {}
multi count-cutes(%options-left) {
  my ($picked-position, $picked-choices) = %options-left.min(*.value.elems).kv;
  $picked-choices
    .keys
    .map: -> $current-choice {
      my %options-left-updated = %options-left;
      %options-left-updated{$picked-position}:delete;
      %options-left-updated.values X(-)= $current-choice;
      samewith %options-left-updated      
    } andthen
    .sum 
}


sub MAIN(ValidInt $n) {
  my %current-options = generate-options $n;
  %current-options andthen
    .&count-cutes
    .say;
}
