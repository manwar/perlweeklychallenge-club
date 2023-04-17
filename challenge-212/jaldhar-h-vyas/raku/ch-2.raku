#!/usr/bin/raku

sub invalid {
    say -1;
    exit;
}

sub MAIN(
    $size,
    *@list
) {
    unless @list.elems %% $size {
        invalid;
    }

    my %frequency;
    for @list -> $i {
        %frequency{$i}++;
    }

    my @numbers = %frequency.keys.sort({ $^a <=> $^b });
    my @results;
    my $length = @list.elems div $size;

    for 1 .. $length {
        my @group;
        my $start = 0;

        for @numbers -> $i {
            if %frequency{$i} > 0 {
                $start = $i;
                last;
            } 
        }

        if !$start {
            invalid;
        }

        for $start ..^ $start + $size -> $i {

            if %frequency{$i}:!exists || %frequency{$i} == 0 {
                invalid;
            } 

            @group.push($i);
            %frequency{$i}--;
        }

        @results.push(@group);
    }

    @results.map({ q{(} ~ @$_.join(q{, }) ~ q{)} }).join(q{, }).say;
}