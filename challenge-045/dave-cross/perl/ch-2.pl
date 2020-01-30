#!/use/bin/perl

use strict;
use warnings;

seek DATA, 0, 0;
print while <DATA>;
__END__
