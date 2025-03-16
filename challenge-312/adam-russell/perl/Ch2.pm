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

#line 4 "perl/ch-2.yp"

      my %boxes = ();  
  

sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.21',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'LETTER' => 3
		},
		GOTOS => {
			'record' => 1,
			'records' => 2
		}
	},
	{#State 1
		DEFAULT => -1
	},
	{#State 2
		ACTIONS => {
			'' => 4,
			'LETTER' => 3
		},
		GOTOS => {
			'record' => 5
		}
	},
	{#State 3
		ACTIONS => {
			'NUMBER' => 6
		}
	},
	{#State 4
		DEFAULT => 0
	},
	{#State 5
		DEFAULT => -2
	},
	{#State 6
		DEFAULT => -3
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'records', 1,
sub
#line 10 "perl/ch-2.yp"
{\%boxes}
	],
	[#Rule 2
		 'records', 2, undef
	],
	[#Rule 3
		 'record', 2,
sub
#line 14 "perl/ch-2.yp"
{push @{$boxes{qq/$_[2]/}}, $_[1]}
	]
],
                                  @_);
    bless($self,$class);
}

#line 17 "perl/ch-2.yp"


  sub lexer{
      my($parser) = @_;
      defined($parser->YYData->{INPUT}) or return('', undef);
      ##
      # send tokens to parser
      ##
      for($parser->YYData->{INPUT}){
          s/^([0-9])// and return (q/NUMBER/, $1);
          s/^([A-Z])// and return (q/LETTER/, $1);
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
