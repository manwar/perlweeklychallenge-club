#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Capitalise a title made of words separated by single spaces. Words of
length 1 or 2 are converted to lowercase; longer words are changed to
capital case (first letter uppercase, remainder lowercase).

=cut

sub title_capital ($title) {
    my @words = split / /, $title;
    @words = map {
        my $w = $_;
        length($w) <= 2 ? lc $w : ucfirst lc $w;
    } @words;
    return join ' ', @words;
}

if (!caller) {
    require Test::More;
    Test::More::is( title_capital('PERL IS gREAT'), 'Perl is Great', 'Example 1' );
    Test::More::is( title_capital('THE weekly challenge'), 'The Weekly Challenge', 'Example 2' );
    Test::More::is( title_capital('YoU ARE A stAR'), 'You Are a Star', 'Example 3' );
    Test::More::done_testing();
}
