sub f { pop =~ s/ \d\d\# / chr( 96 + $&) /regx =~ s/ \d / chr( 96 + $&) /regx }

print f( $$_[0] ) eq $$_[1] ? "ok\n" : "ERROR\n" for map [ split ], split /\n/, <<''
10#11#12  jkab
1326#     acz
25#24#123 yxabc
20#5      te
1910#26#  aijz

# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
