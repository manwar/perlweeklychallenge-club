#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate a string with random number of ( and ) brackets. Then make the script validate the string if it has balanced brackets.
For example:
() - OK
(()) - OK
)( - NOT OK
())() - NOT OK
=cut




use constant { OB => '(', CB => ')' , WEIGHT => 0.25};
my $FAIR = shift() ? 1 : 0; 
my $TOTAL = 50;
my $DEBUG_NUM_OK = 0;
for my $i ( 1 .. $TOTAL )
{
     my $ml = int((rand(9) + 1)) * 2 + 2; # Should be even, otherwise would be immediately "NOT OK", assumed the string consists of brackets only.



     # Making a string. The "simple" version produces too little "OK" strings.
     # Therefore: two versions - "simple" and "fair".
     my $string = $FAIR ? fair_brackets($ml) : simple_brackets($ml);

     my $counter = 0;

     for my $i (0 .. length($string) - 1)
     {
          --$counter if ( substr($string, $i, 1) eq CB );
          last if ( $counter < 0 );
          ++$counter if ( substr($string, $i, 1) eq OB );
     }


     print join(' ', $string, '-', 0 == $counter ? 'OK' : 'NOT OK' ), $/; 
     ++$DEBUG_NUM_OK if 0 == $counter;
}

print join(' ', 
     join('=', 'FAIR BUILD', $FAIR), 
     join('=', 'DEBUG_NUM_OK', $DEBUG_NUM_OK),
     join('=', 'TOTAL', $TOTAL)), $/;

sub fair_brackets
{
     my $str .= OB;
     my $length = $_[0];
     while ( length($str) < $length )
     {
          $str .= CB and last if (length($str) + 1 == $length);


          my $last = substr($str, -1, 1);
          my $compl = $last eq OB ? CB : OB;
          $str .= rand > WEIGHT ? $compl : $last;
     }
     return $str;
}



sub simple_brackets
{
     my @brackets = (OB, CB);
     my $length = $_[0];

     my $str =  join('', @brackets[ map rand (@brackets) , 1 .. $length ]);
     return $str;
}