printf "%s\n", join(", ", map{$_->[0]} grep{!scalar(grep{$_ % 2 == 0} split //, $_->[1])} map{[$_, $_ + join "", reverse split //, $_]} 10..99);
