#!/bin/bash
#
# This script does the following:
#     - Verify lingoport configuration file contents
#     - Config Dashboard client auto_install.xml file
#     - Install Dashboard client to specific  directory
#     - Install Globalyzer Lite
#     - Scan project wite specific Lite Definition File
#     - Generate scan reports and update the Dashboard
#
#
# Author: Lili Ji
# Lingoport, Inc. (c) 2018
#

set +x

echo ""
echo "=================================================="
echo "=============== Globalyzer Scan =================="
echo "=================================================="
echo ""

export GLOBALYZER_HOME=`cd $( dirname "${BASH_SOURCE[0]}" )/../ && pwd`
echo "Current Globalyzer Configuration Values:"
echo " GLOBALYZER_DASHBOARD_URL        =  $GLOBALYZER_DASHBOARD_URL"
echo " GLOBALYZER_DASHBOARD_USERNAME   =  $GLOBALYZER_DASHBOARD_USERNAME"
echo " GLOBALYZER_SERVER               =  $GLOBALYZER_SERVER"
echo " DASHBOARD_INSTALL_PATH          =  $DASHBOARD_INSTALL_PATH"
echo " LITE_DEFINITION_FILE_PATH       =  $LITE_DEFINITION_FILE_PATH"
echo " PROJECT_NAME                    =  $PROJECT_NAME"
echo " PROJECT_SOURCE_PATH             =  $PROJECT_SOURCE_PATH"

#
# Check that all config vars are set
#
if [ -z "$(echo $GLOBALYZER_DASHBOARD_URL)" ]
then
  echo "ERROR: Please set the GLOBALYZER_DASHBOARD_URL variable in the config file and try again."
  exit 1
elif [ -z "$(echo $GLOBALYZER_DASHBOARD_USERNAME)" ]
then
  echo "ERROR: Please set the GLOBALYZER_DASHBOARD_USERNAME variable in the config file and try again."
  exit 1
elif [ -z "$(echo $GLOBALYZER_DASHBOARD_PASSWORD)" ]
then
  echo "ERROR: Please set the GLOBALYZER_DASHBOARD_PASSWORD variable in the config file and try again."
  exit 1
elif [ -z "$(echo $GLOBALYZER_USERNAME)" ]
then
  echo "ERROR: Please set the GLOBALYZER_USERNAME variable in the config file and try again."
  exit 1
elif [ -z "$(echo $GLOBALYZER_SERVER_PASSWORD)" ]
then
  echo "ERROR: Please set the GLOBALYZER_SERVER_PASSWORD variable in the config file and try again."
  exit 1
elif [ -z "$(echo $GLOBALYZER_SERVER)" ]
then
  echo "ERROR: Please set the GLOBALYZER_SERVER variable in the config file and try again."
  exit 1
elif [ -z "$(echo $DASHBOARD_INSTALL_PATH)" ]
then
  echo "ERROR: Please set the DASHBOARD_INSTALL_PATH variable in the config file and try again."
  exit 1
elif [ -z "$(echo $LITE_DEFINITION_FILE_PATH)" ]
then
  echo "ERROR: Please set the LITE_DEFINITION_FILE_PATH variable in the config file and try again."
  exit 1
elif [ -z "$(echo $PROJECT_NAME)" ]
then
  echo "ERROR: Please set the PROJECT_NAME variable in the config file and try again."
  exit 1
elif [ -z "$(echo $PROJECT_SOURCE_PATH)" ]
then
  echo "ERROR: Please set the PROJECT_SOURCE_PATH variable in the config file and try again."
  exit 1
fi


# Locate Lite Definition File

if [ -f $LITE_DEFINITION_FILE_PATH ] ; then
  echo " Lite definition file exists and is located at '$LITE_DEFINITION_FILE_PATH'"
else
  echo " Lite definition file could not be located. "
  exit 1
fi
