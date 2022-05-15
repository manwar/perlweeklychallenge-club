sub mood ($n) {
    ( $n, {.comb»².sum} … -> *@a {@a.repeated} ).tail
    # Could also be:      -> *@a {@a.tail ∈ @a.head(*-1)}
}

say (^Inf).grep(*.&mood == 1).head(8);
