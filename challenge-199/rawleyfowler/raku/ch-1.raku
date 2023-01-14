my @lst = @*ARGS[0].split: /\s/;
die 'No list provided' unless @lst.elems > 0;

loop (my $i = 0; $i < @lst.elems; $i++) {
  state $count = 0;
  loop (my $j = $i + 1; $j < @lst.elems; $j++) {
    $count++ if @lst[$i] == @lst[$j];
  }
  say $count if $i + 1 == @lst.elems;
}
