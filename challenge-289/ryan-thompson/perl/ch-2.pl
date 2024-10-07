#!/usr/bin/env perl
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use List::Util qw< shuffle >;

sub readable { $_[0] =~ s! \b\w\K (\w\w+?) (?=\w\b)
                         ! join '', shuffle split //,$1 !egrx }

sub readable_flex {
    my $m = shift;
    $_[0] =~ s! \b$m\K ($m{2,}?) (?=$m\b)
              ! join '', shuffle split //,$1 !egrx
}

print readable($_) for <>;
