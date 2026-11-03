module ch2;

import std::collections;

faultdef NOT_FOUND;

fn String? string_difference(String[] words)
{
  HashMap{String,int} h;
  h.tinit();
  List{String} keys;
  keys.tinit();

  foreach(w : words)
  {
    String key = "";
    for(sz j = 0; j + 1 < w.len; j++)
    {
      int d = (int)w[j+1] - (int)w[j];
      key = j == 0 ? string::tformat("%d", d) :
	      string::tformat("%s,%d", key, d);
    }
    keys.push(key);
    h.set(key,(h.get(key) ?? 0) + 1);
  }
  foreach(i,w : words)
  {
    if ((h.get(keys[i]) ?? 0) == 1) return w;
  }
  return NOT_FOUND~;
}

