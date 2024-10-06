#!/usr/bin/env perl

# Challenge 173
#
# Task 2: Sylvester's sequence
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 10 members of Sylvester's sequence. For more
# informations, please refer to the wikipedia page.
#
# Output
#
# 2
# 3
# 7
# 43
# 1807
# 3263443
# 10650056950807
# 113423713055421844361000443
# 12864938683278671740537145998360961546653259485195807
# 165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443

use Modern::Perl;

sub sylvester_seq {
    my($N) = @_;
    my @n = (2);
    my $prod = 2;
    while (@n < $N) {
        my $term = $prod+1;
        push @n, $term;
        $prod *= $term;
    }
    return @n;
}

@ARGV==1 or die "usage: ch-2.pl n\n";
say join ", ", sylvester_seq(shift);
