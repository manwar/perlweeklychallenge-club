#!/usr/bin/perl
use warnings;
use strict;

use Perl::Version;

sub compare_versions {
    my ($v1, $v2) = @_;
    'Perl::Version'->new($v1) <=> 'Perl::Version'->new($v2)
}

use Test::More tests => 5;

is compare_versions('0.1',   '1.1'),   -1;
is compare_versions('2.0',   '1.2'),    1;
is compare_versions('1.2',   '1.2_5'), -1;
is compare_versions('1.2.1', '1.2_1'),  1;
is compare_versions('1.2.1', '1.2.1'),  0;

__END__

# Fails test no. 4

use version;
sub compare_versions {
    my ($v1, $v2) = @_;
    'version'->parse($v1) <=> 'version'->parse($v2)
}
