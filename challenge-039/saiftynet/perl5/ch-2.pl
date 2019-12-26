#!/usr/env perl
# Perl Challenge 39 Task 2
# a reverse polish notation calculator delivering over 50 operators
# including arithmetic, trigonometric, string, and stack operations
# in about 100 lines of Perl including comments, and is partly coded
# using RPN. 

use strict;
use warnings;
my (@stack,%operators,$quiet);

# Perl's built-in operations allow conventional notation mathematics 
# simply use eval to perform these operations on the stacks contents

# binary built-in operators 22
foreach my $op(qw{+ - * / % . ** == != <=> > < >= <= lt gt le ge eq ne cmp x}){
		$operators{$op}=sub{
			my ($v1,$v2)=map {quoteStrings($_)} @stack[0,1];
			@stack=(eval "$v1 $op $v2", splice @stack,2);
		};
}

#unary built-in operators 18
foreach my $op(qw{int floor ceil sin cos log exp sqrt uc lc length chr ucfirst lcfirst hex oct ~}){
		$operators{$op}=sub{
			my $v1=quoteStrings($stack[0]);
			@stack=(eval "$op($v1)", splice @stack,1);
		};
}

# misc functions 19... Useful trigonometric functions and stack operators
# these extend the available functions provide other trigonometric operations,
# stack operations, random nmumbers as well as control the displayed results
@operators{qw/asin acos tan atan atan2 deg rad pi e rand randint dup swap del clear = quiet talk test/}=(
	  sub { parse (qw{quiet dup dup * 1 - sqrt swap atan2 talk} ) },# atan2($tmp, sqrt(1 - $tmp * $tmp))
	  sub { parse (qw{quiet dup dup * 1 - sqrt atan2 talk} ) },     # atan2(sqrt(1 - $tmp * $tmp), $tmp) 
	  sub { parse (qw{quiet dup cos swap sin / talk}) },
	  sub { parse (qw{quiet 1 swap atan2 talk}) },
	  sub { my ($tmp1,$tmp2)=(shift @stack,shift @stack);           # derives other trig functions
		    unshift @stack, atan2($tmp1,$tmp2)  },
	  sub { parse (qw{quiet pi 180 / * talk}) },
	  sub { parse (qw{quiet pi * 180 swap / talk}) },
	  sub { parse (qw{quiet -1 0 atan2 talk})},
	  sub { parse (qw{quiet 1 exp talk}) },   
	  sub { unshift @stack, rand()},
	  sub { parse (qw{quiet rand * int talk})},
	  sub { unshift @stack, $stack[0]},
	  sub { @stack[0,1]= @stack[1,0]},
	  sub { shift @stack},	
	  sub { @stack=()},	
	  sub { print "Output : $stack[0]\n" },	
	  sub { $quiet++},
	  sub { $quiet = $quiet <=1?0:$quiet-1;},
	  sub { parse (qw{quiet dup dup * 1 - sqrt atan2 talk} ) }	#atan2( sqrt(1 - $tmp * $tmp), $tmp ) 	
	);

# guess whether the parameter is a string or a number
# numbers AND ed with their two's complement produce zero
# this quotes strings and numerifies mumbers
sub quoteStrings{
		my $tmp=shift;  
		if ($tmp & ~$tmp) {return "\"".$tmp."\"";}
		return eval {1*$tmp}
	}
	
# main function that parses inputs passed from the intercative console 
# or as an array
sub parse{
   my @in=@_;
   foreach (@in){   
	   chomp ;
	   # multiline commands are enclosed in square braces and
	   # separated by spaces
	   return parse(split /\s+/,$1) if (m/^\[(.*)]$/) ; 
	   # next line allows ÷ × and - found in Wkipedia article
	   s/^÷$/\//;s/^×$/\*/;s/^−$/-/;           
	   exit print "Goodbye! \n" if (/quit/i);
	   if (exists $operators{$_}){ # matches one of known operators
		   $operators{$_}->();
	   }
	   else {unshift @stack,$_};   # push data onto stack
	   report($_); # exists to allow user visualisation of operations 
	}
}

# exists to allow user visualisation of operations
sub report{
	printf("You entered: %-10s Stack is now :  %s\n", shift,(join ",",@stack) )
	    unless $quiet || $_ =~/^talk|=$/;
}

##  Test, demonstrates how to use the calculator
print "Running example test calculation\n";
parse (qw{9 9 3 * 6 2 ** - * clear hello_ ucfirst world swap . = clear});
	
##  Main routine to start interactive rpn calculator	
print "\nStarting interactive rpn calculator:\n
Enter values or operations or unquoted strings or 'quit' to quit.
DO NOT QUOTE STRINGS, the calculator will try and guess what you need.
For Multi-statement input use square braces and separate using spaces\nRPN>" ;
while (<>){
	parse ($_);   # parse input
	print "RPN>"; # prompt for next input
	};
