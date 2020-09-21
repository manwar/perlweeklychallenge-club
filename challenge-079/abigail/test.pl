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
    Perl        =>   ["/opt/perl/bin/perl"  => 'pl', 'perl'],
    JavaScript  =>   ["/usr/local/bin/node" => 'js', 'node'],
);


foreach my $challenge (1, 2) {
    my @inputs = <input-$challenge-*> or next;
    subtest "Challenge $challenge" => sub {
        foreach my $language (sort keys %languages) {
            my ($exe, $ext, $dir) = @{$languages {$language}};
            my $solution = "$dir/ch-$challenge.$ext";
            next unless -r $solution;
            subtest $language => sub {
                foreach my $input (@inputs) {
                    my $output_exp = ($input =~ s/input/output/r) . ".exp";
                    my $exp        = `cat $output_exp`;
                    my $got        = `$exe ./$solution < $input`;
                    s/\h+$//gm for $exp, $got;
                    is $got, $exp, $input;
                }
            }
        }
    }
}

done_testing;


__END__
