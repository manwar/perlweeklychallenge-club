use strict;
use warnings;

use bignum 'bpi';
print bpi((stat($0))[7]);
