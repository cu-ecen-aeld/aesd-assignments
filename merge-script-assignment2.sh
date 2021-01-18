#!/bin/sh

A2_URL=$1

if [ $# -lt 1 ]
        then
                echo "Usage: $0 [your_A2_Github_SSH_URL]"
                exit 1
        else
                echo "Using assignment2 repo at $1"
fi

# Repoint origin to the student's assignemnt 2 repo
git remote remove origin
git remote add origin ${A2_URL}

# Update tracking to the new origin
git fetch origin
git branch -u origin/master

# Reset the assignments-base remote and fetch the latest
git remote remove assignments-base
git remote add assignments-base git@github.com:cu-ecen-5013/aesd-assignments.git
git fetch assignments-base

# Merge the latest assignment2 branch to current branch
git merge -X theirs assignments-base/assignment2
git submodule update --init --recursive

# Push everything up to student's assignment 2 repo
git push origin master

