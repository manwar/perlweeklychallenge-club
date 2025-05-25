sol::""
dummy::""
inp:"ABC-D-E-F"
i:3
cool:(|"-"\inp)[&0<#'|"-"\inp]
first:(|cool)[0]
cool:1_|cool
nooutput: {dummy::dummy,x;$[(#dummy)<i;;[sol::sol,"-",dummy;dummy::""]]}'cool
first,sol


sol::""
dummy::""
inp:"A-BC-D-E"
i:2
cool:(|"-"\inp)[&0<#'|"-"\inp]
first:(|cool)[0]
cool:1_|cool
nooutput: {dummy::dummy,x;$[(#dummy)<i;;[sol::sol,"-",dummy;dummy::""]]}'cool
first,sol

sol::""
dummy::""
i:4
cool:(|"-"\"-A-B-CD-E")[&0<#'|"-"\"-A-B-CD-E"]
nooutput: {dummy::dummy,x;$[(#dummy)<i;;[sol::sol,|dummy;dummy::""]]}'cool
dummy,"-",sol
