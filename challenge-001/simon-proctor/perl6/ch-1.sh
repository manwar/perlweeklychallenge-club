perl6 -e 'my $s = "Perl Weekly Challenge";"Number of e {($s ~~ m:g/e/).elems.say}";$s ~~ s:g/e/E/;"Updated {$s.say}"'
