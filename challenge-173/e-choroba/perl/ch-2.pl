#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ product };
use Math::BigInt;

{   my $ONE = 'Math::BigInt'->new('1');
    sub sylvesters_sequence ($size) {
        my @sequence;
        while (@sequence < $size) {
            push @sequence, $ONE + product(@sequence);
        }
        return \@sequence
    }
}

use Test::More tests => 1;

is_deeply sylvesters_sequence(10),
    [qw[ 2
         3
         7
         43
         1807
         3263443
         10650056950807
         113423713055421844361000443
         12864938683278671740537145998360961546653259485195807
         165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
   ]];
