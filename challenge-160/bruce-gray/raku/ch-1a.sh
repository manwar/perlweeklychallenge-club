raku -e 'my \w = <zero one two three four five six seven eight nine>; say (|(w[@*ARGS[0]], { w[.chars] } … <four>), <magic>).rotor(2 => -1)».join(" is ").join(", ").tc ~ <.>;' $@
