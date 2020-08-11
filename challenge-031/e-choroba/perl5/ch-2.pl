#!/usr/bin/perl
use warnings;
use strict;

my $var_name = shift;
{   no strict 'refs';
    ${ $var_name } = "Don't try this at home!";
    print "\$$var_name: ", $$var_name, "\n";
}

=head1 Some interesting values

=over

=item ! or ?

Argument "Don't try this at home!" isn't numeric in scalar assignment

=item & or +

Modification of a read-only value attempted

=item \

 Don't try this at home!
 Don't try this at home!

No newline after the second line.


=item ,

Don't try this at home!Don't try this at home!Don't try this at home!

=back

=cut
