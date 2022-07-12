# The Weekly Challenge 173
# Task 1 Esthetic Number
use v5.30.0;
use List::Util qw/product all/;
use List::MoreUtils qw/slide/;

say es($ARGV[0]) if defined($ARGV[0]); 



sub es {
    return
      1 == length $_[0] ||
      abs(product slide {$a - $b} (split "", $_[0])) == 1 ? 1 : 0;
}

sub es1 {
    return
      1 == length $_[0] ||
      (all {abs $_ == 1} slide {$a - $b} (split "", $_[0])) ? 1 : 0;
}

use Test::More tests=>18;
ok es(5456);
ok !es(120);
ok es(12345);

ok es(54321);
ok !es(53421);
ok es(121);

ok !es(890);
ok es(89);
ok es(9);

ok es1(5456);
ok !es1(120);
ok es1(12345);

ok es1(54321);
ok !es1(53421);
ok es1(121);

ok !es1(890);
ok es1(89);
ok es1(9);

