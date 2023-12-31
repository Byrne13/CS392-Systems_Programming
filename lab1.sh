#!/bin/bash
# interface.sh
# Credit: https://www.computerhope.com/unix/bash/getopts.htm

#Jack Byrne

NAME=""                                   # Name of person to greet.
TIMES=1                                   # Number of greetings to give.
optionb=0
usage() {                                 # Function: Print a help message.
  echo "Usage: $0 [ -n NAME ] [ -t TIMES ]" 1>&2   # Redirect stdout to stderr
}
exit_abnormal() {                         # Function: Exit with error.
  usage
  exit 1
}

while getopts ":n:t:b:" options; do         # Loop: Get the next option;
                                          # use silent error checking;
                                          # options n and t take arguments.
  case "${options}" in                    #
    n)                                    # If the option is n,
      NAME=${OPTARG}                      # set $NAME to specified value.
      ;;
    t)                                    # If the option is t,
      TIMES=${OPTARG}                     # Set $TIMES to specified value.
      re_isanum='^[0-9]+$'                # Regex: match whole numbers only
      if ! [[ $TIMES =~ $re_isanum ]] ; then   # if $TIMES not whole:
        echo "Error: TIMES must be a positive, whole number."
        exit_abnormal
        exit 1
      elif [ $TIMES -eq "0" ]; then       # If it's zero:
        echo "Error: TIMES must be greater than zero."
        exit_abnormal                     # Exit abnormally.
      elif [ $TIMES -gt "20" ]; then
        $TIMES=20
      fi
      ;;
    b)
      optionb=1
      ;;
    :)                                    # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                       # Exit abnormally.
      ;;
    *)                                    # If unknown (any other) option:
      exit_abnormal                       # Exit abnormally.
      ;;
  esac
done

if [optionb -eq 1]  then
  STRING="Bye"
elif [ "$NAME" = "" ]; then                 # If $NAME is an empty string,
  STRING="Hi!"                            # our greeting is just "Hi!"
else                                      # Otherwise,
  STRING="Hi, $NAME!"                     # it is "Hi, (name)!"
fi
COUNT=1                                   # A counter.
while [ $COUNT -le $TIMES ]; do           # While counter is less than
                                          # or equal to $TIMES,
  echo $STRING                            # print a greeting,
  let COUNT+=1                            # then increment the counter.
done
exit 0                                    # Exit normally.
