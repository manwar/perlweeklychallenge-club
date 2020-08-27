# -*- Mode: cperl; cperl-indent-level:4; tab-width: 8; indent-tabs-mode: nil -*-
# Copyright (c) 2013,2020 JEON Myoungjin <jeongoon@gmail.com>
use strict; use warnings;

use version 0.77 our $VERSION = version->declare( '0.2' );
package CombinationsIndex;

use parent 'Exporter';
our @EXPORT_OK = qw(combinationsIndex);

=pod

=head1 Basic concept

If we find the combintions when choosing 3 digits from index of 0 .. 4
which shown below

  0  1  2  3  4
 ^1 ^2 ^3         initial selection: index position: ( 0, 1, 2 )

to get next combination we can move ^3 cursor from 2 to 3

  0  1  2  3  4
 ^1 ^2    ^3      note: ^3 can move up to 4

as you can see ^3 can only go up to 4, next movement we can imagine is that
moving ^2 to next one and ^3 is just followed by ^2
and next movement will be again ^3 to the index 4

  0  1  2  3  4       =>    0  1  2  3  4      =>     0  1  2  3  4
 ^1 ^2       ^3            ^1    ^2 ^3               ^1    ^2    ^3

and last case of combinations will be

  0  1  2  3  4
       ^1 ^2 ^3

so I make two arrays to record
   1. where each cursor is pointing now,
   2. how many rooms left for each cursor to move

and also remember what is the current cursor move next.

so we can also make combinations without recursive routine.

=cut

sub combinationsIndex ( $$ ) {
    my $N   = $_[0];            # number of selection
    my $M   = $_[1];            # choice" 0 .. ($M - 1)

    my @result;

    # minimum sanity check
    if ( $M < $N ) {
        warn "unable to choose $N from given selection of $M";
        return ();
    }

    my ( @room,         # number of spaces(rooms) each
         @pos,          # current position of cursor
         $next_csr      # next cursor to move
       );

    # set initial values ...
    {
        # each finger can move to right number of ( M-N ) space(s).
        @room     = ( $M-$N ) x $N;
        @pos      = 0 .. ($N - 1);
        $next_csr = $N - 1; # last cursor at rightmost

        # initial record; note: use not index number but real value
        push @result, [ @pos ];
    }

    {
        if ( $room[$next_csr] > 0 ) {
            # current csr can move to right so just do it.
            ++$pos[ $next_csr];
            --$room[$next_csr]; # room decreased of course

            # and make a record
            push @result, [ @pos ];
            redo;
        }
        else {
            # no more room to move
            # so find the next cursor to move
            my $found = 0;
            for ( my $i = $next_csr; $i > 0; --$i ) {
                if ( $room[ $i-1 ] > 0 ) {
                    $next_csr = $i-1;
                    $found = 1;
                    last ;
                }
            }

            if ( $found ) {
                # move all the cursors which are starts from
                # $next_csr to last one
                @pos[ $next_csr .. ($N-1) ]
                    = map { $pos[$next_csr] + $_ } 1 .. ($N-$next_csr);
                # note: all these finger has same room when moved
                @room[ $next_csr .. ($N-1) ]
                  = ( $room[ $next_csr ] - 1 ) x        ($N-$next_csr);

                # and make a record
                push @result, [ @pos ];

                # next finger to move will be ($N-1)
                # or even if it is not next loop will find anohter
                $next_csr = ($N-1);

                redo; # if we can move next cursor
            }
        }
    }
    @result;
}

!!"^^";
