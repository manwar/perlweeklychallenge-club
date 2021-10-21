#!/usr/bin/env python

# TASK #2 > Hash Join
# Submitted by: Mohammad S Anwar
# Write a script to implement Hash Join algorithm as suggested
# by wikipedia.
# 
# 1. For each tuple r in the build input R
#     1.1 Add r to the in-memory hash table
#     1.2 If the size of the hash table equals the maximum
#         in-memory size:
#         1.2.1 Scan the probe input S, and add matching join
#               tuples to the output relation
#         1.2.2 Reset the hash table, and continue scanning the
#               build input R
# 2. Do a final scan of the probe input S and add the resulting
#    join tuples to the output relation
# Example
# Input:
# 
#     @player_ages = (
#         [20, "Alex"  ],
#         [28, "Joe"   ],
#         [38, "Mike"  ],
#         [18, "Alex"  ],
#         [25, "David" ],
#         [18, "Simon" ],
#     );
# 
#     @player_names = (
#         ["Alex", "Stewart"],
#         ["Joe",  "Root"   ],
#         ["Mike", "Gatting"],
#         ["Joe",  "Blog"   ],
#         ["Alex", "Jones"  ],
#         ["Simon","Duane"  ],
#     );
# 
# Output:
# 
#     Based on index = 1 of @players_age and 
#     index = 0 of @players_name.
# 
#     20, "Alex",  "Stewart"
#     20, "Alex",  "Jones"
#     18, "Alex",  "Stewart"
#     18, "Alex",  "Jones"
#     28, "Joe",   "Root"
#     28, "Joe",   "Blog"
#     38, "Mike",  "Gatting"
#     18, "Simon", "Duane"

player_ages = [
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
]
player_ages_key = 1

player_names = [
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
]
player_names_key = 0

def format_col(s):
    if type(s) == int:
        return str(s)
    else:
        return '"'+s+'"'

def hash_join(table1, key1, table2, key2):
    build = {}
    for row in table1:
        key = row[key1]
        if key not in build:
            build[key] = []
        build[key].append(row)
    result = []
    for row_probe in table2:
        key = row_probe[key2]
        for row_build in build[key]:
            row = row_build + \
                  row_probe[:key2] + \
                  row_probe[key2+1:]
            row = [format_col(x) for x in row]
            result.append(row)
    return result

result = hash_join(player_ages, player_ages_key,
				   player_names, player_names_key)
for row in result:
    print(', '.join(row))
