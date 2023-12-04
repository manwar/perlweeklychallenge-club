#!/usr/bin/env python

def sortLanguage(lang, popularity):
    # build a dict associating popularity with lang
    lang_pop = {
        v: popularity[i] for i,v in enumerate(lang)
    }
    sorted_list = sorted(lang,
                         # sort by lang_pop, not lang
                         key=lambda x: (lang_pop[x]))
    return sorted_list

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def quoted_comma_join(arr):
    return "'" + "', '".join(arr) + "'"

def solution(lang, popularity):
    print(f'Input: @lang = ({quoted_comma_join(lang)})')
    print(f'       @popularity = ({comma_join(popularity)})')
    output = sortLanguage(lang, popularity)
    print(f'Output: ({quoted_comma_join(output)})')

print('Example 1:')
solution(['perl', 'c', 'python'], [2, 1, 3])

print('\nExample 2:')
solution(['c++', 'haskell', 'java'], [1, 3, 2])
