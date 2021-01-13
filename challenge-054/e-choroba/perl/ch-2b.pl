#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Heap;

    use constant {
        KEY   => 0,
        VALUE => 1,
    };

    sub new {
        my ($class, $max_size) = @_;
        bless {heap => [], max_size => $max_size}, $class;
    }

    sub add {
        my ($self, $key, $value) = @_;
        push @{ $self->{heap} }, [$key, $value];
        $self->_up($#{ $self->{heap} });
        $self->extract_top if @{ $self->{heap} } > $self->{max_size};
    }

    sub extract_top {
        my ($self) = @_;
        return unless @{ $self->{heap} };
        my $top = shift @{ $self->{heap} };
        unshift @{ $self->{heap} }, pop @{ $self->{heap} };
        $self->_down(0);
        return @$top
    }

    sub all {
        my ($self) = @_;
        return @{ $self->{heap} }
    }

    sub _up {
        my ($self, $idx) = @_;
        return if 0 == $idx;

        my $parent = int(($idx + 1) / 2) - 1;
        if ($self->{heap}[$idx][VALUE] < $self->{heap}[$parent][VALUE]) {
            @{ $self->{heap} }[$idx, $parent]
                = @{ $self->{heap} }[$parent, $idx];
            $self->_up($parent);
        }
    }

    sub _down {
        my ($self, $idx) = @_;
        return if $idx * 2 + 1  > $#{ $self->{heap} };

        my @ch_indices = ($idx * 2 + 1, $idx * 2 + 2);
        $ch_indices[-1] = $ch_indices[0] if $idx * 2 + 2 > $#{ $self->{heap} };
        my $ch_idx = $ch_indices[ $self->{heap}[$ch_indices[0] ][VALUE]
                                  > $self->{heap}[ $ch_indices[1] ][VALUE] ];
        if ($self->{heap}[$idx][VALUE] > $self->{heap}[$ch_idx][VALUE]) {
            @{ $self->{heap} }[$idx, $ch_idx]
                = @{ $self->{heap} }[$ch_idx, $idx];
            $self->_down($ch_idx);
        }
    }
}

sub collatz {
    my ($start) = @_;
    my @seq = $start;
    push @seq, ($seq[-1] / 2, 3 * $seq[-1] + 1)[$seq[-1] % 2]
        while $seq[-1] != 1;
    return @seq
}

my $h = 'My::Heap'->new(20);

$h->add($_, scalar collatz($_)) for 1 .. 1e6;

say "@$_" for sort { $a->[1] <=> $b->[1] } $h->all;
