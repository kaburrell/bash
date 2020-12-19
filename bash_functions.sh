#!/bin/bash

# 12/18/20  Updated
# 12/09/20  Created

# function exploration examples
# developed on-line Bash REPL
#  https://repl.it/languages/bash

# great overview
# https://linuxize.com/post/bash-functions/

# define a function
function foo()
{
    echo "foo() - SUCCESS"
}

# call a function 2 ways, don't call with parens
#  directly
#  $(function) or `function`

# writes to stdout
foo

# capture stdout in a varaible
msg=$(foo)
echo "$msg"

# pass arguments
# parameters are not specified in the function definition
# each passed parameter gets assigned $1 .. $9
function foo_with_args()
{
    echo "${FUNCNAME[0]}"
    echo "$1"
    echo "$2"
}

# call - no parens, space separated
foo_with_args "Hello" "World"

# what can bash functions do
#   execute a sequence of commands
#   write text to stdout
#   return a string .. capture stdout with $(function) 
#   return it's status code

# bash functions CAN'T return numeric values, like 10356

# what can a bash function return
# 1) a string value
# 2) a return code, an int 0 to 255
# 3) write a value to a global variable


# return a value
function today()
{
    echo $(date +"%m-%d-%y")  
}

# this is not useful if need the return value in a script
today

# get the return value
today=$(today)
echo "Today's date is $today"

# get the return code, must get it right after the call
today
echo "return code is $?"

# function can explicitly set its return code
# return an int value
# 0 is success
# 1 is failure
# all other values indicate a specific error code

# simple function
# returns a value and status code
function greeting()
{
    echo "Hello $1!"
    return 0
}

greeting "Ken"
echo "greeting() return status is $?"

function favorite_food()
{
    if [ "$1" = "pizza" ]; then
        return 0
    else
        return 1
    fi

}

# return success
favorite_food "pizza"
echo "favorite_food('pizza') return status is $?"

# return failure
favorite_food "broccoli"
echo "favorite_food('broccoli') return status is $?"

# testing the return status code from the function
#  1) examine $? immediately
#  2) if test .. if cmd | function; then

if favorite_food 'pizza'; then
    echo "everyone loves pizza"
fi

if ! favorite_food 'broccoli'; then
    echo "you don't love pizza?"
fi

# local variables
# all variables are global in bash
# use local in a function to keep variable scope

function is_weekday()
{
  local _dow
  
  _dow=$(date +%u)
  if [ $_dow -ge 1 ] && [ $_dow -le 5 ]; then
    return 0
  else 
    return 1
  fi  
}