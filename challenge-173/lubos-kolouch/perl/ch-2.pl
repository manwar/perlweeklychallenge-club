use strict;
use warnings;
use Math::BigInt;

sub generate_sylvestver_numbers {
    my $limit = shift;

    my @items   = ( Math::BigInt->new(2) );
    my $product = $items[0];

    while ( scalar @items < $limit ) {
        push @items, Math::BigInt->new( $product + 1 );
        $product *= $items[-1];
    }

    return \@items;
}

use Test::More;

is_deeply(
    generate_sylvestver_numbers(10),
    [
        2, 3, 7, 43, 1807, 3263443,
        Math::BigInt->new('10650056950807'),
        Math::BigInt->new('113423713055421844361000443'),
        Math::BigInt->new('12864938683278671740537145998360961546653259485195807'),
        Math::BigInt->new(
'165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443'
        )
    ]
);

done_testing;
