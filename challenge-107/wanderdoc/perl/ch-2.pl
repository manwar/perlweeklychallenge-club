#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to list methods of a package/class.
Example

package Calc;

use strict;
use warnings;

sub new { bless {}, shift; }
sub add { }
sub mul { }
sub div { }

1;

Output

BEGIN
mul
div
new
add

=cut

package Calc
{
     use strict;
     use warnings;

     sub new { bless {}, shift; }
     sub add { }
     sub mul { }


     sub div { }
     1;
}

print "$_$/" for sort keys %Calc::;
print "Or ... (no 'BEGIN' though)$/";
for ( sort keys %Calc:: ) {print "$_$/" if Calc->can($_);}


print "Or better ...(still no 'BEGIN') $/";
use Class::Inspector;
print "$_$/" for @{ Class::Inspector->methods('Calc')};