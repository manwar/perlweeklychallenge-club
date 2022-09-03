my $s = "Long Live Perl";
say index($s, first { $s.indices($_).elems == 1 }, $s.comb );
