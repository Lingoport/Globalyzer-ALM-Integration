#!/bin/bash
#
# This script does the following:
#     - Verify lingoport configuration file contents
#     - Config Dashboard client auto-install.xml file
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
source ${GLOBALYZER_HOME}/config/lingoport_config.sh

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

# Locate Globalyzer.license
LICENSE_PATH="${GLOBALYZER_HOME}/lingoport/Globalyzer.license"

if [ -f $LICENSE_PATH ] ; then
  echo " Globalyzer.license exists"
else
  echo " Globalyzer.license could not be located. Download Globalyzer.license file from Globalyzer server, and copy the license file to lingoport directory."
fi

sed -i "s|<installpath></installpath>|<installpath>$DASHBOARD_INSTALL_PATH</installpath>|" ${GLOBALYZER_HOME}/lingoport/auto-install.xml
sed -i "s|YOUR_URL|$GLOBALYZER_DASHBOARD_URL|" ${GLOBALYZER_HOME}/lingoport/auto-install.xml
sed -i "s|<username></username>|<username>$GLOBALYZER_USERNAME</username>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|<password></password>|<password>$GLOBALYZER_SERVER_PASSWORD</password>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|<server></server>|<server>$GLOBALYZER_SERVER</server>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|<project-path></project-path>|<project-path>$PROJECT_SOURCE_PATH</project-path>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|<project-name></project-name>|<project-name>$PROJECT_NAME</project-name>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|<report-path></report-path>|<report-path>${PROJECT_SOURCE_PATH}/GlobalyzerScans</report-path>|" $LITE_DEFINITION_FILE_PATH
sed -i "s|^sonar.login=.*$|sonar.login=$GLOBALYZER_DASHBOARD_USERNAME|" ${GLOBALYZER_HOME}/config/sonar-project.properties
sed -i "s|^sonar.password=.*$|sonar.password=$GLOBALYZER_DASHBOARD_PASSWORD|" ${GLOBALYZER_HOME}/config/sonar-project.properties
sed -i "s|^sonar.projectKey=.*$|sonar.projectKey=${PROJECT_NAME}:scan|" ${GLOBALYZER_HOME}/config/sonar-project.properties
sed -i "s|^sonar.projectName=.*$|sonar.projectName=$PROJECT_NAME|" ${GLOBALYZER_HOME}/config/sonar-project.properties
sed -i "s|^sonar.sources=.*$|sonar.sources=$PROJECT_SOURCE_PATH|" ${GLOBALYZER_HOME}/config/sonar-project.properties
sed -i "s|^sonar.lingoport.project.root=.*$|sonar.lingoport.project.root=$PROJECT_SOURCE_PATH|" ${GLOBALYZER_HOME}/config/sonar-project.properties


echo ""
echo "=================================================="
echo "=========Install Globalyzer Dashboard============"
echo "=================================================="
echo ""

java -jar ${GLOBALYZER_HOME}/lingoport/Lingoport_Dashboard_Client-5.6.6-Installer.jar ${GLOBALYZER_HOME}/lingoport/auto-install.xml
chmod +x ${GLOBALYZER_HOME}/lingoport/globalyzer-lite-6.1.1_11.0/install-lite.sh

echo ""
echo "=================================================="
echo "=========Install Globalyzer Lite=================="
echo "=================================================="
echo ""
bash ${GLOBALYZER_HOME}/lingoport/globalyzer-lite-6.1.1_11.0/install-lite.sh

echo ""
echo "=================================================="
echo "================Creating Scans==================="
echo "=================================================="
echo ""
java -jar ${GLOBALYZER_HOME}/lingoport/globalyzer-lite-6.1.1_11.0/globalyzer-lite.jar $LITE_DEFINITION_FILE_PATH

echo ""
echo "=================================================="
echo "================Update Dashboard=================="
echo "=================================================="
echo ""
cp ${GLOBALYZER_HOME}/config/sonar-project.properties $PROJECT_SOURCE_PATH
cd ${PROJECT_SOURCE_PATH}
${DASHBOARD_INSTALL_PATH}/sonar-scanner-2.8/bin/sonar-scanner

exit 0
