#!/usr/bin/perl6

sub generate_bar_graph(%data, Bool $bylabels = False) {
    constant $SCALE = 4;

    my @labels = %data.keys.sort({ %data{$^b} <=> %data{$^a} });
    my $smallest = %data{@labels[@labels.end]};

    if ($bylabels) {
        @labels = @labels.sort;
    }

    my $width = @labels.sort({$^b.chars <=> $^a.chars}).first.chars;
    my $bar_graph = q{};

    for @labels -> $label {
        my $bar = (%data{$label} / $smallest) * $SCALE;
        if %data{$label} !%% $smallest {
            $bar += $SCALE / 2;
        }
        $bar_graph ~= sprintf("% -*s | %s\n", $width, $label, '#' x $bar);
    }

    return $bar_graph;
}


sub MAIN() {
    my %data = apple => 11, cherry => 5, banana => 2;

    print generate_bar_graph(%data);
}
