

Git Remote repo
---------------
git clone https://github.com/yourname/yourrepo
git remote -v - check remote repo
git remote add [name] [url]
git remote rm [name]


Git branch
----------
git branch
git branch -r - show remote branch
git branch [name] - create local branch
git checkout -b [name] - create and switch to local branch
git branch -d|-D [name]
git merge [name] - merge [name] branch to current branch

git push [remote_repo] [local_branch]:[remote_branch] - create a remote branch based on local branch
git push [remote_repo] :[remote_branch] - delete a remote branch

