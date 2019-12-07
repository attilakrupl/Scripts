# Scripts
This repository contains my scipts I'm using while developing at home or at work.

Feel free to use/amend these yourself. 

## git_bulk.ps1
I've created this script to run the same git command on multiple git repositories.
Sometimes I want to have the oldest version of the master at the same time at work, and usually I'm going through a dozen+ repos manually to run git pull, or git branch. This script makes it quicker and easier. Note: I don't suggest to use this cmdlet to for commits or pushes. Those need extra effort on each branch, but it comes very handy when it's about acquiring information, or running commands which are the same for each branch. 

## copy_dlls.ps1
This script can be utilized to copy shared libraries into desired folder. 
