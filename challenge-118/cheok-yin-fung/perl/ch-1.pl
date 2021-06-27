#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 7;

my $r = $ARGV[0] || 0;
print binpali($r),"\n";



sub binpali {
    my @d = dec2binarr($_[0])->@*;
    return (join "", @d) eq (join "", reverse @d) ? 1 : 0;
}


sub dec2binarr {
    my $s = $_[0];
    my $i = 0;
    my @digit;
    while ($s != 0) {
        ($s, $digit[$i] ) = divmod($s)->@*;
        $i++;
    }
    return [@digit];
}


sub divmod {
    my $num = $_[0];
    return [int $num / 2 , $num % 2];
}



ok (binpali(3) == 1, "test target: 3");
ok (binpali(4) == 0, "test target: 4");
ok (binpali(6) == 0, "test target: 6");
ok (binpali(1023) == 1, "test target 1023");
ok (binpali(oct "0b1001001" ) == 1, "the 5th test");
ok (binpali(oct "0b1000011100001" ) == 1, "the 6th test");
ok (binpali(oct "0b101001" ) == 0, "the 7th test");
 
