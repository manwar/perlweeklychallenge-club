use strict;
use warnings;
use feature qw /say/;

for my $k ($ARGV[0]..$ARGV[1]) {
    next unless $k =~ /^[0689]+$/;
    my $i = reverse $k;
    $i =~ tr/69/96/;
    say $k if $i eq $k;
}
