use v6;

sub generate_chart (%data) {
    my ($max, $min);
    for keys %data -> $key {
        ($max, $min) = (%data{$key}, %data{$key}) unless defined $max;
        $max = %data{$key} if %data{$key} > $max;
        $min = %data{$key} if %data{$key} < $min;
    }
    my $scale_factor = 10 / ($max - $min);
    for sort { %data{$^b} <=> %data{$^a} }, keys %data -> $key {
        printf "%15s | %s\n", $key, "#" x (%data{$key} * $scale_factor);
    }
}
my $data = { apple => 3, cherry => 6, banana => 1, pear => 4 };
generate_chart $data;
