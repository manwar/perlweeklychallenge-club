# Task 2 of the Weekly Challenge 336
# https://theweeklychallenge.org/blog/perl-weekly-challenge-336/#TASK2

say score "5", "2", "C", "D", "+"; # 30
say score "5", "-2", "4", "C", "D", "9", "+", "+"; # 27
say score "7", "D", "D", "C", "+", "3"; # 45
say score "-5", "-10", "+", "D", "C", "+"; # -55
say score "3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"; # 128

sub score(*@list) {
    my @stack;

    for @list -> $item {
        given $item {
            when /\d/ {@stack.push($item)}
            when 'C'  {@stack.pop if @stack}
            when 'D'  {@stack.push(@stack[*-1] * 2) if @stack}
            when '+'  {@stack.push((@stack[*-1] // 0) + (@stack[*-2] // 0))}
        }
    }

    return [+] @stack;
}
