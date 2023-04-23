split_even_odd(l) =
{
  my(evens = select((x)->if (x % 2 == 0, 1, 0), l));
  my(odds = select((x)->if (x % 2 != 0, 1, 0), l));
  my(res = List());
  listput(res, evens);
  listput(res, odds);
  res;
}

fun_sort(l) =
{
  my(split_list = split_even_odd(l));
  my(res = List());
  my(evens = split_list[1]);
  my(odds = split_list[2]);
  listsort(evens);
  listsort(odds);
  foreach(evens, element, listput(res, element));
  foreach(odds, element, listput(res, element));
  res;
}

l1 = List();
for(i = 1, 6, listput(l1, i));
l1_sort = fun_sort(l1);
print(l1_sort);
