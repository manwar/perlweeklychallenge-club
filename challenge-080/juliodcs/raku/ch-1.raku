sub min-slot {
    for @*ARGS>>.Int.grep(* > 0).sort.unique.pairs {
        return .key.succ if .key.succ != .value;
    }
    return 0 # no empty *slot*
}

say 'Min slot: ' ~ min-slot;
