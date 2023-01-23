sub draw-number-as-ascii (Int:D $number) {
  my @encodings = $number.comb.map({
    given $_ {
      when 0 { 'abcdef' }
      when 1 { 'bc' }
      when 2 { 'abdeg' }
      when 3 { 'abcdg' }
      when 4 { 'bcfg' }
      when 5 { 'acdfg' }
      when 6 { 'acdefg' }
      when 7 { 'abc' }
      when 8 { 'abcdefg' }
      when 9 { 'abcfg' }
    }
  });
  my @ascii-matrix;
  for @encodings -> $encoding {
    sub three-segments (Str $left_segment, Str $bottom_segment, Str $right_segment, @lines where .elems == 3) {
      my @chars = $encoding.contains($left_segment,) ?? '|' !! ' ';
      @chars.push: '     ';
      @chars.push: $encoding.contains($right_segment) ?? '|' !! ' ';
      @ascii-matrix[$_].push: @chars.join for @lines[0..1];
      @chars[1] = '_____' if $encoding.contains($bottom_segment);
      @ascii-matrix[@lines[2]].push: @chars.join;
    }
    @ascii-matrix[0].push: $encoding.contains('a') ?? ' _____ ' !! '       ';
    three-segments 'f', 'g', 'b', 1..3;
    three-segments 'e', 'd', 'c', 4..6;
  }
  for @ascii-matrix -> @line {
    say @line.join: ' '
  }
}

draw-number-as-ascii 200;
draw-number-as-ascii 198;
draw-number-as-ascii 987654321;
draw-number-as-ascii 123456789;
