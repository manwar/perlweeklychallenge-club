#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $DICT = '/usr/share/dict/american';

main();

sub main {
    my @words = split ' ', <>;
    check_length(@words) or return;

    my $dict = load_dict(length $words[0]);
    check_existence($dict, @words) or return;
    my ($distance, $ladder) = bfs(@words[0, 1], $dict);
    say for $words[0], find_path($distance, $ladder, $words[1]);
}

sub check_length {
    my (@words) = @_;
    return @words == 2
           && length $words[0] == length $words[1]
           && $words[0] ne $words[1]
}

sub check_existence {
    my ($dict, @words) = @_;
    return 2 == grep exists $dict->{$_}, @words
}

sub is_close {
    my ($w1, $w2) = @_;
    my $diff = $w1 ^ $w2;
    return 1 == $diff =~ tr/\0//c
}

sub load_dict {
    my ($length) = @_;

    my %dict;
    open my $in, '<', $DICT or die $!;
    while (<$in>) {
        chomp;
        undef $dict{$_} if $length == length && /^[a-z]+$/;
    }
    return \%dict
}

sub bfs {
    my ($start, $final, $dict) = @_;
    my $distance = 0;
    my %agenda = ($start => undef);
    my %accessible;
    while (keys %agenda) {
        my %next;
        for my $n (keys %agenda) {
            for my $word (keys %$dict) {
                if (is_close($word, $n) && ! exists $accessible{$word}) {
                    $accessible{$word} = $distance + 1;
                    return $distance, \%accessible if $word eq $final;

                    undef $next{$word};
                }
            }
        }
        %agenda = %next;
        ++$distance;
        # say $distance, ' ', scalar keys %agenda;
    }
    return
}

sub find_path {
    my ($distance, $ladder, $final) = @_;

    my @ladder = my $previous = $final;
    while ($distance) {
        $previous = (grep $ladder->{$_} == $distance && is_close($previous, $_),
                          keys %$ladder)[0];
        --$distance;
        unshift @ladder, $previous;
    }
    return @ladder
}
