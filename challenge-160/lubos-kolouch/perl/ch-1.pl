package main;
use strict;
use warnings;
use Lingua::EN::Numbers qw(num2en);

sub four_magic {
    my $what = shift;

    my @output;

    while (1) {
        my $new_num = length( num2en($what) );

        if ( $what == 4 ) {
            push @output, num2en($what) . " is magic.";
            last;
        }
        push @output, num2en($what) . " is " . num2en($new_num);
        $what = $new_num;
    }

    my $out_str = join ", ", @output;
    $out_str =~ s/(^.)/\U$1/msx;

    return $out_str;
}

use Test::More;

is( four_magic(5), "Five is four, four is magic.",                'Test 5' );
is( four_magic(7), "Seven is five, five is four, four is magic.", 'Test 7' );
is( four_magic(6),
    "Six is three, three is five, five is four, four is magic.",
    'Test 6' );
done_testing;
1;
