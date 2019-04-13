# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

print((($_ eq "e") and uc($_) or $_)) for split("", "Perl Weekly Challenge")
