#!/usr/bin/perl;
use strict;
use warnings;

print grep { $_ % 15 == 0 ? $_ = 'fizzbuzz' : $_ % 5 == 0
	? $_ = 'fizz' : $_ % 3 == 0 ? $_ = 'buzz' : $_ } 1..20;

__END__
