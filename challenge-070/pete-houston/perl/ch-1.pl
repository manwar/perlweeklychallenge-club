#!/usr/bin/env perl
#===============================================================================
#
#        FILE: 7001.pl
#
#        USAGE: ./7001.pl [ string count offset ]
#
#  DESCRIPTION: Swap "count" characters in string with their offests
#
# REQUIREMENTS: Params::Util
#      AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#===============================================================================

use strict;
use warnings;
use Params::Util '_POSINT';

my ($str, $count, $offset) = get_args ();
print chswap($str, $count, $offset) . "\n";

sub get_args {
    my ($s, $c, $o) = @ARGV;
    unless (defined $o) {
        warn "Not enough arguments so using defaults: 'perlandraku' 3 4\n";
        return ('perlandraku', 3, 4);
    }
    die "Count must be natural number (not $c)" unless _POSINT($c);
    die "Offset must be natural number (not $o)" unless _POSINT($o);
    die "Offset ($o) must be not be less than count ($c)" if $o < $c;
    my $l = length ($s);
    die "Count of $c and offset of $o are too long for a string of length $l"
        if $c + $o > $l;
    return ($s, $c, $o);
}

sub chswap {
    my ($str, $count, $offset) = @_;
    my $wrap = $count + $offset == length $str; # Special case
    $str .= substr ($str, 0, 1) if $wrap;
    substr ($str, $offset, $count,
        substr ($str, 1, $count,
        substr ($str, ++$offset, $count)));
    $str =~ s/^.(.*)(.)$/$2$1/ if $wrap;
    return $str;
}
