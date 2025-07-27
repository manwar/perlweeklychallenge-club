let rec sth4 (x,y,i) = if i <= Seq.length(x)-2 then
                            // Update and switch at index i and i+1   
                            let updated = Seq.toArray x |> Array.updateAt i (x:string).[i+1] |>  Array.updateAt (i+1) (x:string).[i]            
                            // compare arrays 
                            let erg = updated = (Seq.toArray y)
                            if erg= true then printf "%b\n" erg else sth4 (x,y,(i+1))          
                       // if i too big, return "false"
                       else printf "%s\n" "false"
                        

sth4 ("fuck","fcuk",0)
sth4 ("love","love",0)
sth4 ("fodo","food",0)
sth4 ("feed","feed",0)
