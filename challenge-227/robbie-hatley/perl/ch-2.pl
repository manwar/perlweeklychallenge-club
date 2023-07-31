#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 227-2.
Written by Robbie Hatley on Mon Jul 24, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Roman Maths
Submitted by: Peter Campbell Smith
Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.
Examples:
IV + V     => IX
M - I      => CMXCIX
X / II     => V
XI * VI    => LXVI
VII ** III => CCCXLIII
V - V      => nulla (they knew about zero but didn't have a symbol)
V / II     => non potest (they didn't do fractions)
MMM + M    => non potest (they only went up to 3999)
V - X      => non potest (they didn't do negative numbers)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'm sooooo not going to make roman-to-arabic or arabic-to-roman converters. Let's see what CPAN has to offer.
Ah, it has "Text::Roman". Fine I'll use that. The rest is just expression validity checking, operator parsing,
Latin output phrasing ("nulla" or "non potest" where appropriate), and other such details.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of single-quoted roman-math expressions, with operators separated from operands with
white space, in proper Perl syntax, like so:
./ch-2.pl "('MCMLXIX - MCMLIV', 'XIV / VII')"

Output is to STDOUT and will be each expression followed by its result.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use Text::Roman ':all';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Does given string represent a valid operator?
sub isopera ($o) {
   return ( $o =~ m/(?:^\+$)|(?:^-$)|(?:^\*$)|(?:^\/$)|(?:^\*\*$)/ );
}

# Perform a calculation using Roman numerals:
sub computare ($e) {
   my @array = split /\s+/, $e;
   return "INVALID EXPRESSION" if ( 3 != scalar @array );
   my ($x, $o, $y) = @array;
   return "INVALID EXPRESSION" if ( ! isroman($x) );
   return "INVALID EXPRESSION" if ( ! isopera($o) );
   return "INVALID EXPRESSION" if ( ! isroman($y) );
   my $result = 0;
   if    ( '+'  eq $o ) {
      $result = roman2int($x)  + roman2int($y);
   }
   elsif ( '-'  eq $o ) {
      $result = roman2int($x)  - roman2int($y);
   }
   elsif ( '*'  eq $o ) {
      $result = roman2int($x)  * roman2int($y);
   }
   elsif ( '/'  eq $o ) {
      $result = roman2int($x)  / roman2int($y);
   }
   elsif ( '**' eq $o ) {
      $result = roman2int($x) ** roman2int($y);
   }
   return 'nulla'      if 0 == $result;               # no symbol for 0
   return 'non potest' if 0 != $result - int $result; # no fractions
   return 'non potest' if $result > 3999;             # no numbers > 3999
   return 'non potest' if $result <    0;             # no numbers <    0
   return int2roman($result);
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @expressions =
(
   'IV + V',
   'M - I',
   'X / II',
   'XI * VI',
   'VII ** III',
   'V - V',
   'V / II',
   'MMM + M',
   'V - X',
);

# Non-default inputs:
@expressions = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $expression (@expressions) {
   say '';
   say "$expression = ", computare($expression);
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
