#!/bin/bash

function job_status_output()
{
# simulates output for the AutoSys command
# autorep -J job  
cat << EOF
Job Name                                                         Last Start           Last End             ST/Ex Run/Ntry Pri/Xit
________________________________________________________________ ____________________ ____________________ _____ ________ _______
trigramprd_stock_analytics_box                                       12/19/2020 08:03:05  12/19/2020 08:03:08  SU    182054/1 0
 trigramprd_stock_daily_momentum_calcs                               12/19/2020 08:03:06  12/19/2020 08:03:07  SU    182054/1 0
EOF
}


function job_status()
{
  local _job_name=$1
  echo $_job_name

  # simulate grep return
  autorep_out=$(job_status_output)
  #echo $autorep_out

  # simple grep a string test
  # str='hello world'
  # grep 'hello' <<< $str
  # echo $?

  # test string returned by the function
  #grep "RU" <<< $autorep_out
  #echo $?
  
  # regex to find job and its status
  # use word boundaries to isolate status
  regex="^\s*${_job_name}.*\bSU\b"
  echo "regex: ${regex}"
  grep  ${regex} <<< $autorep_out
  echo $?

}

# main code
job_name='trigramprd_stock_daily_momentum_calc'
box_name='trigramprd_stock_analytics_box'


job_status $job_name