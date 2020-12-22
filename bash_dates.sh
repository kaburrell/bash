#!/bin/bash

# working with dates, and unix date command
# 12/18/20  Updated
# 12/09/20  Created

echo "loading bash_dates.sh"

# Day of the week
# numeric - 0   1   2   4   4   5   6   7
#     txt - Sun Mon Tue Wed Thu Fri Sat Sun

# numeric value of current day
DOW_NUM=$(date +%u)
# echo $DOW_NUM

# txt value of current day
DOW_TXT=$(date +"%a")
# echo $DOW_TXT

function is_weekend()
{
  local _dow

  _dow=$(date +%u)  
  if [ $_dow -eq 6 ] || [ $_dow -eq 7 ]; then
    return 0
  else
    return 1
  fi  
}

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
