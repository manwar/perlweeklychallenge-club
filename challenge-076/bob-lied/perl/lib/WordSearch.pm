# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# WordSearch.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package WordSearch;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use File::Slurper qw / read_lines /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class)
{
    $class = ref($class) || $class;
    my $self = {
        _grid => [],
        _wordlist => [],
        _lastRow => 0,
        _lastCol => 0,

        _numFound => 0,
        _foundList => [],
    };
    bless $self, $class;
    return $self;
}

sub loadGrid($self, $gridFile)
{
    my @g = read_lines($gridFile);
    for my $row ( 0 .. $#g )
    {
        (my @chars) = split(" ", $g[$row]);
        for my $col ( 0 .. $#chars )
        {
            $self->{_grid}->[$row][$col] = lc($chars[$col]);
        }
    }
    $self->{_lastRow} = scalar( @{$self->{_grid}} ) - 1;
    $self->{_lastCol} = scalar( @{$self->{_grid}->[0]} ) - 1;
    return $self;
}

sub loadWordlist($self, $wordlistFile, $minLength)
{
    my @wl = map { lc } grep { length($_) >= $minLength } read_lines($wordlistFile);
    $self->{_wordlist} = \@wl;
    return $self;
}

sub numFound($self)
{
    return $self->{_numFound};
}

sub foundList($self)
{
    return $self->{_foundList}
}

sub _horizontal($self)
{
    my @list;
    my $g = $self->{_grid};

    for my $row ( 0 .. $self->{_lastRow} )
    {
        my $s = join('', @{$g->[$row]});
        push @list, $s, scalar(reverse($s));
    }
    return \@list;
}

sub _vertical($self)
{
    my @list;
    my $g = $self->{_grid};

    for my $col ( 0 .. $self->{_lastCol} )
    {
        my @column = map { $g->[$_][$col] } 0 .. $self->{_lastRow};
        my $s = join('', @column);
        push @list, $s, scalar(reverse($s));
    }
    return \@list;
}

sub _diagonal($self)
{
    my @list;
    my $g = $self->{_grid};
    my $lastRow = $self->{_lastRow};
    my $lastCol = $self->{_lastCol};

    # Top left to bottom right along the left edge
    for my $row ( 0 .. $lastRow )
    {
        my $s;
        my ($r, $c);
        for ( $r = $row, $c = 0; $r <= $lastRow && $c <= $lastCol ; $r++, $c++ )
        {
            $s .= $g->[$r][$c];
        }
        push @list, $s, scalar(reverse($s));
    }

    # Top left to bottom right along the top edge
    for my $col ( 1 .. $self->{_lastCol} ) #
    {
        my $s;
        my ($r, $c);
        for ( $r = 0, $c = $col; $r <= $lastRow && $c <= $lastCol ; $r++, $c++ )
        {
            $s .= $g->[$r][$c];
        }
        push @list, $s, scalar(reverse($s));
    }

    # Bottom left to top right along left edge
    for ( my $row = $lastRow; $row >= 0; $row-- )
    {
        my $s;
        my ($r, $c);
        for ( $r = $row, $c = 0; $r >= 0 && $c <= $lastCol; $r--, $c++ )
        {
            $s .= $g->[$r][$c];
        }
        push @list, $s, scalar(reverse($s));
    }

    # Bottom left to top right along the bottom edge
    for my $col ( 1 .. $lastCol )
    {
        my $s;
        my ($r, $c);
        for ( $r = $lastRow, $c = $col; $r >= 0 && $c <= $lastCol ; $r--, $c++ )
        {
            $s .= $g->[$r][$c];
        }
        push @list, $s, scalar(reverse($s));
    }
    return \@list;
}

sub _find($self, $str)
{
    my $count = 0;
    my @found;
    for my $word ( @{$self->{_wordlist}} )
    {
        # Is RE faster than index?
        if ( index($str, $word) != -1 )
        {
            $count++;
            push @found, $word;
        }
    }
    $self->{_foundList} = \@found;

    return $self->{_numFound} = $count;
}


sub run($self)
{
    my $h = $self->_horizontal();
    my $v = $self->_vertical();
    my $d = $self->_diagonal();

    # Combine all the strings with a non-word character to separate
    # them so that we need only one search per word.
    my $all = join('.', @$h, @$v, @$d);
    return $self->_find($all);
}

1;

