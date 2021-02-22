use strict;
use warnings;
use feature "say";

my $time = shift;
if ($time =~ /([ap])m/) {
    if ($1 eq 'a')  {
        $time =~ s/(\d\d:\d\d).*/$1/;
    } else {
        $time =~ /(\d\d):(\d\d.).*/;
        my $hour = $1 + 12;
        $time = "$hour:$2";
    }
} else {
    $time =~ /^(\d\d):(\d\d)/;
    my ($suffix, $hour) = $1 > 12 ? ('pm', $1 - 12) : ('am', $1);
    $time = "$hour:$2 $suffix";
}
say $time;
