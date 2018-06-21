# Globalyzer-ALM-Integration
Lingoport, Inc. &copy; 2018

Globalyzer-ALM-Integration is deployed Globalyzer as part of your ALM environment and make the adoption of Lingoport suite effortless for developers. It will create scan reports using your selected Lite definition file and update scan results to your Dashboard.

## Requirements
1. Clone this repository to your environment
2. Modify/Add Lite definition file examples under LiteDefinitionFile directory.

     For full configuration instructions, checkout the [Lite Project Definition Files][wiki]

[wiki]: https://globalyzer.lingoport.net/gzserver/help/referenceLite/project-definition-file-overview.html

3. If you will use local rule sets, please download Globalzer.license file from Globalyzer server, and copy the license file to lingoport directory.
4. Fill in all parameters in the config/lingoport_config.sh file.

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
    export PROJECT_SOURCE_PATH=

## Running

The easiest way to install, verify, and run Globalyzer is by invoking the globalyzer_scan.sh script. This script can be found
in the `scripts` directory.

    bash scripts/globalyzer_scan.sh
