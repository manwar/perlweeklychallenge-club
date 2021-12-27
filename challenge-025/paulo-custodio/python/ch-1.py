#!/usr/bin/python3

# Challenge 025
#
# Generate a longest sequence of the following "English Pokemon" names where
# each name starts with the last letter of previous name.

names = """
        audino bagon baltoy banette bidoof braviary bronzor carracosta
        charmeleon cresselia croagunk darmanitan deino emboar emolga
        exeggcute gabite girafarig gulpin haxorus heatmor heatran
        ivysaur jellicent jumpluff kangaskhan kricketune landorus
        ledyba loudred lumineon lunatone machamp magnezone mamoswine
        nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
        porygon2 porygonz registeel relicanth remoraid rufflet sableye
        scolipede scrafty seaking sealeo silcoon simisear snivy snorlax
        spoink starly tirtouga trapinch treecko tyrogue vigoroth
        vulpix wailord wartortle whismur wingull yamask
""".split()

def find_longest_seq(words):
    longest_path = []

    def find_longest(path):
        nonlocal longest_path, words

        # find words that can still be used
        pending = []
        for word in words:
            if word not in path:
                if len(path)==0 or path[-1][-1]==word[0]:
                    pending.append(word)
        if len(pending)==0:     # end of search
            if len(path) > len(longest_path):
                longest_path = path
        else:                   # find each possible path
            for word in pending:
                find_longest([*path, word])

    find_longest([])
    return longest_path

seq = find_longest_seq(names)
print(*seq)
