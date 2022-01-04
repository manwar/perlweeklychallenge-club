#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    count = gsub ("e", "E")
    print $0
    print count
}
