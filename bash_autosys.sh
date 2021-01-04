#!/bin/bash

# AutoSys functions for bash scripts
# 01/03/20  Updated
# 01/03/20  Created


function is_success_autosys()
{
   local _job_name=$1
   local _status="SU"

   _check_autosys_status ${_job_name} ${_status}
   return $?
}


function is_failure_autosys()
{
   local _job_name=$1
   local _status="FA"

   _check_autosys_status ${_job_name} ${_status}
   return $?
}


function _check_autosys_status()
{
   local _job_name=$1
   local _status=$2
   local _regex="^\s*${_job_name}.*\b${_status}\b"

   echo "${FUNCNAME[0]}"
   echo "job name: ${_job_name}"
   echo "status: ${_status}"
   echo "regex ${_regex}"

   if autorep -J ${_job_name} | grep -q ${_regex}; then
      return 0
   else
      echo "Error code $?"
      return 1
   fi
}



# -----------------------------

# testing
# simulate AutoSys output if don't have Autosys client

function job_status_output()
{
# use for testing
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

  # simulate grep return
  autorep_out=$(job_status_output)
  
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
job_status $box_name

# Example
# using is_success_autosys() when AutoSys client is installed
# test job for SUCCESS
JOB_NAME="some_autosys_job_name"
if is_success_autosys $JOB_NAME; then
    echo "${JOB_NAME} at SUCCESS"
else
    echo "${JOB_NAME} not at success"
fi


