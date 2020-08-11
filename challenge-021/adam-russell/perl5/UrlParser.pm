####################################################################
#
#    This file was generated using Parse::Yapp version 1.21.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package UrlParser;
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
			'SCHEME' => 3
		},
		GOTOS => {
			'scheme' => 2,
			'url' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 4
		}
	},
	{#State 2
		ACTIONS => {
			"://" => 5
		},
		GOTOS => {
			'colondoubleslash' => 6
		}
	},
	{#State 3
		DEFAULT => -7
	},
	{#State 4
		DEFAULT => 0
	},
	{#State 5
		DEFAULT => -6
	},
	{#State 6
		ACTIONS => {
			'HOST' => 7,
			'USERPASSWORD' => 8
		},
		GOTOS => {
			'host' => 9,
			'userpassword' => 10
		}
	},
	{#State 7
		DEFAULT => -9
	},
	{#State 8
		DEFAULT => -8
	},
	{#State 9
		ACTIONS => {
			'PATH' => 12
		},
		DEFAULT => -5,
		GOTOS => {
			'path' => 11
		}
	},
	{#State 10
		ACTIONS => {
			'HOST' => 7
		},
		GOTOS => {
			'host' => 13
		}
	},
	{#State 11
		ACTIONS => {
			'QUERY' => 14,
			'FRAGMENT' => 17
		},
		DEFAULT => -4,
		GOTOS => {
			'fragment' => 16,
			'query' => 15
		}
	},
	{#State 12
		DEFAULT => -11
	},
	{#State 13
		ACTIONS => {
			'PORT' => 19
		},
		GOTOS => {
			'port' => 18
		}
	},
	{#State 14
		DEFAULT => -12
	},
	{#State 15
		ACTIONS => {
			'FRAGMENT' => 17
		},
		GOTOS => {
			'fragment' => 20
		}
	},
	{#State 16
		DEFAULT => -3
	},
	{#State 17
		DEFAULT => -13
	},
	{#State 18
		ACTIONS => {
			'PATH' => 12
		},
		GOTOS => {
			'path' => 21
		}
	},
	{#State 19
		DEFAULT => -10
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		ACTIONS => {
			'QUERY' => 14
		},
		GOTOS => {
			'query' => 22
		}
	},
	{#State 22
		ACTIONS => {
			'FRAGMENT' => 17
		},
		GOTOS => {
			'fragment' => 23
		}
	},
	{#State 23
		DEFAULT => -1
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'url', 8, undef
	],
	[#Rule 2
		 'url', 6, undef
	],
	[#Rule 3
		 'url', 5, undef
	],
	[#Rule 4
		 'url', 4, undef
	],
	[#Rule 5
		 'url', 3, undef
	],
	[#Rule 6
		 'colondoubleslash', 1,
sub
#line 9 "perl5/UrlGrammar.yp"
{ print $_[1] }
	],
	[#Rule 7
		 'scheme', 1,
sub
#line 11 "perl5/UrlGrammar.yp"
{ print lc($_[1]) }
	],
	[#Rule 8
		 'userpassword', 1,
sub
#line 13 "perl5/UrlGrammar.yp"
{ print $_[1] }
	],
	[#Rule 9
		 'host', 1,
sub
#line 15 "perl5/UrlGrammar.yp"
{ print lc($_[1]) }
	],
	[#Rule 10
		 'port', 1,
sub
#line 17 "perl5/UrlGrammar.yp"
{ $_[1] =~ s/://; print "" }
	],
	[#Rule 11
		 'path', 1,
sub
#line 19 "perl5/UrlGrammar.yp"
{ print $_[1] }
	],
	[#Rule 12
		 'query', 1,
sub
#line 21 "perl5/UrlGrammar.yp"
{ print $_[1] }
	],
	[#Rule 13
		 'fragment', 1,
sub
#line 23 "perl5/UrlGrammar.yp"
{ print "" }
	]
],
                                  @_);
    bless($self,$class);
}

#line 25 "perl5/UrlGrammar.yp"

sub lexer{
    my($parser) = @_;
    $parser->YYData->{INPUT} or return('', undef);
    $parser->YYData->{INPUT} =~ s/^[ \t]//;
    ##
    # send tokens to parser
    ##
    for($parser->YYData->{INPUT}){
        s/^(http|https|ftp|jdbc)//i and return ("SCHEME", $1); 
        s/^(:\/\/)// and return ("://", $1);
        s/^(:[0-9]*)// and return ("PORT", $1);
        s/^([a-zA-Z]*:[a-zA-Z]*)// and return ("USERPASSWORD", $1); 
        s/^(\/[\/a-zA-Z]*)// and return ("PATH", $1);
        s/^(\?{1}[a-zA-z=a-zA-Z]*)// and return ("QUERY", $1);
        s/^(#{1}[a-zA-Z]*[0-9]*)// and return ("FRAGMENT", $1); 
        s/^(@?\/{0}[a-zA-z]*)// and return ("HOST", $1);
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
