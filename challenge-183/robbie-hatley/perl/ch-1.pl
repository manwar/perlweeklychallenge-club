#! /usr/bin/perl
# pwc-183a-unique-array-rh.pl
use v5.32;
$,=',';
sub is_equal;
sub help;
my @Arrays;
{ # begin main
   # If user wants help, just give help and exit:
   if ("-h" eq $ARGV[0] || "--help" eq $ARGV[0]) {help;exit;}

   # Otherwise, convert $ARGV[0] to array of array refs:
   eval("\@Arrays = $ARGV[0]");

   # Splice-out all duplicates:
   for ( my $i = 0 ; $i < @Arrays ; ++$i )
   {
      for ( my $j = $i+1 ; $j < @Arrays ; ++$j )
      {
         if ( is_equal($Arrays[$i], $Arrays[$j]) )
         {
            splice @Arrays, $j, 1;
            --$j; # decrement $j so it again points to "item before next"
         }
      }
   }

   # Now that any duplicates are gone, print the remaining array refs:
   print("(");
   for(my $i=0;$i<@Arrays;++$i)
   {
      print('[');
      print(@{$Arrays[$i]});
      print(']');
      print(', ')if($i!=$#Arrays);
   }
   print(")\n");

   # We're done, so scram:
   exit;
} # end main

# Do two array refs point to identical anonymous arrays?
sub is_equal($$)
{
   my $r1 = shift;
   my $r2 = shift;
   my $eq = 0;
   my $sz1 = scalar(@{$r1});
   my $sz2 = scalar(@{$r2});
   if ($sz1 != $sz2) {return 0;}
   for ( my $i = 0 ; $i < $sz1 ; ++$i )
   {
      if ($r1->[$i] != $r2->[$i]) {return 0;}
   }
   return 1;
} # end sub is_equal

# Give help:
sub help
{
   print ((<<'   END_OF_HELP') =~ s/^   //gmr);
   To use this program, feed it a comma-separated list of array refs, enclosed in
   (parentheses) and 'single quotes', as its only command-line argument, like so:
   ./pwc-183a-unique-array-rh.pl '([3,7],[8,6],[8,5],[8,6],[9,3])'
   This program will then print a deduped version of the list you type.
   END_OF_HELP
   return 1;
} # end sub help