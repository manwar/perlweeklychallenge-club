#! perl
use v5.40.0;
use Test2::V0 -no_srand => 1;

is remove_digits('cab12'),     'c',  'first example';
is remove_digits('xy99'),       '',  'second example';
is remove_digits('99999xy'),  'xy',  'third example';
done_testing;

sub remove_digits ($str) {
    $str = substr($str,1) while $str =~ /^\d/;
    while ($str =~ /\d/) {
        $str =~ s/.\d//;
    }
    $str;
}
