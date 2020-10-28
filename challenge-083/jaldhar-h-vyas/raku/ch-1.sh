perl6 -e '$_ = @*ARGS.join(q{ }); s/^ .+? \s+ (.+) \s+ .+? $/$0.subst(/\s/, q{}, :g)/; .chars.say;' $@
