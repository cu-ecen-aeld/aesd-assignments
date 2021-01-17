#1/bin/sh

A2_URL=$1

if [ $# -lt 1 ]
	then
		echo "Missing A2 URL"
                echo "Usage: [./merge-script-assignemtn2.sh] [your_A2_Github_SSH_URL]"
                exit 1
	else
                echo "A2 URL USED"
fi

git remote remove origin

git remote add origin ${A2_URL}

git remote add assignments-base git@github.com:cu-ecen-5013/aesd-assignments.git

git fetch assignments-base

git merge -X theirs assignments-base/assignment2

git checkout theirs assignments-base/assignment2

git submodule update --init --recursive

git push origin master
