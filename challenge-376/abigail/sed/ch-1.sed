#!/opt/homebrew/bin/gsed


s/^([aceg][1357]|[bdfh][2468]) ([aceg][1357]|[bdfh][2468])$/true/;  t  # B/B
s/^([aceg][2468]|[bdfh][1357]) ([aceg][2468]|[bdfh][1357])$/true/;  t  # W/W
s/^([aceg][1357]|[bdfh][2468]) ([aceg][2468]|[bdfh][1357])$/false/; t  # B/W
s/^([aceg][2468]|[bdfh][1357]) ([aceg][1357]|[bdfh][2468])$/false/; t  # W/B
q1  # Does not parse
