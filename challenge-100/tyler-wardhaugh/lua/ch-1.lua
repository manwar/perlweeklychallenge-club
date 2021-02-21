#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = '05:15pm'
t1.time_12h_pat = '^%s*(%d%d):(%d%d)%s*([ap]?%.?m%.?)%s*$'
t1.time_24h_pat = '^%s*(%d%d):(%d%d)%s*$'


function t1.fun_time(timestr)
  timestr = string.lower(timestr)
  local new_timestr

  local hh, mm, ampm = timestr:match(t1.time_12h_pat)
  if hh then
    hh = tonumber(hh)
    mm = tonumber(mm)
    if ampm:find('a') then
      if hh == 12 then hh = 0 end
    else
      if hh < 12 then hh = hh + 12 end
    end
    new_timestr = string.format('%02d:%02d', hh, mm)
  else
    hh, mm = timestr:match(t1.time_24h_pat)
    hh = tonumber(hh)
    mm = tonumber(mm)
    ampm = 'AM'
    if hh == 0 then
      hh = 12
      ampm = 'AM'
    elseif hh == 12 then
      ampm = 'PM'
    elseif hh > 12 then
      ampm = 'PM'
      hh = hh - 12
    end
    new_timestr = string.format('%02d:%02d%s', hh, mm, ampm)
  end
  return new_timestr
end

function t1.run(args)
  local timestr
  if #args > 0 then
    timestr = args[1]
  else
    timestr = t1.DEFAULT_INPUT
  end

  print(t1.fun_time(timestr))
end

return t1
