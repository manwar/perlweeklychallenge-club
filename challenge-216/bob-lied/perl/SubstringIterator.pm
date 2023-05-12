# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# SubstringIterator.pm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Description:
# Iterate over all possible substrings of a string.  Each iteration returns
# a pair: the substring, and the original string with the substring removed.
#
# We start with the longest possible substring (the string itself) and return
# new substrings in descending size.
#
# When the iterator is finished, it returns undef as the substring.
#=============================================================================

package SubstringIterator;

use v5.36;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new
{
    my $class = shift;
    $class = ref($class) || $class;
    my $self = {
        _target => $_[0],
        _length => 0,
        _pos    => 0,
        _size   => 0,
    };

    $self->{_size} = $self->{_length} = length($self->{_target});
    bless $self, $class;
    return $self;
}

sub next($self)
{
    my ($target, $length, $pos, $size) = $self->@{ qw(_target _length _pos _size) };

    return (undef, undef) if $length == 0;

    my $sub = substr( $target, $pos, $length );
    my $before = substr( $target, 0, $pos);
    my $after  = substr( $target, $pos + $length, $size - $length);
    my @retval = ( $sub, "$before$after" );

    if ( $self->{_pos}++ == $size )
    {
        $self->{_length}--;
    }

    return @retval;
}

1;
