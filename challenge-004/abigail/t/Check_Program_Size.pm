package Check_Program_Size;

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use Test::More;

my $output = "t/output-1-1.exp";

sub test ($self, %args) {
    my $source = $args {source};
    is -s $source, (-s $output) - 1, "Program size";
}

1;

__END__
