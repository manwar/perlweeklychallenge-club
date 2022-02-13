#!/usr/bin/env raku

multi minimum-depth(@tree where *.first == 0 --> 0) {}
multi minimum-depth(@tree where * == 1 --> 1) {}
multi minimum-depth(@tree) { minimum-depth(@tree.skip.List, 1, (True,)) }
multi minimum-depth((), $current-assumption, @) { $current-assumption }
multi minimum-depth((@head, *@tail), $current-assumption, @prev-filter) {
  my @common-children = @head.rotor(2, :partial);
  when +@common-children <= (-1 R// @prev-filter.first: *.so, :end, :k) { $current-assumption }
  when @prev-filter Z&& @common-children
    andthen .grep: * !=== False
    andthen .map: *.all eq '*'
    andthen .any { $current-assumption }
  minimum-depth(@tail, $current-assumption + 1, @head.map(* ne '*').List);
}
my @tree-lines = prompt('Input: ').split('|').map(*.words.List);
say "Output: {minimum-depth(@tree-lines)}";
