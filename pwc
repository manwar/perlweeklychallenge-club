MY_PWC_DIR_NAME=${PWC_DIR_NAME}

MY_PWC_ROOT=${PWC_ROOT}

MY_PWC_LANG=${PWC_LANG}

MY_PWC_GIT_USER=${PWC_GIT_USER}

function pwc() {

  if [ $# -ne 0 ]

  then

    if ! [[ "$1" =~ ^[0-9]+$ ]]

    then

      echo

      echo "  "Usage: pwc {challenge number}? - must be positive integer
      echo

      echo "  "Omitting the challenge number will take you to the most recent challenge.
      echo

      echo "  "Created by James Smith.
      echo

      return

    fi

  fi

  ROOT_DIR=$MY_PWC_ROOT/perlweeklychallenge-club

  if [ ! -d "$ROOT_DIR" ]

  then

    echo

    echo "  "You will need a git checkout of the challenge repo here!

    echo

    echo "  "cd $MY_PWC_ROOT

    echo "  git clone git@github.com:MY_PWC_GIT_USER/perlweeklychallenge-club.git"

    echo

    return

  fi

  cd $ROOT_DIR

  git fetch upstream

  git merge upstream/master --ff-only

  git pull --no-rebase

  if [ $# -eq 0 ]

  then

    CHALLENGE_NO=$((10#`ls -1d /www/baggy/perlweeklychallenge-club/challenge-* | tail -1 | cut -d '-' -f 3`))

  else

    CHALLENGE_NO=$1

  fi

  DIR=$ROOT_DIR/challenge-`printf %03d $CHALLENGE_NO`/$MY_PWC_DIR_NAME

  if [ ! -d "$DIR" ]

  then

    echo

    echo "  "That challenge [$CHALLENGE_NO] does not exist

    echo

    return

  fi

  if [ ! -d "$DIR/$MY_PWC_LANG" ]

  then

    mkdir $DIR/$MY_PWC_LANG

    cd $DIR

    git add $MY_PWC_LANG

  fi

  cd $DIR/$MY_PWC_LANG

}
