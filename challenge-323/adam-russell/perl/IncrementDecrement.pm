####################################################################
#
#    This file was generated using Parse::Yapp version 1.21.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package IncrementDecrement;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 10 "perl/IncrementDecrement.yp"

      my $variable_state = {};  
  

sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.21',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'DECREMENT' => 2,
			'INCREMENT' => 7,
			'LETTER' => 1
		},
		GOTOS => {
			'program' => 9,
			'decrement_variable' => 8,
			'increment_decrement' => 4,
			'increment_variable' => 3,
			'variable_declaration' => 6,
			'statement' => 5
		}
	},
	{#State 1
		ACTIONS => {
			'INCREMENT' => 11,
			'DECREMENT' => 10
		},
		DEFAULT => -5
	},
	{#State 2
		ACTIONS => {
			'LETTER' => 12
		}
	},
	{#State 3
		DEFAULT => -6
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		DEFAULT => -1
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'LETTER' => 13
		}
	},
	{#State 8
		DEFAULT => -7
	},
	{#State 9
		ACTIONS => {
			'' => 15,
			'LETTER' => 1,
			'INCREMENT' => 7,
			'DECREMENT' => 2
		},
		GOTOS => {
			'statement' => 14,
			'variable_declaration' => 6,
			'increment_variable' => 3,
			'decrement_variable' => 8,
			'increment_decrement' => 4
		}
	},
	{#State 10
		DEFAULT => -11
	},
	{#State 11
		DEFAULT => -9
	},
	{#State 12
		DEFAULT => -10
	},
	{#State 13
		DEFAULT => -8
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => 0
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'program', 1,
sub
#line 19 "perl/IncrementDecrement.yp"
{$variable_state}
	],
	[#Rule 2
		 'program', 2, undef
	],
	[#Rule 3
		 'statement', 1, undef
	],
	[#Rule 4
		 'statement', 1, undef
	],
	[#Rule 5
		 'variable_declaration', 1,
sub
#line 27 "perl/IncrementDecrement.yp"
{$variable_state->{$_[1]} = 0}
	],
	[#Rule 6
		 'increment_decrement', 1, undef
	],
	[#Rule 7
		 'increment_decrement', 1, undef
	],
	[#Rule 8
		 'increment_variable', 2,
sub
#line 34 "perl/IncrementDecrement.yp"
{$variable_state->{$_[2]}++}
	],
	[#Rule 9
		 'increment_variable', 2,
sub
#line 35 "perl/IncrementDecrement.yp"
{$variable_state->{$_[1]}++}
	],
	[#Rule 10
		 'decrement_variable', 2,
sub
#line 38 "perl/IncrementDecrement.yp"
{$variable_state->{$_[2]}--}
	],
	[#Rule 11
		 'decrement_variable', 2,
sub
#line 39 "perl/IncrementDecrement.yp"
{$variable_state->{$_[1]}--}
	]
],
                                  @_);
    bless($self,$class);
}

#line 44 "perl/IncrementDecrement.yp"

    
    
  
  sub lexer{
    my($parser) = @_;
    $parser->YYData->{INPUT} or return(q//, undef);
    $parser->YYData->{INPUT} =~ s/^[ \t]//g;
    ##
    # send tokens to parser
    ##
    for($parser->YYData->{INPUT}){
        s/^(\s+)// and return (q/SPACE/, $1);
        s/^([a-z]{1})// and return (q/LETTER/, $1);
        s/^(\+\+)// and return (q/INCREMENT/, $1);
        s/^(--)// and return (q/DECREMENT/, $1);
    }  
  }

  
  sub parse{
    my($self, $input) = @_;
    $input =~ tr/\t/ /s;
    $input =~ tr/\n/ /s;
    $self->YYData->{INPUT} = $input;
    my $result = $self->YYParse(yylex => \&lexer, yyerror => \&error);
    return $result;  
  }

  
  sub error{
    exists $_[0]->YYData->{ERRMSG}
    and do{
        print $_[0]->YYData->{ERRMSG};
            return;
    };
    print "syntax error\n"; 
  }

  
    sub clear{
        my($self) = @_;
        $variable_state = {};  
    }



1;
