#!/usr/bin/perl
use v5.38;
use InputParsing;

my $input_line_1 = <STDIN>;
my $input_line_2 = <STDIN>;
my $sorter = relative_to(InputParsing::get_ints($input_line_2, 'list2'));
my @sorted_list = sort $sorter InputParsing::get_ints($input_line_1, 'list1');
say '(' . join(', ', @sorted_list) . ')';

sub relative_to {
    my $next_rank = 0;
    my %rank = map { $_ => $next_rank++ } @_;
    return sub {
        return ($rank{$a} // $a + $next_rank) <=> ($rank{$b} // $b + $next_rank);
    };
}

__END__
