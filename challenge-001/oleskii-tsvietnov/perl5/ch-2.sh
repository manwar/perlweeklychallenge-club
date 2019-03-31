perl -E 'say join("\n", map { $_ % 3 ? ($_ % 5 ? $_ : "$_ buzz") : ($_ % 5 ? "$_ fizz" : "$_ fizz buzz")} 1..20)'

