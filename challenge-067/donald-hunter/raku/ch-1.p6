sub number-combinations($m, $n, :$width = 96) {
      my @combinations =
          (1..$m).combinations($n)           # generate the combinations
                 .map({ "[{.join: ','}]" }); # format each combination

      my $per-line = $width div @combinations.map({ .chars + 2 }).max;

      ('[ ' ~
          @combinations
               .rotor($per-line, :partial)   # split into n per line
               .map({ .join(', ') })         # join items on same line
               .join(",\n  ")                # join the lines
       ~ ' ]').say
}

number-combinations(8, 3)
