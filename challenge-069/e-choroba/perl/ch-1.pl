#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub is_strobogrammatic {
    my ($n) = @_;
    return if $n =~ /[^0689]/;

    my $s = reverse $n;
    $s =~ tr/0689/0986/;
    return $s == $n
}

sub get_strobogrammatic {
    my ($from, $to) = @_;
    my @s = (8, 69, 88, 96);
    my @last = (69, 88, 96);
    while ($s[-1] < $to) {
        my @next;
        for my $last (@last) {
            my ($begin, $end) = (substr($last, 0, length($last) / 2),
                                 substr($last, length($last) / 2));
            push @s, "${begin}0$end", "${begin}8$end";
            push @next, "${begin}00$end", "${begin}69$end", "${begin}88$end", "${begin}96$end";
        }
        push @s, @next;
        @last = @next;
    }
    return grep $from <= $_ && $_ <= $to, @s
}

use Test::More;

ok is_strobogrammatic(808);
ok is_strobogrammatic(69);
ok is_strobogrammatic(96);
ok is_strobogrammatic(88);
ok is_strobogrammatic(9680896);

my @slow = grep is_strobogrammatic($_), 8_000 .. 100_000;
my @fast = get_strobogrammatic(8_000, 100_000);

is_deeply \@fast, \@slow;

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    slow => sub { grep is_strobogrammatic($_), 8_000 .. 1_000_000 },
    fast => sub { get_strobogrammatic(8_000, 1_000_000) },
});

#        Rate    slow    fast
# slow 4.04/s      --   -100%
# fast 9028/s 223514%      --

# Even this is pretty fast:
# say join ' ', get_strobogrammatic(1, 10 ** 15);
