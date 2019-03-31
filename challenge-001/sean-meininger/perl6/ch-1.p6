my $pwc = "Perl Weekly Challenge";
say $pwc.indices("e").elems ~ " is the number of 'e' characters";
say $pwc.subst(/e/,"E",:g);
