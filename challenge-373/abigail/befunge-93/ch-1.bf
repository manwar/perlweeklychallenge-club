> > 1 0 45*0+p 1 0 45*1+p ">" 6 6p  v                     Init
^   v < < < < < < < < < < < < < < < < p6 6 "v" $  < <     Switch
^   > ~:1+!#@_ :" "-!#v_ :"."-!#v_ :55+-!#v_ :";"-!#^_v   Parse line
^   ^ < < < < < < $ < < < < < < <                     v   Skip spaces and dots
^ v   < < < < < < $ < < < < < < < < < < < <           v   End of line
^ v ^ v < < < < < < < < < < < < < < < < < < < < < < < <
^ v ^   0 45*0+g 45*0+p 0 45*0+g 1+ 0 45*0+p  v           Store chars before ;
^ v ^ > 0 45*1+g 45*1+p 0 45*1+g 1+ 0 45*1+p  v           Store chars after  ;
^ v ^ < < < < < < < < < < < < < < < < < < < < <
^ > > 0 45*0+g 0 45*1+g -#v_ 0 45*0+g > v                 Compare length
^                         > > > > > > >   v
^   v < < < < < < < < < < < < < < < < < < v
^   > 1-: !#v_ ::45*0+g \ 45*1+g - #v_  ^ v               Compare strings
^           > > > > > > > > v       v     v
^ < $ ,+55 ,,,, < <  "true" <       v     v
                ^ , "false" < < < < < < < <
