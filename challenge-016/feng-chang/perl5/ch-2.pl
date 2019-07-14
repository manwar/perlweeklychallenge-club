#!/bin/env perl

use Modern::Perl;
use bigint;
use Getopt::Long;
use Crypt::Digest::SHA256 qw(sha256);

# digit '0', capital 'I', 'O', lower case 'l' ared not allowed
# lower case 'o', and digit '1' are used
my @A = ('1'..'9', 'A'..'H', 'J'..'N', 'P'..'Z', 'a'..'k', 'm'..'z');

my %H;
map { $H{ $A[$_] } = $_ } 0 .. scalar @A - 1;

my $key = '1AGNa15ZQXAZUgFiqJ2i7Z2DPU2J6hW62i';
GetOptions('key=s', \$key);

my @key = long2short($key);
if (pack('C4', @key[21..24]) eq cksum(pack('C21', @key[0..20]))) {
    say 'ok';
} else {
    say 'not ok';
}

# convert 34-byte bitcoin address to standard 25-byte form
sub long2short {
    my $n = 0;
    for my $c (split //, shift) {
        die "invalid character '$c'\n" unless defined $H{ $c };
        $n *= 58;
        $n += $H{ $c };
    }

    my @key = (0) x 25;
    for (my $i = 24; $i >= 0 && $n > 0; --$i) {
        $key[$i] = $n % 256;
        $n /= 256;
    }
    die "address too long: n = $n\n" if $n;

    return @key;
}

sub cksum {
    return substr sha256(sha256 shift), 0, 4;
}
