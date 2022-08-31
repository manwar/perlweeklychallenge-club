#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub first_unique_character_regex ($s) {
    local $_ = $s;
    s/\Q$1//g while /(.).*\1/g;

    return length ? index $s, substr $_, 0, 1 : -1;
}

use List::Util qw{ min };
sub first_unique_character_hash ($s) {
    my %pos;
    my $i = 0;
    my %is_unique;
    for my $ch (split //, $s) {
        $is_unique{$ch} = ! exists $pos{$ch};
        $pos{$ch} = $i++;
    }
    return min(@pos{ grep $is_unique{$_}, keys %pos }) // -1
}

use Hash::Ordered;
sub first_unique_character_ho ($s) {
    my $unique = 'Hash::Ordered'->new;
    my %seen;
    my @chars = split //, $s;
    for my $i (0 .. $#chars) {
        my $ch = $chars[$i];
        if ($seen{$ch}++) {
            $unique->delete($ch);
        } else {
            $unique->set($ch, $i);
        }
    }
    return $unique->shift // -1
}

use Tie::Hash::Indexed;
sub first_unique_character_thi ($s) {
    my $unique = 'Tie::Hash::Indexed'->new;
    my %seen;
    my @chars = split //, $s;
    for my $i (0 .. $#chars) {
        my $ch = $chars[$i];
        if ($seen{$ch}++) {
            $unique->delete($ch);
        } else {
            $unique->set($ch, $i);
        }
    }
    return $unique->shift // -1
}

use Test::More tests => 15;

my @EXPECT = (
    ['Perl Weekly Challenge', 0, 'Example 1'],
    ['Long Live Perl',        1, 'Example 2'],
    ['ABCDDCBA',             -1, 'Everything repeats'],
);

for my $e (@EXPECT) {
    my ($input, $output, $name) = @$e;
    is first_unique_character_hash($input), $output, $name;
    is first_unique_character_regex($input), $output, $name;
    is first_unique_character_ho($input), $output, $name;
    is first_unique_character_thi($input), $output, $name;
}

use Benchmark qw{ cmpthese };
my $s = join "", map chr(65 + rand 26), 1 .. 100;
is first_unique_character_hash($s), first_unique_character_regex($s), $s;
is first_unique_character_hash($s), first_unique_character_ho($s), $s;
is first_unique_character_hash($s), first_unique_character_thi($s), $s;
cmpthese(-3, {
    regex            => sub { first_unique_character_regex($s) },
    hash             => sub { first_unique_character_hash($s) },
    hash_ordered     => sub { first_unique_character_ho($s) },
    tie_hash_indexed => sub { first_unique_character_thi($s) },
});

__END__

                    Rate hash_ordered        regex tie_hash_indexed         hash
hash_ordered      8857/s           --         -20%             -54%         -68%
regex            11094/s          25%           --             -43%         -60%
tie_hash_indexed 19303/s         118%          74%               --         -30%
hash             27491/s         210%         148%              42%           --
