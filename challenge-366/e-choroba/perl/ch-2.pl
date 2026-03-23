#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

{   my @DIGITS = ([0, 1, 2],
                  [0 .. 9],
                  undef,
                  [0 .. 5],
                  [0 .. 9]);

    sub valid_times($time) {
        my $question_pos = index $time, '?';
        return $time =~ /^(?:[01][0-9]|2[0-3]):([0-5][0-9])$/
            if -1 == $question_pos;

        my $count = 0;

        # For hour >= 20, we iterate 24 .. 29 which can never be true. The
        # benchmark shows special-casing it brings no significant improvement in
        # the general case (see the EOF).
        for my $digit (@{ $DIGITS[$question_pos] }) {
            substr $time, $question_pos, 1, $digit;
            $count += valid_times($time);
        }
        return $count
    }
}

{   my @DIGITS = ([([0, 1, 2]) x 2],
                  [[0 .. 9], [0 .. 3]],
                  undef,
                  [([0 .. 5]) x 2],
                  [([0 .. 9]) x 2]);

    sub valid_times_optm($time) {
        my $question_pos = index $time, '?';
        return $time =~ /^(?:[01][0-9]|2[0-3]):([0-5][0-9])$/
            if -1 == $question_pos;

        my $count = 0;
        for my $digit (@{ $DIGITS[$question_pos]['2' eq substr $time, 0, 1] }) {
            substr $time, $question_pos, 1, $digit;
            $count += valid_times($time);
        }
        return $count
    }
}

use Test::More tests => 2 * 5;

for my $f (\&valid_times, \&valid_times_optm) {
    is $f->('?2:34'), 3, 'Example 1';
    is $f->('?4:?0'), 12, 'Example 2';
    is $f->('??:??'), 1440, 'Example 3';
    is $f->('?3:45'), 3, 'Example 4';
    is $f->('2?:15'), 4, 'Example 5';
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    'naive_??' => sub { valid_times('??:??') },
    'optm_??'  => sub { valid_times_optm('??:??') },
});
cmpthese(-3, {
    'naive_2?' => sub { valid_times('2?:??') },
    'optm_2?'  => sub { valid_times_optm('2?:??') }
});

=head1 Benchmark

           Rate  optm_?? naive_??
optm_??  1080/s       --      -0%
naive_?? 1083/s       0%       --

           Rate naive_2?  optm_2?
naive_2? 3382/s       --     -56%
optm_2?  7632/s     126%       --

=cut
