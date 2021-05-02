####################################################################
#
#    This file was generated using Parse::Yapp version 1.21.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package PhoneNumberParser;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.21',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'OPEN' => 1,
			'DIGIT' => 5,
			'PLUS' => 3
		},
		GOTOS => {
			'phone_number' => 4,
			'prefix' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'DIGIT' => 6
		}
	},
	{#State 2
		ACTIONS => {
			'SPACE' => 7
		}
	},
	{#State 3
		ACTIONS => {
			'DIGIT' => 8
		}
	},
	{#State 4
		ACTIONS => {
			'' => 9
		}
	},
	{#State 5
		ACTIONS => {
			'DIGIT' => 10
		}
	},
	{#State 6
		ACTIONS => {
			'DIGIT' => 11
		}
	},
	{#State 7
		ACTIONS => {
			'DIGIT' => 12
		},
		GOTOS => {
			'area_exchange_subscriber' => 13
		}
	},
	{#State 8
		ACTIONS => {
			'DIGIT' => 14
		}
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		ACTIONS => {
			'DIGIT' => 15
		}
	},
	{#State 11
		ACTIONS => {
			'CLOSE' => 16
		}
	},
	{#State 12
		ACTIONS => {
			'DIGIT' => 17
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -4
	},
	{#State 15
		ACTIONS => {
			'DIGIT' => 18
		}
	},
	{#State 16
		DEFAULT => -3
	},
	{#State 17
		ACTIONS => {
			'DIGIT' => 19
		}
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		ACTIONS => {
			'DIGIT' => 20
		}
	},
	{#State 20
		ACTIONS => {
			'DIGIT' => 21
		}
	},
	{#State 21
		ACTIONS => {
			'DIGIT' => 22
		}
	},
	{#State 22
		ACTIONS => {
			'DIGIT' => 23
		}
	},
	{#State 23
		ACTIONS => {
			'DIGIT' => 24
		}
	},
	{#State 24
		ACTIONS => {
			'DIGIT' => 25
		}
	},
	{#State 25
		ACTIONS => {
			'DIGIT' => 26
		}
	},
	{#State 26
		DEFAULT => -5
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'phone_number', 3, undef
	],
	[#Rule 2
		 'prefix', 4, undef
	],
	[#Rule 3
		 'prefix', 4, undef
	],
	[#Rule 4
		 'prefix', 3, undef
	],
	[#Rule 5
		 'area_exchange_subscriber', 10, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 15 "PhoneNumberParser.yp"


sub lexer{
    my($parser) = @_;
    $parser->YYData->{INPUT} or return('', undef);
    ##
    # send tokens to parser
    ##
    for($parser->YYData->{INPUT}){
        s/^(\s)// and return ("SPACE", $1);
        s/^(\d)// and return ("DIGIT", $1);
        s/^(\()// and return ("OPEN", $1);
        s/^(\))// and return ("CLOSE", $1);
        s/^(\+)// and return ("PLUS", $1);
    }  
}

sub error{
    exists $_[0]->YYData->{ERRMSG}
    and do{
        print $_[0]->YYData->{ERRMSG};
            return;
    };
    print "syntax error\n"; 
}

sub parse{
    my($self, $input) = @_;
    $self->YYData->{INPUT} = $input;
    my $result = $self->YYParse(yylex => \&lexer, yyerror => \&error);
    return $result;  
}
1;
