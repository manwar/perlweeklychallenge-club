perl -E '%a = map {$_ => 1} split //, $ARGV[0]; say scalar grep {exists $a{$_}} split //, $ARGV[1]' chancellor chocolate

