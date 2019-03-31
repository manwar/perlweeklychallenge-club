perl6 -e 'my $str = "Perl Weekly Challenge"; my $count = ($str ~~ s:g/e/E/).elems; say "$str has $count letter e'\''s in it.";'
