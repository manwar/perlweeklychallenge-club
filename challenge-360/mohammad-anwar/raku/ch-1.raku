#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["Hi",    5], out => "*Hi**"      },
    { in => ["Code", 10], out => "***Code***" },
    { in => ["Hello", 9], out => "**Hello**"  },
    { in => ["Perl",  4], out => "Perl"       },
    { in => ["A",     7], out => "***A***"    },
    { in => ["" ,     5], out => "*****"      },
);

for @examples -> $example {
    is justify-text(|$example<in>), $example<out>;
}

done-testing;

sub justify-text(Str $str, Int $width) {
    my $pad = $width - $str.chars;
    return "*" x ($pad div 2) ~ $str ~ "*" x ($pad - ($pad div 2));
}
