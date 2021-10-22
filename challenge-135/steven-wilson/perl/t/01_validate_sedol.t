use strict;
use warnings;
use Test::More tests => 6;
use Test::Exception;
use SEDOL;

ok( validate_sedol('2936921') == 1, "Valid SEDOL" );
ok( validate_sedol('1234567') == 0, "Invalid SEDOL" );
ok( validate_sedol('B0YBKL9') == 1, "Valid SEDOL" );
dies_ok { validate_sedol('B0YBKLA'), } 'Die when check digit not a digit';
dies_ok { validate_sedol('B0YBKLF9'), } "Die when SEDOL not correct length";
dies_ok { validate_sedol('#0YDK29'), } "Die when invalid character";
