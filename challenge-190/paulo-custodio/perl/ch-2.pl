#!/usr/bin/env perl

# Perl Weekly Challenge 190 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-190/

use Modern::Perl;

sub decodings_ {
    my($result, $prefix, $suffix)=@_;
    if ($suffix eq "") {
        push @$result, $prefix;
    }
    else {
        if ($suffix =~ /^(\d\d)/ && $1>=1 && $1<=26) {
            my $char=chr($1+ord('A')-1);
            my $rest=$';
            decodings_($result, $prefix.$char, $rest);
        }
        if ($suffix =~ /^(\d)/ && $1>=1 && $1<=26) {
            my $char=chr($1+ord('A')-1);
            my $rest=$';
            decodings_($result, $prefix.$char, $rest);
        }
    }
}

sub decodings {
    my($in)=@_;
    my @result;
    decodings_(\@result, "", $in);
    return sort @result;
}

say "(", join(", ", decodings(shift)), ")";
