use strict;
use warnings;
use feature "say";

my @tests = ( [qw< abc xyz >], [qw< abb xyy >], [qw< sum add >],
    [qw< ACAB XCXY >], [qw< abc uvwxy >] );

    for my $strings_ref (@tests) {
        say "@$strings_ref: ", is_isomorphic(@$strings_ref);
    }

sub is_isomorphic {
    my ($str1, $str2) = @_;
    return 0 if length $str1 != length $str2;
    my (%transcode, %seen);
    for my $i (0..length($str1) - 1) {
        my $char1 = substr $str1, $i, 1;
        my $char2 = substr $str2, $i, 1;;
        if (exists $transcode{$char1}) {
            return 0 if $transcode{$char1} ne $char2;
        } else {
            return 0 if exists $seen{$char2};
            $transcode{$char1} = $char2;
            $seen{$char2} = 1;
        }
    }
    return 1
}
