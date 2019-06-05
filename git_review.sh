

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

Git patch
---------
git format-patch xxxxx
git am xxx

git hub workflow
----------------

git push [remote_repo] --force HEAD:[remote_branch] - update git review code

wget --output-document=fix.patch https://github.com/avocado-framework/avocado-vt/pull/1796.patch

code sytle check
----------------

inspekt checkall --disable-style E501,E265,W601,W605,E402,E722,E741 --no-license-check
