raku -e 'say (for ^$_ X ^$_ -> (\a, \b) { $_ => [*] |$_ given $_[a..b] }).max(*.value) given <2 5 -1 3>'
