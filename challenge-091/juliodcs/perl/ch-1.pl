use strict;
use warnings;
use Lingua::EN::Numbers 'num2en';
use feature 'say';

say((shift // 42) =~ s/((\d)\2*)/num2en(length $1)." $2 "/egr)
