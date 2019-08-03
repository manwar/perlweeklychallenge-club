#!/bin/env perl

use Modern::Perl;
use Getopt::Long;

my $max_width = 80;
GetOptions(
    'width:s' => \$max_width,
);

my $p;
{
    local $/;
    undef $/;
    $p = <DATA>;
}

wrap_text($p, $max_width);

sub wrap_text {
    my ($p, $max_width) = @_;

    my $line = '';
    for my $word (split /\s+/, $p) {
        die "max_width must be longer than word width: $word\n" if length($word) > $max_width;

        if ($max_width < length($line) + 1 + length($word)) {
            say $line;
            $line = $word;
        } else {
            $line .= length($line) == 0 ? $word : " $word";
        }
    }
    say $line if $line;
}

__DATA__
Use the resources to learn Perl 6 and write about your experience
along the way! Let us know when you do write something if you
want to share it with the larger Perl 6 community (you should!).
Some writing topics could be programs you've written, tricks
you've learned, cool things about the Perl 6, etc. Because of your
fresh perspective as a learner, writing educational/training
material would be a great idea as well. If anything is Less Than
Awesome in your experience you can chat with us, or open an issue
on the User Experience repository.
