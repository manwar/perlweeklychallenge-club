use strict;
use warnings;
use Test::More;

sub is_acronym {
    my ($chk, @words) = @_;

    my $acronym = join '', map { lc(substr($_, 0, 1)) } @words;

    return $acronym eq lc($chk);
}

is(is_acronym("ppp", "Perl", "Python", "Pascal"), 1, 'Test Case 1');
is(is_acronym("rp", "Perl", "Raku"), '', 'Test Case 2');
is(is_acronym("oac", "Oracle", "Awk", "C"), 1, 'Test Case 3');

done_testing();
