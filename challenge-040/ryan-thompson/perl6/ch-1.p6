#!/usr/bin/env perl6

# ch-1.p6 - zip6
#
# Ryan Thompson <rjt@cpan.org>

my @a1 = 'ILOVEYOU'.comb;
my @a2 = '24032019'.comb;
my @a3 = '!?X$%^&*'.comb;

# The zip routine, much like Perl 5's List::Utils:
.Str.say for zip @a1, @a2, @a3;

# Or Raku's new chaining infix Z(ip) operator:
.Str.say for @a1 Z @a2 Z @a3;
