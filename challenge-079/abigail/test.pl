#!/opt/perl/bin/perl

#
# Test the solutions. Either call it with the directory name you
# want to test in, or call it as "../test.pl" from within the directory.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

chdir ".." if -f "../test.pl";

use experimental 'signatures';

use Test::More;


my %languages = (
    Perl        =>   {
        exe     =>   "/opt/perl/bin/perl",
        ext     =>   "pl",
    },
    JavaScript  =>   {
        exe     =>   "/usr/local/bin/node",
        ext     =>   "js",
        dir     =>   "node",
    },
    bc          =>   {
        exe     =>   "/usr/bin/bc",
        ext     =>   "bc",
        filter  =>   's/.*/main($&)/',
    },
    awk         =>   {
        exe     =>   "/usr/bin/awk",
        ext     =>   "awk",
        args    =>   ["-f"],
    },
);

my $perl_exe = $languages {Perl} {exe};

foreach my $challenge (1, 2) {
    my @inputs = <input-$challenge-*> or next;
    subtest "Challenge $challenge" => sub {
        foreach my $language (sort keys %languages) {
            my $info     =   $languages {$language};
            my $exe      =   $$info {exe};
            my $ext      =   $$info {ext};
            my $dir      =   $$info {dir}    // lc $language;
            my @args     = @{$$info {args} // []};
            my $filter   =   $$info {filter} // '';
            my $solution =  "$dir/ch-$challenge.$ext";
            next unless -r $solution;

            subtest $language => sub {
                foreach my $input (@inputs) {
                    my $output_exp = ($input =~ s/input/output/r) . ".exp";
                    my $exp        = `cat $output_exp`;

                    my $got = `$perl_exe -ple '$filter' $input |\
                               $exe @args ./$solution`;

                    s/\h+$//gm for $exp, $got;
                    is $got, $exp, $input;
                }
            }
        }
    }
}

done_testing;


__END__
