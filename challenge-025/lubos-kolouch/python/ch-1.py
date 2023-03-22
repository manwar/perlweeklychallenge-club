#!/usr/bin/env python3

names = [
    "audino",
    "bagon",
    "baltoy",
    "banette",
    "bidoof",
    "braviary",
    "bronzor",
    "carracosta",
    "charmeleon",
    "cresselia",
    "croagunk",
    "darmanitan",
    "deino",
    "emboar",
    "emolga",
    "exeggcute",
    "gabite",
    "girafarig",
    "gulpin",
    "haxorus",
    "heatmor",
    "heatran",
    "ivysaur",
    "jellicent",
    "jumpluff",
    "kangaskhan",
    "kricketune",
    "landorus",
    "ledyba",
    "loudred",
    "lumineon",
    "lunatone",
    "machamp",
    "magnezone",
    "mamoswine",
    "nosepass",
    "petilil",
    "pidgeotto",
    "pikachu",
    "pinsir",
    "poliwrath",
    "poochyena",
    "porygon2",
    "porygonz",
    "registeel",
    "relicanth",
    "remoraid",
    "rufflet",
    "sableye",
    "scolipede",
    "scrafty",
    "seaking",
    "sealeo",
    "silcoon",
    "simisear",
    "snivy",
    "snorlax",
    "spoink",
    "starly",
    "tirtouga",
    "trapinch",
    "treecko",
    "tyrogue",
    "vigoroth",
    "vulpix",
    "wailord",
    "wartortle",
    "whismur",
    "wingull",
    "yamask",
]

used = {}
sequence = []

for name in names:
    if name in used:
        continue

    current = name
    temp = [current]
    temp_used = used.copy()
    temp_used[current] = True

    while True:
        found = False
        for next_name in names:
            if next_name in temp_used:
                continue

            if current[-1] == next_name[0]:
                current = next_name
                temp.append(current)
                temp_used[current] = True
                found = True
                break

        if not found:
            break

    if len(temp) > len(sequence):
        sequence = temp

    used = temp_used

print(" -> ".join(sequence))
