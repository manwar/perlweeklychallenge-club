penny_pile([], 0, _MINIMUM).
penny_pile([PILE_HEAD|PILE_TAIL], SUM, MINIMUM) :- between(MINIMUM, SUM, PILE_HEAD), SUM_TAIL is SUM - PILE_HEAD, penny_pile(PILE_TAIL, SUM_TAIL, PILE_HEAD).