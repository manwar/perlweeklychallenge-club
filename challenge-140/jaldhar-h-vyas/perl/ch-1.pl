#!/usr/bin/perl
use 5.020;
use warnings;

package Binary;
use overload '+' => 'add';
use overload '""' => 'toString';

sub new {
    my ($class, $str) = @_;
    my $self = \"0b$str";
    bless $self, $class;
    return $self;
}

sub add {
    my ($self, $other) = @_;
    say "overload!";
    return Binary->new(
        sprintf '%b', (sprintf '%d', oct $$self) + (sprintf '%d', oct $$other)
    );
}

sub toString {
    my ($self) = @_;
    return sprintf '%b', oct $$self;
}

package main;
use 5.020;
use warnings;

if (scalar @ARGV != 2) {
    die "Need two binary numbers.\n";
}

my $a = Binary->new($ARGV[0]);
my $b = Binary->new($ARGV[1]);

say $a + $b;
