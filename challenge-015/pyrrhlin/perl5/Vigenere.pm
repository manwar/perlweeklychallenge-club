package Vigenere;

# implement the cipher of the same name.

use 5.18.0;
use parent 'Exporter';
our @EXPORT = qw<vencode vdecode>;

use integer;
use List::SomeUtils qw<pairwise>;

my $basis = join '', 'A' .. 'Z';
my $blength = length $basis;

our $debug = 0;

sub _normalize {
    return unless my $plaintext = uc(shift);
    $plaintext =~ tr/A-Z//cd;
    return $plaintext;
}
sub _ordify {
    return map {ord($_) - 65} split //, shift;
}
sub _stringify {
    return join '', map {chr($_ + 65)} @_;
}
sub _keyshifts {
    my ($key, $len) = @_;
    my @rots = _ordify($key);
    push @rots, @rots while @rots < $len;
    splice(@rots, $len);
    return @rots;
}


sub vencode ($@) {
    my $msg = _normalize(shift) || die "cipher can only encode ascii letters";
    while (my $key = _normalize(shift)) {
        say "key:  [$key]" if $debug;
        my @mchars = _ordify($msg);
        my @rots = _keyshifts($key, length($msg));
        my @res = pairwise {($a + $b) % $blength} @mchars, @rots;
        $msg = _stringify(@res);
        if ($debug) {
            say "msg @mchars";
            say "rot @rots";
            say "res @res";
        }
    }
    return $msg;
}

sub vdecode ($@) {
    my $msg = shift;
    die "some chars in ciphertext cannot have been encoded" if $msg =~ tr/A-Z/ /c;
    while (my $key = _normalize(shift)) {
        my @mchars = _ordify($msg);
        my @rots = _keyshifts($key, length($msg));
        my @res = pairwise {($blength + $a - $b) % $blength} @mchars, @rots;
        $msg = _stringify(@res);
    }
    return $msg;
}

1;

