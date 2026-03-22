#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

#
# We will assume tokens contain only lowercase letters, at most one hyphen,
# and an optional final punctuation. As worded in the challenge, things
# like '#@@BAB', or '=' are valid tokens. We do accept '!', '.' and ','
# as valid tokens.
#

say scalar grep {/^(?:[a-z]+(?:-[a-z]+)?)?[!,.]?$/} split for <>;

__END__
