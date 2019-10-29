#! /usr/bin/perl
{   package My::BarChart;
    use Moo;

    use Function::Parameters;
    use Types::Standard qw{ HashRef Num Str Enum };
    use List::Util qw{ max };

    sub SortBy { Enum[qw[ labels values labels_desc values_desc ]] }

    use namespace::clean;

    has width     => (is => 'lazy', isa => Num);
    has data      => (is => 'ro',   isa => HashRef[Num], required => 1);
    has separator => (is => 'ro',   isa => Str, default => ' | ');

    has _bar_width  => (is => 'lazy', isa => Num);
    has _max_length => (is => 'lazy', isa => Num);

    method generate (SortBy $sort_by = 'keys') {
        my $data = $self->data;
        my $max = max(values %$data);

        my $sort = {labels      => \&_by_key,
                    values      => \&_by_value,
                    labels_desc => \&_by_key_desc,
                    values_desc => \&_by_value_desc}->{$sort_by};

        for my $key (sort { $self->$sort } keys %$data) {
            printf '%' . $self->_max_length . "s%s%s\n",
                $key,
                $self->separator,
                '#' x ($self->_bar_width / $max * $data->{$key});
        }
    }

    method BUILD ($) {
        die "Chart is too wide.\n" if $self->_bar_width <= 0;
    }

    method _build_width () { $ENV{COLUMNS} || qx{tput cols} || 80 }

    method _build__max_length () { max(map length, keys %{ $self->data }) }

    method _build__bar_width () {
        $self->width - $self->_max_length - length $self->separator
    }

    method _by_key        () { $a cmp $b }
    method _by_key_desc   () { $b cmp $a }
    method _by_value      () { $self->data->{$a} <=> $self->data->{$b} }
    method _by_value_desc () { $self->data->{$b} <=> $self->data->{$a} }
}

use warnings;
use strict;
use feature qw{ say };

my $data = { apple => 3, cherry => 2, banana => .5 };
my $chart = 'My::BarChart'->new(data => $data);

say $chart->generate('labels');
say $chart->generate('values');
say $chart->generate('values_desc');
