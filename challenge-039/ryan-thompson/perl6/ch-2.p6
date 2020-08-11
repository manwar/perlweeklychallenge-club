#!/usr/bin/env perl6

# ch-2.p6 - Raku-flavoured RPN calculator
#
# Ryan Thompson <rjt@cpan.org>

use v6.d;

my @stack;                #| RPN stack
my %op = gen-op-dispatch; #| Operators dispatch table
my %var;                  #| User variables a..z

#| Simple main loop lets %op do all the heavy lifting
sub MAIN( Str $rpn-expr ) {
    for $rpn-expr.words -> $tok {
        if $tok.Numeric { @stack.push( $tok ) }
        else {
            die "Unknown operator ｢$tok｣" if %op{$tok}:!exists;
            %op{$tok}.()
        }
    }

    say |@stack;
}

#| Generate the complete operator dispatch table. Easy to extend!
#  I'll show a few ways to specify operators.
sub gen-op-dispatch( --> Hash ) {
    my Code %op = (
       '+'  => op-gen( { $^a + $^b } ); # Binary
       '-'  => op-gen( { $^a - $^b } );
       '/'  => op-gen( { $^a / $^b } );
       '*'  => op-gen( { $^a * $^b } );
      'abs' => op-gen( { $^a.abs   } );

       '!'  => op-gen( {[*] 1..$^a } ); # Unary
      'pop' => op-gen( sub ($x) {()} );

      'Pi'  => op-gen( { 3.1415926 } ); # Nullary
    );

    %op<π>  = %op<Pi>;                  # Aliases
    %op<×>  = %op<*>;
    %op<÷>  = %op</>;
    %op<−>  = %op<->;

    # v6.d supports the use of junctions as hash keys, so this works, too:
    %op{"^"|"**"}  = op-gen( { $^a ** $^b } );
    %op{"%"|"mod"} = op-gen( { $^a %  $^b } );

    # We can support user variables with two lines of code:
    %op{"$_="}     = op-gen( { %var{$_} = $^a; () } ) for 'a'..'z';
    %op{ $_  }     = op-gen( { %var{$_}           } ) for 'a'..'z';

    return %op;
}

#| Generate an operator and return a Code object that can be added to %op
#  We introspect &code.arity to know how many @operands to pop off the @stack
sub op-gen( &code --> Code ) {
    sub () {
        die "Stack: {@stack.elems} < {&code.arity}" if @stack < &code.arity;
        my @operands;
        @operands.push: @stack.pop for 1..&code.arity;
        @stack.push: |code( |@operands );
    }
}
