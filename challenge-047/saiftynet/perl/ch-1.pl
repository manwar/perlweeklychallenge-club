#!/usr/env perl

# Roman Calculator
# Write a script that accepts two roman numbers and operation.
# It should then perform the operation on the given roman
# numbers and print the result.

# There are several modules to hadle conversions to and from
# roman numerals  Math::Roman, Number::Convert::Roman, Roman etc.
# But this script does it much more simply than those modules.
#
# For more info enter '?' as an argument.
# Without input the script enters interactive mode

use strict; use warnings;

# The script will try overlines in Linux consoles. This can be disabled
# by setting $disableANSI  to nonzero.
my $disableANSI=0;      

# Initialise the convertor array (not hash, as sequence is key)
our @converter=(
   [900 ,"CM"],   [1000,"M" ],
   [400 ,"CD"],   [500 ,"D" ],
   [90  ,"XC"],   [100 ,"C" ],
   [40  ,"XL"],   [50  ,"L" ],
   [9   ,"IX"],   [10  ,"X" ],
   [4   ,"IV"],   [5   ,"V" ],
   [1   ,"I" ],
);

# handles the multiples of 1000...conventionally written as an overline
# but here managed using an underscore to prefix, so _M is 1,000,000
foreach my $conv (reverse @converter[0..11]){
	unshift @converter,[1000*$$conv[0],"_".(join "_",(split //,$$conv[1]))];
	# _I is replaced by M ( _ prefix is the 1000 multiplier)
	${$converter[0]}[1]=~s/_I/M/;  
	
};

my $input=join "",@ARGV;

if ($input){ # work on input if provided, entering '?' displays help
	print "",($input=~/\?/)?printHelp():calculate($input)."\n";
}
else {       # Enter Interactive mode if no input 
	print"\nEnter a roman numeral calculation to perform\nEnter '?' for help, or 'q' to quit >> " ;
	while( chomp ($input = <>)){
		exit 0 * print "Goodbye" if $input eq "q";  # print goodbye on quit
		next  if $input eq "?" && printHelp();      # print help
		print "Answer = ",overline(calculate($input));
		print"\n\nEnter another calculation to perform\n '?' for help, or 'q' to quit >> " ;
	}
}

# print overlines.  The standard for expressing larger numbers is to use
# an overline as a 1000 multiplier.  The ANSI terminal has sequences that
# allow this. Windows may as well, but I have no way of testing this.
sub overline{
	my $roman=shift;
	return $roman if (($^O=~/Win/)|| $disableANSI);  #  
	my $OL=chr(27) . '[0;53m';
	my $NO=chr(27) . '[0m';
	$roman=~s/_(.)/$OL$1$NO/g;
	return $roman;
}

# This calculate routine just converts any roman-number-like string into arabic
# and evals the result.  No attempt at validation
sub calculate{
	my $str=shift;
	$str =~ s/([MDCLXVI_]+)/arabic($1)/ieg;
	return roman(eval $str);
}

# converts roman numbers to arabic, using @convertor to look up
# values and accumulating them in $arabic
sub arabic{
	my $roman=shift;
	return 0 if ! $roman;
	my $arabic=0;
	foreach my $conv(@converter){
	  my $re=$$conv[1];
	  $arabic+=$$conv[0] while $roman=~s/$re//i;
	}
	return $arabic;
}

# converts arabic numbers to roman, using @convertor to look up
# values, but the sequence of the look up has to be altered for
# correct conversion...the @revert sequence is generated and used
sub roman{
	my $arabic=shift;
	return "Nil" if !$arabic; # zero or erros return nil
	my $roman="";
    my @revert=map { 2*$_+1 , 2*$_ }(0..($#converter-1)/2);
	foreach my $conv(@converter[@revert,-1]){
	  while ($arabic>=$$conv[0]){
		  $roman.=$$conv[1] ;
		  $arabic-=$$conv[0];
		  };
	}
	return $roman
}

# this superfluous validity check works merely by ensuring that
# same string is obtained when converting into arabic and back
# This is provides validation against srings such as "IM"
sub isValid{
	my $testString=shift;
	return ( $testString eq roman(arabic($testString)) ) ?1:0;
}

sub printHelp{
	print <<EndHelp;
	
############    The Roman Numeral Calculator    ##################	

Input a calculation in Roman Numerals, and the result is returned in
Roman Numerals. Actually the input can contan decimal numbers as well
"VI*IV", "ix ** 2", and "13000/250" are all valid inputs.
If no command line arguments are passed then an interactive mode starts.

Complex calculations are also possible e.g. sqrt(XXXVI**II + LXXVII**II)
but these need to be quoted if used in the command line.

For numbers greater than a 1000, an overline is described.  To input
this on the console the user precedes the character with an underscore.
e.g. 4000 is M_V. In Linux consoles the escape sequence can be used to
generate an overline for the output. This may be extended to Windows
consoles using Term::ANSI...not sure

Calculator limit is 3_999_999 or _M_M_M_C_M_X_CMXCMXCIX

No attempt is made to validate inputs. Invalid combinations such as XM
does not give correct results.  One can test this by entering  the numeral
you want to test. The application returns the interpretted value.
Entering a decimal number on its own translates it into roman.
	
EndHelp
	
}
