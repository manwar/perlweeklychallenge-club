maximum_product(v, k = 3) =
{
  my(max_product = v[1] * v[2] * v[3], temp_prod);
  forsubset([#v, k], s,
    temp_prod = 1;
    foreach(Vec(s), x, temp_prod *= v[x]);
    if (temp_prod > max_product, max_product = temp_prod);
  );
  max_product;
}


l1 = [3, 1, 2];
l2 = [4, 1, 3, 2];
l3 = [-1, 0, 1, 3, 1];
l4 = [-8, 2, -9, 0, -4, 3];

mp = maximum_product(l1);
if (mp == 6, print("Works for list one"), print("Did not work for list one"));

mp = maximum_product(l2);
if (mp == 24, print("Works for list two"), print("Did not work for list two"));

mp = maximum_product(l3);
if (mp == 3, print("Works for list three"), print("Did not work for list three"));

mp = maximum_product(l4);
if (mp == 216, print("Works for list four"), print("Did not work for list four"));

quit();
