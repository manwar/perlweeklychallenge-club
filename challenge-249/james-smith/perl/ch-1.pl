sub equal_pairs {
  my(%C,$t);
  $C{$_}++ for @_;            ## Collect counts
    (grep { $_%2 } values %C) ## Are all counts event...!
  ? ()                        ## No return nothing...
  : [map { $t=$_;             ## Make "n/2" copies of [X,X]
            map { [$t,$t] } 1..$C{$t}/2
         } keys %C ]
}
