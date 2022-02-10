#!/usr/bin/env perl
use Modern::Perl;
use experimental qw<signatures>;
use List::Util   qw<uniq>;
use Math::BigInt;
# use Math::BigInt only => 'GMP,Pari';

sub largest_rep_free_square_in_base ($base) {
    # 'BA9876543210' for $base==12
    my $highest = join '', map { Math::BigInt->new($_)->to_base($base) }
                  reverse 0 .. $base-1;

    # $square will be a _single_ Math::BigInt. 
    # $root will be plain perl IV for speed. (Will overflow past base==27)
    my $root   = Math::BigInt->from_base($highest, $base)->bsqrt->numify();
    my $square = Math::BigInt->new($root) ** 2;

    while ($root) {
        my @digits = split '', $square->to_base($base);
        return $root if @digits == uniq(@digits);

        $square->bsub( $root + $root - 1 ); # (a - 1)² == a² - 2a + 1
        $root--;
    }
    return;
}

my @bases = map { /(\d+)-(\d+)/ ? ($1..$2) : $_ } @ARGV;
@bases = (2 .. 12, 14 .. 16, 18) if not @bases;

for my $base (@bases) {
    my $root = largest_rep_free_square_in_base($base);
    my @rs = ( $root, $root**2 );

    printf "%2s  %10s  %20s  %8s  %16s\n",
        $base, @rs, map { Math::BigInt->new($_)->to_base($base) } @rs;
}
