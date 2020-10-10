use v6.d;

say @*ARGS.map({ /^ (.+) $0+ $/; $0 }).grep(so *).map(~*).unique;
