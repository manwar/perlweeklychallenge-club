# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# PlayList.pm
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================

use strict;
use warnings;
use v5.32;

no warnings qw/experimental::signatures/;
use feature qw/signatures/;


package PlayList;
{
    use Moo;
    use Carp qw/confess/;
    use Data::Dumper;

    has fileName => (
        is  => 'ro',
        required => 1,
        isa => sub { my $f = shift;
            -r $f || confess "Can't read file $f: $!" },
    );

    has list => (
        is => 'rw',
        default => sub { [] },
    );

    has length => (
        is => 'rw',
        default => 0,
    );

no warnings qw/experimental::signatures/;
    sub BUILD($self, $args)
    {
        $self->_loadFile();
        $self->_calcLength();
    }

no warnings qw/experimental::signatures/;
    sub _loadFile($self)
    {
        use Text::CSV qw/csv/;

        $self->list( csv(in => $self->fileName, headers => [ qw(time title) ]) );

    }

    no warnings qw/experimental::signatures/;
    sub _calcLength($self)
    {
        my $len = 0;
        for my $track ( $self->list->@* )
        {
            $len += $track->{time};
        }
        $self->length($len);
    }

    sub playingAt($self, $cycleTime)
    {
        my $len = 0;
        $cycleTime %= $self->length;
        for my $track ( $self->list->@* )
        {
            if ( $cycleTime >= $len && $cycleTime < $len + $track->{time} )
            {
                my $trackTitle = $track->{title};
                my $intoTrack = $cycleTime - $len;

                return ( $trackTitle, $intoTrack, $cycleTime);
            }
            $len += $track->{time};
        }
    }
}

1;
