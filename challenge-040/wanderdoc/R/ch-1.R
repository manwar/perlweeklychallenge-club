# TASK #1
# Show multiple arrays content.
# You are given two or more arrays. Write a script to display values of each list at a given index.

# Help function qw:
# https://stackoverflow.com/questions/520810/does-r-have-quote-like-operators-like-perls-qw
qw <- function(x) unlist(strsplit(x, "[[:space:]]+")) # flodel in this thread.

as1<-qw("I L O V E Y O U")
as2<-qw("2 4 0 3 2 0 1 9")
as3<-qw("! ? £ $ % ^ & *")


dfs<-rbind(as1, as2, as3)


for (col in 1:ncol(dfs)) 
{
    cat(dfs[,col], "\n")
}
