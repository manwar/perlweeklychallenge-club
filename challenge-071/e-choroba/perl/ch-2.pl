#!/usr/bin/perl
use warnings;
use strict;

{   package My::PureNode;
    sub new {
        my ($class, $value) = @_;
        bless [$value, undef], $class
    }
    sub next  { $_[0][1] }
    sub value { $_[0][0] }
    sub add   {
        my $new = ref($_[0])->new($_[1]);
        $new->[1] = $_[0];
        $_[0] = $new;
    }
    sub serialise {
        my ($self) = @_;
        my @s;
        my $n = $self;
        while ($n) {
            push @s, $n->value;
            $n = $n->next;
        }
        return @s
    }
}

{   package My::Node::Trimmable;
    use parent -norequire => 'My::PureNode';
    sub trim {
        my ($self, $n) = @_;
        my @buffer;
        my $w = $self;
        while ($w) {
            push @buffer, $w;
            shift @buffer if @buffer > $n + 1;
            $w = $w->next;
        }
        if (@buffer == $n + 1) {
            $buffer[0][1] = $buffer[2];
            undef $buffer[1][1];  # no memory leak
        } else {
            $_[0] = $buffer[1];
            undef $buffer[0][1];  # no memory leak
        }
    }
}

use Test::More;
sub _fixture {
    my $n = 'My::Node::Trimmable'->new(5);
    $n->add($_) for reverse 1 .. 4;
    $n
}

my $n = _fixture();
is_deeply [$n->serialise], [1..5], 'serialise';

my $n1 = _fixture();
$n1->trim(1);
is_deeply [$n1->serialise], [1..4], 'trim 1';

my $n2 = _fixture();
$n2->trim(2);
is_deeply [$n2->serialise], [1..3, 5], 'trim 2';

my $n3 = _fixture();
$n3->trim(3);
is_deeply [$n3->serialise], [1, 2, 4, 5], 'trim 3';

my $n4 = _fixture();
$n4->trim(4);
is_deeply [$n4->serialise], [1, 3 .. 5], 'trim 4';

my $n5 = _fixture();
$n5->trim(5);
is_deeply [$n5->serialise], [2 .. 5], 'trim 5';

my $n6 = _fixture();
$n6->trim(6);
is_deeply [$n6->serialise], [2 .. 5], 'trim 6';

done_testing();
