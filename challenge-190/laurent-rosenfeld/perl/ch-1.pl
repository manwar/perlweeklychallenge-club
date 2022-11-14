use strict;
use warnings;
use feature qw/say/;

sub is_correct_case {
    my $str = shift;
    # All lowercase or all uppercase:
    return 1 if $str =~ /^[a-z]+$|^[A-Z]+$/;
    # One uppercase followed by only lowercase
    return 1 if $str =~ /^[A-Z][a-z]+$/;
    return 0;
}
for my $str (<Perl TPF PyThon raku Raku RAKU RaKu raKu>) {
    printf "% -8s -> %d\n", $str, is_correct_case $str;
}
