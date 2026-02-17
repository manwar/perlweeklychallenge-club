#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in => ["Hi",    5], out => "*Hi**"      },
    { in => ["Code", 10], out => "***Code***" },
    { in => ["Hello", 9], out => "**Hello**"  },
    { in => ["Perl",  4], out => "Perl"       },
    { in => ["A",     7], out => "***A***"    },
    { in => ["" ,     5], out => "*****"      },
);

is justify_text(@{$_->{in}}), $_->{out} for @examples;

done_testing;

sub justify_text {
    my ($str, $width) = @_;

    my $pad = $width - length $str;
    return "*" x int($pad / 2) . $str . "*" x ($pad - int($pad / 2));
}
