# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

print((join( "", (!($_ % 3) and "Fizz" or ""), (!($_ % 5) and "Buzz" or "") ) or $_), "\n") for 1..20;
