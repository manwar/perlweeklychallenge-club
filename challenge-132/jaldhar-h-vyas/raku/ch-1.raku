#!/usr/bin/raku

sub MAIN() {
    my $birthday = Date.new('1971-03-22');
    my $today = Date.today;
    my $diff = $today - $birthday;

    my $past = $birthday - $diff;
    my $future = $today + $diff;
    say $past.yyyy-mm-dd(q{/}), q{, }, $future.yyyy-mm-dd(q{/});
}