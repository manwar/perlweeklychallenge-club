#!/usr/bin/env perl
use utf8;
use open ':std', ':encoding(UTF-8)';
use strict; use warnings;

BEGIN {
    $::debugging = 0;
    if ( grep { /^--debug$/ } @ARGV ) {
        $::debugging = 1;
    }

    our $dprint = sub( @ ) {
        ++$|;
        print "[DEBUG] ",@_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

package linked_list;
use Scalar::Util qw(blessed refaddr weaken);
#use namespace::clean;

sub new {
    my $class = shift;
    my $obj   = {};
    $obj->{beg_itr_} = linked_list::iterator->new();
    return bless $obj, ( blessed $class || $class );
}

sub DESTROY {
    my $itr = $_[0]->itr;
    {
        my $rubbish = $itr->pop_back;
        if ( defined $rubbish ) {
            ::dprint "removing: " . $rubbish.$/;
            undef $rubbish;
            redo;
        }

    }

    ::dprint "and remvoing: " .$_[0]->{beg_itr_}.$/;
    undef $_[0]->{beg_itr_};
}

sub itr   { $_[0]->{beg_itr_} }

sub count {
    my $itr = $_[0]->itr;

    my $count = 0;
    while ( defined $itr ) {
        ++$count;
        $itr = $itr->next_itr;
    }
    $count;
}

sub last_itr {
    my $itr = $_[0]->itr;
    return undef unless defined $itr;
    while ( defined $itr->next_itr ) {
        $itr = $itr->next_itr;
    }
    return $itr;
}

package linked_list::iterator;
use Scalar::Util qw(blessed refaddr weaken isweak);

sub new {
    my $class = shift;
    my $value  = shift;
    my $obj   = [ $value, undef ];

    weaken( $obj->[0] ) if refaddr( $obj->[0] );
    bless $obj, ( blessed $class || $class );
}

sub next_itr   () { $_[0]->[1]; }
sub value      () { $_[0]->[0]; }

sub push_back_value ( $ ) {
    if ( not defined $_[0]->[0] and not defined $_[0]->[1] ) {
        # first iterator
        $_[0]->[0] = $_[1];
        weaken( $_[0]->[0] ) if refaddr ( $_[0]->[0] );
        return 1;
    }

    my $new = linked_list::iterator->new( $_[1] );
    my $nxt = $_[0]->[1]; # $_[0]->next_itr
    $_[0]->[1] = $new;
    $new->[1]  = $nxt;
    1;
}

sub push_back ( $ ) {
    my $friend_class = blessed( $_[1] );
    if ( not defined $friend_class
         or
         not $friend_class->isa( __PACKAGE__ ) ) {
        ::dprint "friend is not a valid iterator\n";
        return 0;
    }
    if ( blessed $_[1]->[1] ) {
        ::dprint "friend already has another friend: use poped iterator only";
        return 0;
    }
    $_[1]->[1] = $_[0]->[1];
    $_[0]->[1] = $_[1];
    return 1;
}

sub pop_back  () {
    if ( not defined $_[0]->[1] ) {
        return undef;
    }
    my $togo = $_[0]->[1];
    $_[0]->[1] = $togo->[1];
    $togo->[1] = undef;
    return $togo;
}

sub DESTROY {
    ::dprint "$_[0]: destroyed!!!\n";
}

package main;

sub print_all_values ($) {
    my $itr = shift;
    print $itr->value;
    while ( $itr = $itr->next_itr ) {
        print " → ".$itr->value;
    }
    print "\n";
}

my @example = 1..6;
my $L = linked_list->new();
my $itr = $L->itr;
for my $value ( @example ) {
    $itr->push_back_value( $value );
    $itr = $itr->next_itr || $L->itr; # ugly
}

$itr = $L->itr;

::dprint "input:\n";
print_all_values( $itr ) if $::debugging;

my $count = $L->count;
::dprint "count of list: $count\n";


my $pair_left_num  = 1;
my $pair_left_pos  = 0;
my $pair_right_num = $count - $pair_left_num + 1;
my $pair_right_pos = $pair_left_pos + 1;

my $l_itr = $L->itr;

while ( ( $pair_right_pos + 1 ) < $pair_right_num ) {
    my $r2_itr = $l_itr; # 2nd last iterator

    my $n_repeat = $pair_right_num - 1 - $pair_left_pos;
    ::dprint "from: $pair_left_pos, go next $n_repeat time(s) to find 2nd last iterator.\n";
    while ( --$n_repeat > 0 ) {  # find (N-1)th node
         $r2_itr = $r2_itr->next_itr;
    }
    my $r_itr = $r2_itr->pop_back;
    ::dprint "right of the pair has value of: ".$r_itr->value.$/;
    $l_itr->push_back( $r_itr );

    $l_itr = $l_itr->next_itr->next_itr;

    ++$pair_left_num;
    $pair_left_pos += 2;
    --$pair_right_num;
    $pair_right_pos = ( $pair_left_pos + 1 );
}

undef $l_itr;
$itr = $L->itr;

::dprint "output:\n";
print_all_values( $itr );
