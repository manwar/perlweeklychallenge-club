# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
#
# Ryan Thompson <rjt@cpan.org>

sub even_re { ()= "@_" =~ /\b(\d\d)+\b/g }
