#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Time::Piece;
use Time::Seconds;

sub days_range {
    my ( $input ) = @_;
    my $days = 0;

    my ( $ASD, $AED, $BSD, $BED ) =
      map { 
          Time::Piece->strptime(
            "2021-$_",
            "%Y-%d-%m"
          );
      }
      (
        $input->{Foo}{SD},
        $input->{Foo}{ED},
        $input->{Bar}{SD},
        $input->{Bar}{ED},
      );

      my (
          $A_start_to_A_end,
          $B_start_to_B_end,
          $B_start_to_A_end,
          $A_start_to_B_end,
      ) = 
      map {
          my ($n1,$n2) = @$_;
          ($n2-$n1)/ONE_DAY;
      }
      (
          [$ASD,$AED],
          [$BSD,$BED],
          [$BSD,$AED],
          [$ASD,$BED],
      );

  # say "A_start_to_A_end: $A_start_to_A_end";
  # say "B_start_to_B_end: $B_start_to_B_end";
  # say "B_start_to_A_end: $B_start_to_A_end";
  # say "A_start_to_B_end: $A_start_to_B_end";

    if( $A_start_to_B_end < 0 or $B_start_to_A_end < 0 ){
        # 0 days.
    }
    elsif($A_start_to_B_end < $B_start_to_A_end){
        if($A_start_to_B_end < $A_start_to_A_end){
            $days = $A_start_to_B_end + 1;
        }
        else {
            $days = $A_start_to_A_end + 1;
        }
    }
    else {
        if($B_start_to_A_end < $B_start_to_B_end){
            $days = $B_start_to_A_end + 1;
        }
        else {
            $days = $B_start_to_B_end + 1;
        }
    }

    "$days day" . ( $days == 1 ? "" : "s" );
}

my @cases = (
    {
        Name  => 'A before B',
        Input => {
            Foo => { SD => '02-01', ED => '10-01' },
            Bar => { SD => '15-01', ED => '18-01' },
        },
        Output => '0 days',
    },
    {
        Name  => 'A after B',
        Input => {
            Foo => { SD => '15-01', ED => '18-01' },
            Bar => { SD => '02-01', ED => '10-01' },
        },
        Output => '0 days',
    },

    {
        Name  => 'Same month with overlap',
        Input => {
            Foo => { SD => '12-01', ED => '20-01' },
            Bar => { SD => '15-01', ED => '18-01' },
        },
        Output => '4 days',
    },
    {
        Name  => 'Same month with no overlap',
        Input => {
            Foo => { SD => '02-03', ED => '12-03' },
            Bar => { SD => '13-03', ED => '14-03' },
        },
        Output => '0 days',
    },
    {
        Name  => 'Same month with overlap',
        Input => {
            Foo => { SD => '02-03', ED => '12-03' },
            Bar => { SD => '11-03', ED => '15-03' },
        },
        Output => '2 days',
    },
    {
        Name  => 'Different months with overlap',
        Input => {
            Foo => { SD => '30-03', ED => '05-04' },
            Bar => { SD => '28-03', ED => '02-04' },
        },
        Output => '4 days',
    },


);

for ( @cases ) {
    is(
        days_range( $_->{Input} ),
        $_->{Output},
        $_->{Name}
    );
}

done_testing();
