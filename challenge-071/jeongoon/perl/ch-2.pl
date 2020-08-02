#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use Getopt::Long;
use Pod::Usage;
use Term::ANSIColor;

=pod

=head1 Usage

perl ch-1.pl [--debug] [--help]

=cut

BEGIN {
    $::debugging = 0;
    $::colour    = 1;
    my $help = 0;

    GetOptions( "debug" => \$::debugging,
                'color|colour!' => \$::colour,
                "help"  =>  \$help,
        ) or pod2usage(2);

    pod2usage( -exitval => 0, -verbose => 2 ) if $help;

    our $dprint = sub( @ ) {
        ++$|;
        print "[DBG] ",@_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

=pod

=head1 Challenge 2

You are given a singly linked list and a positive integer $N (>0).

Write a script to remove the $Nth node from the end of the linked list and
print the linked list.

=cut

package linked_list;
use Scalar::Util qw(blessed refaddr weaken);

sub new {
    my $class = shift;
    my %args  = @_;     # use hash as arguments
    my $elements;
    ::dprint "linked_list: initializing ...\n";
    if ( exists $args{elements} ) {
        if ( not ref $args{elements} eq 'ARRAY' ) {
            warn "parameter elements accept only Array Ref: ignored.";
        }
        else {
            $elements = $args{elements};
        }

    }

    my $obj =
      [
       linked_list::iterator->new( '[CORE]' )     # one default iterator for internal use
      ];
    my $self = bless $obj, ( blessed $class || $class );

    if ( defined $elements ) {
        for ( reverse @$elements )  {  # going to use unshift method
            $self->push_back( $self->[0], $_ );
        }
    }
    ::dprint "linked_list: created\n";
    return $self;
}

sub DESTROY {
    ::dprint "linked_list: remvoing CORE and cache.\n";
    undef $_[0]->[0];
    ::dprint "linked_list: done";
}

sub before_begin_ { $_[0]->[0] }
sub begin         { $_[0]->[0]->next }
sub maybe_end     { $_[0]->[1] }
sub end           {
    # using remembered end point if any
    $_[0]->[1] = $_[0]->[0]->next unless defined $_[0]->maybe_end;
    # update end point if needed
    while ( $_[0]->[1]->next ) {
        $_[0]->[1] = $_[0]->[1]->next
    }
    return $_[0]->[1];
}

sub count {
    my $itr = $_[0]->begin;

    my $count = 0;
    while ( defined $itr ) {
        ++$count;
        $itr = $itr->next;
    }
    $count;
}

sub itr_class_str () { __PACKAGE__.'::iterator' }

sub push_back ( $;$ ) {
    if ( scalar @_ == 1 ) {
        ::dprint "nothing to do";
        return 0;
    }
    elsif ( scalar @_ > 3) {
        warn "too much arguments: use last two arguments";
    }

    my ( $itr, $sth ) = @_[ -2, -1 ];
    my $class = blessed $itr;

    # get valid iterator to push back
    if ( not defined $itr ) { # this is act as unshift()
        warn "iterator is undef: unshift the $sth at the beginning or making first node";
        ::dprint "push_back: iterator not defined: making first node";
        return $_[0]->push_back( $_ [0]->before_begin_, $sth );
    }
    if ( $class eq __PACKAGE__ ) { # scalar @_ == 2
        ::dprint "push_back: use tail node to push $sth";
        $itr = $_[0]->end;
    }

    # get valid iterator to be pushed back
    $class = blessed $sth;
    if ( $class and $class eq itr_class_str ) {
        ::dprint "push_back: received an itr with value: ".$sth->value.$/;
        ::dprint "           to be pushed after iter with value: ".$itr->value.$/;
        my $nxt = $itr->next;
        $itr->[1] = $sth;
        if ( defined $sth->next ) {
            warn "push_back: trying to insert some node which already has link";
        }
        else {
            # XXX: not sure it is correct behaviour
            $sth->[1] = $nxt;
        }
        return 1;
    }
    else { # value
        ::dprint "push_back: received a value: $sth\n";
        return $_[0]->push_back( $itr, itr_class_str->new( $sth ) );
    }
    die "this is a bug" if $::debugging;
}

sub pop ( $;$ ) {
    return if scalar @_ == 1;

    my $class = blessed $_[-1];

    if ( defined $class and $class eq __PACKAGE__ ) {
        # pop the end
        return $_[0]->pop( $_[0]->count - 1 );
    }
    if ( defined $class and $class eq itr_class_str ) {
        ::dprint "find the node and pop it from the list.\n";
        my $itr;
        for ( $itr = $_[0]->begin; defined $itr; $itr = $itr->next ) {
            last if ( $itr->next eq $_[-1] );
        }
        if ( not defined $itr ) {
            warn "could not find the $_[-1] in the list: return undef";
            return undef;
        }
        my $bye   = delete $itr->[1];
        $itr->[1] = delete $bye->[1];
        return $bye;
    }
    elsif ( $_[-1] =~ /^(\+|-)?[0-9]+$/ ) {
        ::dprint "pop the node at index of $_[-1] from the list.\n";
        my $before;
        my $count = $_[0]->count;
        my $round = 0;

        if ( $_[-1] < 0 ) {

=pod

If $N is greater than the size of the linked list
then remove the first node of the list.

 NOTE: Please use pure linked list implementation.
 Example
 Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
 when $N = 1
 Output: 1 -> 2 -> 3 -> 4
 when $N = 2
 Output: 1 -> 2 -> 3 -> 5
 when $N = 3
 Output: 1 -> 2 -> 4 -> 5
 when $N = 4
 Output: 1 -> 3 -> 4 -> 5
 when $N = 5
 Output: 2 -> 3 -> 4 -> 5
 when $N = 6
 Output: 2 -> 3 -> 4 -> 5

=cut

            my $idx = $_[-1];
            ::dprint ">>  this is a task2 solution\n";

            if ( -$idx > $count ) {
                ::dprint ">>>  always remove first node when index is".
                  " more than length of list.\n";

                $before = $_[0]->[0];
                ::dprint ">>>>  and I have shortcut:".$before->value.$/;
            }
            else {
                ::dprint ">>>  we have to find index before the node".
                  " which will be removed.\n";
                $round = -$idx;
                ::dprint ">>>>  index would be: $round\n";
            }
        }
        if ( not defined $before ) {
            $before = $_[0]->before_begin_;
            ( $before = $before->next ) while $round--;
        }
        my $bye = delete $before->[1];
        $before->[1] = delete $bye->[1];
        return $bye;
    }
    else {
        warn "invalid arguemnt for poping: ".($_[-1]//'<not given>');
        return undef;
    }
    die "this is a bug" if $::debugging;
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

sub next   () { $_[0]->[1]; }
sub value  () { $_[0]->[0]; }

sub DESTROY {
    ::dprint "$_[0]: value: ".($_[0]->[0]||'<empty>')." destroyed!!!\n";
}


package main;

sub get_actual_index_to_remove_ ( $$ ) { # have no type checking
    my $list  = shift;
    my $N     = shift;
    my $count = $list->count;

    return  $count - $N; # -1 because index starts from 0
}

sub say_elements_ ( $;$ ) {
    my $lst   = shift;
    my $index = shift;

    my $itr = $lst->begin;
    my $sep = ' -> ';
    return if not defined $itr;

    print $itr->value;
    --$index if defined $index;
    for ( my $i = 0, $itr = $itr->next; defined $itr; ++$i, $itr = $itr->next ) {
        print $sep;
        if ( defined $index and $index eq $i ) {
            print( ( $::colour
                     ? colored( [ 'yellow on_black' ], $itr->value )
                     : '`'.$itr->value.'\'' ) );
        }
        else {
            print $itr->value;
        }
    }
    print $/;
}

my $example = linked_list->new( elements => [ 1..5 ] );
print "Given Linked List: ";
say_elements_( $example );

for ( 1..6 ) {
    my $idx = get_actual_index_to_remove_ $example, $_;
    print "when \$N = $_\n";
    if ( $::debugging ) {
        ::dprint "Current: ";
        say_elements_ $example, $idx;
    }
    my $clean_itr = $example->pop( -$idx ); # minus: from the end
    print "Output: ";
    say_elements_ $example;

    # another hidden problem if we go through the loop
    ::dprint "Inserting again for next try\n";
    my $itr = $example->before_begin_;
    for ( 0 .. $idx -1 ) { $itr = $itr->next; }
    if ( defined $itr ) {
        $example->push_back( $itr, $clean_itr );
    }
    else {
        $example->push_back( $clean_itr );
    }
}
