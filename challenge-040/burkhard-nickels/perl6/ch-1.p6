#!/home/chuck/rakudo/bin/perl6

use strict;

print "ch-1.p6 (Version 1.0) PWC #40 Task #1: Show multiple arrays content.\n";

my @a1 = ('I','L','O','V','E','Y','O','U');
my @a2 = ('2','4','0','3','2','0','1','9');
my @a3 = ('!','?','£','$','%','^','&','*');

loop ( my $i = 0; $i <= @a1.end; $i++ ) {
	print "@a1[$i] @a2[$i] @a3[$i]\n";
}

# What are the differences here to make it working:
# - ch-1.p6, instead of ch-1.pl
# - Shebang: #!/home/chuck/rakudo/bin/perl6 instead #!/usr/bin/perl
#            I installed rakudo to user home.
# - loop, instead of for keyword
# - blank after loop: "loop ("
# - @a1.end, instead of $#a1
# - @a1[$i], instead of $a1[$i] for each list element
#
# What else?
# - Execution time for perl6 is much longer then for perl5, see below.

# ----------------------------------------------------------------------
# # time ./ch-1.p6
# ch-1.p6 (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *
# 
# real	0m0,354s
# user	0m0,484s
# sys	0m0,048s
#
# ----------------------------------------------------------------------
# # time ./ch-1.pl
# ch-1.pl (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *
# 
# real	0m0,015s
# user	0m0,012s
# sys	0m0,000s




