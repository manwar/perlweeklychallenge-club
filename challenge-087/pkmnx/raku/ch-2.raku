#!/usr/bin/env rakudo
#
# run: ./ch-2.raku < input.txt
# where input.txt can be:
#
# 00011111100000000000
# 00011111100000000000
# 00011111100000000000
# 00011111111100000000
# 00000111111100000000
# 00000111111100000000
# 00000111111100000000
# 00000000000000000000
#
# or:
# 0 0 0 ...
#
# or: 
# [ 0 0 0 ... ]
#
# as white space ignored & chars not 0 | 1 ignored.
#

use lib './lib';
use MatInput;

sub MAIN() {

   my $m = mat.new();
   $m.addData($*IN);

   $m.dispRows();
   $m.getLargestBoxes();
 
}
