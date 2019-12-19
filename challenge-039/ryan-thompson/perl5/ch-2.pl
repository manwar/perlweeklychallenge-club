#!/usr/bin/env perl
#
# ch-2.pl - Extensible RPN calculator
#
# Usage: ch-2.pl '5 r= 2 r ^ 4 ×' # Calculate area of circle with r=5
#        ch-2.pl 'π cos'          # Calculate cos(π)
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use Scalar::Util 'looks_like_number'; # Core

# Support UTF8 on output, input (@ARGV), and within the source itself
binmode STDOUT,    ':utf8';
binmode STDERR,    ':utf8';
use Encode   'decode_utf8';
@ARGV = map { decode_utf8($_, 1) } @ARGV;
use utf8;

my @stack;  # RPN stack
my %op;     # Operators dispatch
my %vars;   # User-defined namespace

# Convenience subs to install operations with commonly desired arity
sub nullary(&$) { my ($code, $op) = @_; op_install($code, $op, 0) }
sub   unary(&$) { my ($code, $op) = @_; op_install($code, $op, 1) }
sub  binary(&$) { my ($code, $op) = @_; op_install($code, $op, 2) }

# Install binary and unary operators.
# Easy to add more.
binary { $_[0] + $_[1] } '+';
binary { $_[0] - $_[1] } '-';
binary { $_[0] * $_[1] } '*';
binary { $_[0] / $_[1] } '/';
binary { $_[0] **$_[1] } '^';
binary { $_[0] % $_[1] } '%';
unary  { }               'pop';

unary  { my $n = 1; $n *= $_ for 1..pop; $n } '!';
unary  { sin($_[0]) / cos($_[0]) } 'tan';
unary \&CORE::sin, 'sin';
unary \&CORE::cos, 'cos';
unary \&CORE::abs, 'abs';
unary { 1 / pop }  'inv';
unary { - pop   }  'neg';

# Constants are effectively nullary operators
nullary { 3.14159265359 } 'π';

# OK, now we're just showing off... 5 x= assigns the value 5 to variable x
for my $var ('a'..'z') {
    unary   { $vars{$var} = $_[0]; return () } "$var=";
    nullary { $vars{$var} }              $var;
}

# Aliases are trivially supported
$op{'×'} = $op{'*'};
$op{'÷'} = $op{'/'};
$op{'−'} = $op{'-'};
$op{mod} = $op{'%'}; # Whatever you like.
$op{Pi}  = $op{'π'};

die "Usage: $0 'atom ...'\nOperators: @{[ sort keys %op ]}\n" unless @ARGV;

# The main loop is just a lookup in our dispatch table
for ( map { split } @ARGV ) {
    push @stack, looks_like_number($_) ? $_
               :        exists $op{$_} ? $op{$_}->()
               : die "Unknown operator: `$_'\n";
}

die "Too many values left on stack: <" . join(',',@stack) .">" if @stack > 1;
say @stack;

# A generic installer that supports any arity. Called by nullary(),
# unary(), and binary(), but can be used on its own if need be.
sub op_install {
    my ($code, $op, $arity) = @_;
    $op{$op} = sub {
        die "Stack: @{[ 0+@stack ]} < $arity" if @stack < $arity;
        my @operands;
        push @operands, pop @stack for 1..$arity;
        $code->(@operands);
    }
}
