unit module Listlike::Utils;

use MONKEY-TYPING;

subset Code where .WHAT ~~ Callable|WhateverCode;

multi sub all( $self, Mu $value ) is export
{
    $self.all( * ~~ $value );
}

multi sub all( $self, Code $condition  ) is export
{
     for |$self {
        return False unless .&$condition;
    }

    True;
}

multi sub none( $self, Mu $value ) is export
{
    $self.none( * ~~ $value );
}

multi sub none( $self, Code $condition ) is export
{
    for |$self {
        return False if .&$condition;
    }

    True;
}

sub do( $self, Code $block ) is export
{
    for |$self {
        .&$block;
    }
}

multi sub until( $self, Mu $value, :$ex ) is export
{
    $self.until( * ~~ $value, :$ex);
}

multi sub until( $self, Code $condition, :$ex ) is export
{
    gather for |$self
    {
        my $result = .&$condition;

        last if so $ex && $result ;
        .take;
        last if $result;
    }
}

multi sub hence( $self, Mu $value, :$ex ) is export
{
    $self.hence( * ~~ $value, :$ex );
}

multi sub hence( $self, Code $condition, :$ex ) is export
{
    my $take;

    gather for |$self
    {
        my $result = .&$condition;

        $take = $result
            if !$take and !$ex;

        .take and next
            if $take;

        $take = $result;
    }
}

augment class List
{
    method none( $condition ) { none( self, $condition ) }
    method all( $condition ) { all( self, $condition ) }
    method do( $condition ) { do( self, $condition ) }
    method until( $condition, :$ex ) { until( self, $condition, :$ex ) }
    method hence( $condition, :$ex ) { hence( self, $condition, :$ex ) }
}

augment class Seq
{
    method none( $condition ) { none( self, $condition ) }
    method all( $condition ) { all( self, $condition ) }
    method do( $condition ) { do( self, $condition ) }
    method until( $condition, :$ex ) { until( self, $condition, :$ex ) }
    method hence( $condition, :$ex ) { hence( self, $condition ) }
}

augment class Range
{
    method none( $condition ) { none( self, $condition ) }
    method all( $condition ) { all( self, $condition ) }
    method do( $condition ) { do( self, $condition ) }
    method until( $condition, :$ex ) { until( self, $condition, :$ex ) }
    method hence( $condition, :$ex ) { hence( self, $condition, :$ex ) }
}