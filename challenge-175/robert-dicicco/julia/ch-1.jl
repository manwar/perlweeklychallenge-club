#!julia.exe

using Dates

# AUTHOR: Robert DiCicco
# DATE: 2022=07-26
# Challenge 175 Last Sunday ( Julia )

function checkArgs(args)
  global year

  try
    year = parse(Int64, args[1])
  catch
    println("Error: Tear must be an integer >= 1900")
    exit(0)
  finally
    if year < 1900
      println("Error: Year must be >= 1900")
      exit(0)
    else
      main(year)
    end
  end
end

function LastSunday( yr, mth)
  td = Dates.Date(yr,mth,1)
  ld = Dates.lastdayofmonth(td)
  wd = Dates.dayofweek(ld)

  if wd == 7
    println(ld)
  else
    println(ld - Dates.Day(wd))
  end
end

function main(year)
  for mth in 1:12
    LastSunday(year,mth)
  end
end

checkArgs(ARGS)
