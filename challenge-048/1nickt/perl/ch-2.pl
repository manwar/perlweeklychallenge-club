use strict;
use warnings;
use DateTime::Set;

# Date cannot be higher than 31; thus year must be lower than 2300
my $end   = DateTime->new({ year => 2299, month => 12, day => 31 });
my $start = $end->clone->add( days => 1 )->set_year('2000');

my $dates = DateTime::Set->from_recurrence(
    start      => $start,
    end        => $end,
    recurrence => sub { shift->add( days => 1 ) },
);

my $iter = $dates->iterator;

while ( defined(my $date = $iter->next) ) {
    my $us_format = $date->strftime('%m%d%Y');
    print "$us_format\n" if $us_format eq reverse $us_format;
}
