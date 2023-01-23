--
-- Perl Weekly Challenge 200
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-200/>
--

CREATE SCHEMA IF NOT EXISTS pwc200;

CREATE OR REPLACE FUNCTION
pwc200.task2_plperl( int )
RETURNS text
AS $CODE$

   my ( $value ) = @_;

    my $lcd = [
	[ ' -------- ',
	  '|        |',
	  '|        |',
	  '|        |',
	  '|        |',
	  '|        |',
	  ' -------- ',
	],
	[ '         ',
	  '        |',
	  '        |',
	  '        |',
	  '        |',
	  '        |',
	  '         ',
	],
	[ ' ------ ',
	  '       |',
	  '       |',
	  ' ------ ',
	  '|       ',
	  '|       ',
	  ' ------ ',
	],

	[ ' ------ ',
	  '       |',
	  '       |',
	  ' ------ ',
	  '       |',
	  '       |',
	  ' ------ ',
	],

	[ '|      |',
	  '|      |',
	  '|      |',
	  ' ------ ',
	  '       |',
	  '       |',
	  '        ',
	],
	[ ' ------ ',
	  '|       ',
	  '|       ',
	  ' ------ ',
	  '       |',
	  '       |',
	  '        ',
	],
	[ ' ------ ',
	  '|       ',
	  '|       ',
	  ' ------ ',
	  '|      |',
	  '|      |',
	  ' ------ ',
	],

	[ ' -------',
	  '       |',
	  '       |',
	  '       | ',
	  '       |',
	  '       |',
	  '        ',
	],

	[ ' -------- ',
	  '|        |',
	  '|        |',
	  ' -------  ',
	  '|        |',
	  '|        |',
	  ' -------- ',
	],

	[ ' -------- ',
	  '|        |',
	  '|        |',
	  ' -------  ',
	  '         |',
	  '         |',
	  ' -------- ',
	],


    ];


    my $display;

      for my $row ( 0 .. 6 ) {
      	  for ( split '', $value ) {
	      $display .= ' ' . $lcd->[ $_ ]->[ $row ];
	  }

	  $display .= "\n";
      }

      $display .= "\n";

      return $display;
$CODE$
LANGUAGE plperl;
