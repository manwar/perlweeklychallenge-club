use strict;
use warnings;
##
# Write a script to encode/decode Roman numerals.
## 
use boolean;
use Fstream;
use Parse::YYLex;

use RomanParser;

use constant DEBUG => false;

my $s = new Fstream(\*STDIN, "STDIN");
my $lexer = new Parse::YYLex;
my $parser = new RomanParser(\&RomanParser::yylex, \&RomanParser::yyerror, DEBUG);
$parser->yyparse($s);
