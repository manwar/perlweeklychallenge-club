group_hero(Group, GroupHero):-
    findall(Hero, (
        sublist(SubList, Group),
        max_list(SubList, Maximum),
        min_list(SubList, Minimum),
        Hero #= Maximum**2 * Minimum
    ), Heroes),
    sum_list(Heroes, GroupHero).
    