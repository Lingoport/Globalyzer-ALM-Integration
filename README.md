# Globalyzer-ALM-Integration
Lingoport, Inc. &copy; 2018

Globalyzer-ALM-Integration is deployed Globalyzer as part of your ALM environment and make the adoption of Lingoport suite effortless for developers.

## Requirements
1. Download Globalzer.license file from Globalyzer server, and copy the license file to lingoport directory.

## Configuration
Configuration for Integration is intended to be as simple as possible. All that is needed for Globalyzer to be ready for use are a few environment variables, all of which should be set in the config file:

   contents of ./config/lingoport_config.sh:
   # REQUIRED CONFIG VARIABLES
   export GLOBALYZER_DASHBOARD_URL=
   export GLOBALYZER_DASHBOARD_USERNAME=
   export GLOBALYZER_DASHBOARD_PASSWORD=
   export GLOBALYZER_SERVER=
   export GLOBALYZER_USERNAME=
   export GLOBALYZER_SERVER_PASSWORD=
   export DASHBOARD_INSTALL_PATH=  # Example /var/lib/jenkins/lingoport
   export LITE_DEFINITION_FILE_PATH= # Example /var/lib/jenkins/lingoport/LiteProjectDefinitionFile.xml
   export PROJECT_NAME=
   export PROJECT_PATH=

## Running
