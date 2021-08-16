# The Weekly Challenge Club

This is the central repository for the members of [**The Weekly Challenge**](https://theweeklychallenge.org). The members can submit the solution to the challenge each week in their favourite programming languages, although the preferred languages are **Perl** and **Raku**.

## EZPWC - Easy Perl Weekly Challenges Script

**Saif Ahmed**, respected member of **Team PWC**, created the tool **[EZPWC](https://github.com/saiftynet/EZPWC)** to help you with contributing to the weekly challenge. We highly recommend you to give it a try. If you have any questions/suggestions, then please raise an issue against the tool.

## How to contribute?
Just submit Pull Request with your solutions.

First find out the latest challenge folder, more likely the highest numbered folder is the latest challenge folder e.g. challenge-002. If you are an existing member, you would probably find a folder by your name. For example, if your name is **"Joe Blog"** then there would be a folder called **"joe-blog"**. Under your named folder, you would find a file **README**. Depending on your choice of language, you should create a folder here e.g. **perl** for **Perl** and **raku** for **Raku**. Inside each of these folders you can save your solutions. If it is perl script for **Task #1** then call it **ch-1.pl**. Similarly if it is perl script for **Task #2** then call it **ch-2.pl**. For **Raku** solutions, call it **ch-1.raku** and **ch-2.raku** respectively. And if you are writing one-liner then call it **ch-1.sh** or **ch-2.sh**. If you are contributing for the first time, please create your named folder as described above. Also let us know what name you would like us to use?

In case you have created a blog about your solutions, then create a file called **blog.txt** and add the link to it. In case you have more than one blog then create another file called **blog1.txt** and add your link there.

## Step-by-step instructions
Let us assume you want to submit solutions for **Challenge 002** and your Github user name is **joe-blog**.

1. If you are submitting the solution for the first time then you have to **Fork** the repository **https://github.com/manwar/perlweeklychallenge-club** by clicking the **"Fork"** button in the top right corner and should have repository e.g. **https://github.com/joe-blog/perlweeklychallenge-club**.

2. Go to your favourite terminal and **clone** your repository.
   ```
   $ git clone https://github.com/joe-blog/perlweeklychallenge-club
   ```

3. Create a new branch for the solution 
   ```
   $ cd perlweeklychallenge-club
   $ git checkout -b new-branch
   ```

3. Go to the **Challenge 002** folder.
   ```
   $ cd challenge-002
   ```

4. If you find a folder with your name in the current folder then skip to next step otherwise create a new folder. 
   ```
   $ mkdir joe-blog
   ```

5. Change into your named folder.
   ```
   $ cd joe-blog
   ```

6. If you just created the folder then you should add a file **README** and add a line **Solution by Joe Blog** otherwise skip to next step.

7. If you want to submit **Perl 5** solutions then you should create a folder **perl** (if not already created). Similarly if you want to submit **Raku** solutions then you should create a folder **raku** (if not already created).

8. Change into your relevant folder depending on your choice **cd perl** or **cd raku**.

9. Now you are ready to add your solutions. If it is for the first challenge then create a file named **ch-1.pl** or **ch-1.raku** or **ch-1.sh**. Similarly, if it is for the second challenge then create a file named **ch-2.pl** or **ch-2.raku** or **ch-2.sh**.

10. Once you are happy with your solutions, you should **add** it to the repository. First go back to **root** of the repository and then fire the command 
    ```
    $ git add challenge-002/joe-blog
    ```

11. Commit your changes.
    ```
    $ git commit
    ```

12. Push your changes.
    ```
    $ git push -u origin new-branch
    ```

13. Now go to your fork repository in GitHub web portal **https://github.com/joe-blog/perlweeklychallenge-club**

14. You should see a button to submit **Pull Request**.

## How to add new solution when you already have the forked repository?

Let us assume you already have the repository forked. If this is the first time you are using the same forked repository for submitting subsequent challenges solution. I also assume your GitHub user name is **joe-blog**.

1. Checkout out the **master** branch first.
   ```
   $ git checkout master
   ```

2. Check if you have setup **upstream**.
   ```
   $ git remote -v
   ```

   You should see something similar:
   ```
   origin  https://github.com/joe-blog/perlweeklychallenge-club (fetch)
   origin  https://github.com/joe-blog/perlweeklychallenge-club (push)
   upstream        https://github.com/manwar/perlweeklychallenge-club (fetch)
   upstream        https://github.com/manwar/perlweeklychallenge-club (push)
   ```

   If you don't see **upstream** as above then you need to setup your **upstream** like below:

   ```
   $ git remote add upstream https://github.com/manwar/perlweeklychallenge-club
   ```

   Check if you have everything setup correctly.

   ```
   $ git remote -v
   ```

   If you see similar output as above then you have setup **upstream** correctly.
   You only need to do it **once**.

3. Now we need to **fetch** latest changes from the **upstream**.

   ```
   $ git fetch upstream
   ```

4. We will now merge the changes into your local **master** branch.

   ```
   $ git merge upstream/master --ff-only
   ```

5. Then push your **master** changes back to the repository.

   ```
   $ git push -u origin master
   ```

6. Now it is time create new branch for new challenge

   ```
   $ git checkout -b branch-for-challenge-005
   ```

7. Once you have a new **branch** ready, you can start adding your solutions or blog information.

   ```
   $ cd challenge-005/joe-blog

   $ echo "URL to the blog" > blog.txt

   $ mkdir perl

   $ cd perl

   Add script like ch-1.pl or ch-2.pl or ch-1.sh or ch-2.sh

   $ mkdir raku

   $ cd raku

   Add script like ch-1.raku or ch-2.raku or ch-1.sh or ch-2.sh
   ```

   Test your script now.

8. Commit your changes.

   ```
   $ git add challenge-005/joe-blog

   $ git commit
   ```

9. Now push the newly created branch **branch-for-challenge-005**

   ```
   $ git push -u origin branch-for-challenge-005
   ```

10. Time to submit your changes as **Pull Request**.

    Go to GitHub web profile

    https://github.com/joe-blog/perlweeklychallenge-club

    You should see button to create **Pull Request**.

`Dave Cross` wrote a very detailed [**blog post**](https://dev.to/davorg/learn-enough-git-and-github-to-take-part-in-the-perl-weekly-challenge-gpm) with regard to the exposure of `git` and `GitHub` needed to start contributing. Highly Recommended.

If you have any trouble with the above instructions then please get in touch with me anytime <mohammad.anwar@yahoo.com>.
