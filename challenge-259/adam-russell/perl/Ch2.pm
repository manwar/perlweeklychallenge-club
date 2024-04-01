####################################################################
#
#    This file was generated using Parse::Yapp version 1.21.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Ch2;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 9 "perl/ch-2.yp"

  my %record = (fields => {});  


sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.21',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'START' => 1
		},
		GOTOS => {
			'file' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 3
		},
		GOTOS => {
			'id' => 4
		}
	},
	{#State 2
		ACTIONS => {
			'' => 5
		}
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		ACTIONS => {
			'WORD' => 6
		},
		GOTOS => {
			'fields' => 7,
			'field' => 8
		}
	},
	{#State 5
		DEFAULT => 0
	},
	{#State 6
		ACTIONS => {
			"=" => 9
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 6,
			'END' => 11
		},
		GOTOS => {
			'field' => 10
		}
	},
	{#State 8
		DEFAULT => -8
	},
	{#State 9
		ACTIONS => {
			'QUOTE' => 13,
			'NUMBER' => 12
		}
	},
	{#State 10
		DEFAULT => -9
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			'WORD' => 15
		},
		GOTOS => {
			'words' => 14
		}
	},
	{#State 14
		ACTIONS => {
			'WORD' => 16,
			'QUOTE' => 18,
			'ESCAPED_QUOTE' => 17
		}
	},
	{#State 15
		DEFAULT => -3
	},
	{#State 16
		DEFAULT => -4
	},
	{#State 17
		ACTIONS => {
			'WORD' => 19
		}
	},
	{#State 18
		DEFAULT => -7
	},
	{#State 19
		ACTIONS => {
			'ESCAPED_QUOTE' => 20
		}
	},
	{#State 20
		DEFAULT => -5
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'file', 4,
sub
#line 15 "perl/ch-2.yp"
{$record{name} = $_[2]; \%record;}
	],
	[#Rule 2
		 'id', 1, undef
	],
	[#Rule 3
		 'words', 1, undef
	],
	[#Rule 4
		 'words', 2, undef
	],
	[#Rule 5
		 'words', 4, undef
	],
	[#Rule 6
		 'field', 3,
sub
#line 26 "perl/ch-2.yp"
{$record{fields}->{$_[1]} = $_[3]}
	],
	[#Rule 7
		 'field', 5,
sub
#line 27 "perl/ch-2.yp"
{$record{fields}->{$_[1]} = $_[4]}
	],
	[#Rule 8
		 'fields', 1, undef
	],
	[#Rule 9
		 'fields', 2, undef
	]
],
                                  @_);
    bless($self,$class);
}

#line 34 "perl/ch-2.yp"

  

sub lexer{
  my($parser) = @_;
  $parser->YYData->{INPUT} or return('', undef);
  $parser->YYData->{INPUT} =~ s/^[ \t]//g;
  ##
  # send tokens to parser
  ##
  for($parser->YYData->{INPUT}){
      s/^([0-9]+)// and return ("NUMBER", $1);
      s/^({%)// and return ("START", $1);
      s/^(%})// and return ("END", $1);
      s/^(\w+)// and return ("WORD", $1);
      s/^(=)// and return ("=", $1);
      s/^(")// and return ("QUOTE", $1);
      s/^(\\")// and return ("ESCAPED_QUOTE", $1);
      s/^(\\\\)// and return ("WORD", $1);
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
  $input =~ tr/\t/ /s;
  $input =~ tr/ //s;
  $self->YYData->{INPUT} = $input;
  my $result = $self->YYParse(yylex => \&lexer, yyerror => \&error);
  return $result;  
}



1;
