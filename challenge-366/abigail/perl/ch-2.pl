#!/opt/perl/bin/perl

#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
#

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    chomp;
    my ($hours, $minutes)  =  split /:/;

    #
    # It's not worth doing something "smarter" than just a simple case analysis 
    #

    my $h_times = $hours   eq "??"            ? 24   # ??
                : $hours   =~ /^\?[0-3]$/     ?  3   # ?0 .. ?3
                : $hours   =~ /^\?[4-9]$/     ?  2   # ?2 .. ?9
                : $hours   =~ /^[01]\?$/      ? 10   # 0? .. 1?
                : $hours   eq "2?"            ?  4   # 2?
                : $hours   =~ /^[01][0-9]$/   ?  1   # 00 .. 19
                : $hours   =~ /^2[0-3]$/      ?  1   # 20 .. 23
                :                                0;  # Invalid time

    my $t_times = $minutes eq "??"            ? 60   # ??
                : $minutes =~ /^\?[0-9]$/     ?  6   # ?0 .. ?9
                : $minutes =~ /^[0-5]\?$/     ? 10   # 0? .. 5?
                : $minutes =~ /^[0-5][0-9]$/  ?  1   # 00 .. 59
                :                                0;  # Invalid time

    say $h_times * $t_times;
}

__END__
