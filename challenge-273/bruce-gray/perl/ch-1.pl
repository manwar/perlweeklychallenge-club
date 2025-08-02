#!perl
use v5.36;
use POSIX qw<lround>;

sub task1 ($str, $char) {

    my $count =()= $str =~ m{$char}g;   # Google perlsecret.pod
    # Note: e-choroba adds `\Q`, to make `m{\Q$char}g`, which is technically safer.

    return lround( 100 * $count / length($str) );
}
# As mentioned in PerlFAQ4, rounding via `sprintf '%.0f' would get the rounding wrong on `analitik`, since it uses "statistician's rounding", making `12.5` into `12` where `lround` give us the `13` that the task's example #6 lists as output. See:
#   https://perldoc.perl.org/perlfaq4#Does-Perl-have-a-round()-function?-What-about-ceil()-and-floor()?-Trig-functions?
#   https://en.wikipedia.org/wiki/Rounding#Rounding_half_to_even
#   https://pubs.opengroup.org/onlinepubs/9699919799/functions/round.html
#   https://pubs.opengroup.org/onlinepubs/9699919799/functions/lround.html


my @tests = qw<
    perl      e 25
    java      a 50
    python    m  0
    ada       a 67
    ballerina l 22
    analitik  k 13
>;
use Test2::V0 -no_srand => 1; plan @tests/3;
for my ( $str, $char, $expected ) (@tests) {
    is task1( $str, $char ), $expected;
}
