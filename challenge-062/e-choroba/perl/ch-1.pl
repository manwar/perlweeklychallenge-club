#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Email::Sorter;
    use Email::Address::XS;
    use List::UtilsBy qw{ uniq_by };

    sub _sort {
        sort { lc $a->host cmp lc $b->host
               || $a->user cmp $b->user
        } @_
    }

    sub _parse {
        map 'Email::Address::XS'->parse($_), @_
    }

    sub sort_by_domain {
        return map $_->address, _sort(_parse(@_))
    }

    sub sort_by_domain_uniq {
        my @emails = @_;
        return map $_->address,
               _sort(
                   uniq_by { join $_->user, '@', lc $_->host }
                   reverse _parse(@_) )
    }
}

use Getopt::Long qw( :config no_getopt_compat ); # +u not allowed
GetOptions(u => \ my $unique);

if ($unique) {
    say for My::Email::Sorter::sort_by_domain_uniq(<>);

} else {
    say for My::Email::Sorter::sort_by_domain(<>);
}

__END__
use Test::More;
use Test::Deep;

my @t1 = qw( name@example.org
             rjt@cpan.org
             Name@example.org
             rjt@CPAN.org
             user@alpha.example.org );

cmp_deeply [My::Email::Sorter::sort_by_domain(@t1)],
           [qw[ user@alpha.example.org
                rjt@cpan.org
                rjt@CPAN.org
                Name@example.org
                name@example.org ]];

cmp_deeply [My::Email::Sorter::sort_by_domain_uniq(@t1)],
           [qw[ user@alpha.example.org
                rjt@CPAN.org
                Name@example.org
                name@example.org ]];

my @t2 = qw( "charlie@home"@email.us
             "anna\"@\"home"@email.us );
cmp_deeply [My::Email::Sorter::sort_by_domain(@t2)],
           [qw[ "anna\"@\"home"@email.us
                "charlie@home"@email.us ]];

done_testing();
