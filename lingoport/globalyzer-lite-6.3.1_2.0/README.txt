This README file explains how to install and run Globalyzer Lite.  It also
includes information on Project Definition XML Files. Please see our online
help for Globalyzer Lite at
https://www.globalyzer.com/gzserver/help/referenceLite/toc.html
for more information.

Table of Contents:
* How to install Globalyzer Lite
* How to run Globalyzer Lite
* Using Globalyzer Lite from an IDE
* The .globalyzerrc Configuration File
* Project Definition Files
  * Project Definition File Overview
  * Login information
  * Project Information
  * Report Information
  * List of Scans to Perform
  * Project Definition XML Templates


# How to install Globalyzer Lite

For more detail on installing Globalyzer Lite see the web site:
https://www.globalyzer.com/gzserver/help/referenceLite/globalyzer-lite-IDE-usage.html

Globalyzer Lite is packaged as an archive file. After unzipping,
Globalyzer Lite needs to be installed on your machine:

  * If on Windows, open a Command Prompt and run: install-lite.bat
  * If on Linux or Mac OSX, open a console window and run: ./install-lite.sh

  * If planning to use Globalyzer Lite from **Eclipse**, you will probably want
    to install the ClickableConsole plug-in. Details for doing so are in
    the section Using Globalyzer Lite from an IDE.


# How to run Globalyzer Lite

After unzipping, installing, and defining a Globalyzer Project Definition file,
call globalyzer-lite.jar and pass in an XML file:

java -jar globalyzer-lite.jar AProjectDefinitionFile.xml

Globalyzer Lite supports the following command line options:

    -f <string>
            Location of project definition file. (Option prefix optional)
            
    -l,--license <string>
            Optional. Set custom location for the Globalyzer.license file.
            Default location on Windows: C:\Lingoport
            Default location on Linux: $HOME/lingoport
            Default location on Mac: /Applications/Lingoport
            A Globalyzer.license file is necessary when using local rule sets.

    -co,--console-output <string>
            Method for printing the generated scan report output to the console.
            (See "##Report Information" for more info.)

            Requires a report type matching: [ScanDetailedXML, ScanDetailedCSV]

            Valid input:
            - [gnu, gnu_std, gnu-std]
              - Use For Intellij IDEA, Eclipse w/ ClickableConsole plugin.
            - [vs, visual_studio, visual-studio]
            - [ecd, eclipse-default, eclipse_default]
              - For Eclipse use if ClickableConsole plugin is not installed
            - [none]

    -db,--debug
          Print contents of all calls to the Globalyzer API.

    -ddl,--data-dictionary-location <string>
            Optional. Set custom location for Globalyzer Lite to write its
            internal dictionary information to. Default is
            '$HOME/.globalyzer'.

    -fwd,--filter-with-dictionary <string>
            Whether or not to filter against a dictionary. By default, a
            dictionary will be used. (Must be set to 'true' or 'false')

    -h,--help
            Show this help message.

    -pp,--project-path <string>
            Path to the project that will be scanned.

    -rp,--report-path <string>
            Path to write Globalyzer reports to.

    -si,--scan-items <string>
            Specify which files/directories to scan. (Overrides preferences for
            all scans). With this option, scan items specified in the project
            definition file are ignored.

            Place items together, separated by commas, like so:
            'aFileName,aDirectoryPath,...'

    -st,--scan-timeout <string>
            Timeout threshold, in seconds, for each file scanned. out. Defaults
            to 120 (2 minutes). Max 300 (5 minutes). SQL files are typically the
            slowest to scan.

    -vn,--version
            Display version number.


# Using Globalyzer Lite from an IDE

For a full tutorial on Using Globalyzer Lite from an IDE, view the help page on
the Lingoport Server.

https://www.globalyzer.com/gzserver/help/referenceLite/globalyzer-lite-IDE-usage.html

This page includes step by step instructions for setting up Globalyzer Lite
within Visual Studio, Eclipse, and IntelliJ IDEA.

## The following is a brief overview of the relevant steps:

1. Ensure that your IDE can run External Tools. External Tools are often
   located in menu systems under Tools -> External Tools. But they may be
   elsewhere, or a part of a Settings menu.

   * *Eclipse*, *IntelliJ*, and *Visual Studio* all support this.
       * *IntelliJ* creates external tools from the Settings menu.

2. Ensure that your IDE provides macros/variables for these tools to use.
   For example, Visual Studio provides the $(ItemPath) variable. This variable
   expands to the path to the currently selected resource.

   * *Eclipse*, *Intellij,* and *Visual Studio* all support this.

3. Locate Java on your system. On Linux, enter `which java` on the command
   line. On Windows, look under:

   `C:\Program Files\Java\<Your (jre|jdk) Version Here>\bin\java.exe`

---
  **ECLIPSE SPECIFIC**

    Out of the box, Eclipse only enables jumping from the console to Java files.
    These files must be present in the workspace. Furthermore, conflicts will
    occur if the same file is present in multiple locations in the workspace.

    Globalyzer Lite comes with a bundled plugin, **ClickableConsole**, which
    enables links using absolute file paths. Linked files may be of any file
    type, and do not need to be present in the workspace. To install the
    plug-in:

    1. Determine the location of your Eclipse installation directory.
        * On **Windows**, this may vary significantly, and was determined at the
          time you installed Eclipse.
        * On **Linux**, a good place to check is `/usr/lib/eclipse`.

    2. The Eclipse folder should contain a `dropins` directory. `dropins` may
       contain a `plugins` directory. If it does not, create `dropins/plugins`
       now.

       (This is optional. you do not strictly need to use a `plugins`
        directory. Any location inside `dropins` will work.)

    3. Copy **EclipseClickableConsole.jar** from the Globalyzer Lite
       installation location to:
       `<location_of_Eclipse_folder>/eclipse/dropins/plugins`.

       ClickableConsole should be enabled the next time Eclipse (re)starts.

    Troubleshooting ClickableConsole:

    (Don't worry about this until after you've installed and ran at least one
     tool generating console output)

      * Confirm that you are using the correct console output style.
        ClickableConsole recognizes output from the "gnu" format.
        It does not recognize "eclipse-default" output.

      * Confirm that Eclipse recognizes ClickableConsole as installed. Go to
        `Help -> Installation Details -> Plug-ins` and search for a plugin
        named "ClickableConsole".

        If ClickableConsole is not recognized, try adding "-clean" to
        `<location_of_Eclipse_folder>/eclipse/eclipse.ini` as a new line
        at the top of the file. Then restart Eclipse.

        If you're feeling cautious, you may also want to double check that
        EclipseClickableConsolePlugin.jar is present somewhere in the `dropins`
        directory. (It does not need to be placed under `plugins`, although this
        is suggested.)

  **END ECLIPSE SPECIFIC**

---


Finally, create an external tool matching the following template:

* Name: GlobalyzerLite-ToolName
    * Recommended tool: (ScanSelected)

* Tool Location: The path to the Java command on your system.
    * You'll be using Java to run the Globalyzer Lite jar file.

* Working Directory: $(ProjectDir), ${project_loc}, $ProjectFileDir$,...
    * These variables are from Visual Studio, Eclipse and IntelliJ IDEA,
      Other IDEs may have their own versions.

* Arguments: (Note: '\_' is markdown syntax for '_')
  `-jar "/Location of Globalyzer Lite on your system/globalyzer-lite-6.3/globalyzer-lite.jar"
  -f lingoport/LiteProjectDefinition.xml
  -- report-path Globalyzer_Lite_Reports
  // For:           Eclipse                   Visual Studio   Intellij
  --project-path   "${project_loc}           |$(ProjectDir) |$ProjectFileDir$"
  --scan-items     "${selected_resource_loc} |$(ItemPath)   |$FileRelativeDir$"
  --console-output "eclipse-default          |visual_studio |gnu..."
  //                ^ 'gnu' if eclipse w/ ClickableConsole     ^ for Intellij`

    * **scan-items** may be:
        * Visual Studio: $(ItemPath)
        * Eclipse:       ${selected_resource_loc}
        * IntelliJ IDEA: $FileRelativeDir$

    * Use a **console output style** to see the output in your IDE's console
      after scanning. Depending on IDE settings, your IDE may support jumping
      directly to issues from console output as formatted in one of the options.

        * Note: using this feature in **IntelliJ** requires creating an
          "Output Filter" for your tool with the following in the
          "Regular expression to match output" field: "$FILE_NAME$:$LINE$".
          See "Output Filters..." in the "Edit Tool" dialog.

    * **Warning!**
      Keep quotes around variables specifying locations. Without quotes, if a
      location contained a space, then it would look like two arguments to
      Globalyzer Lite.
      E.g. ~C:\A Directory~ would be read as ~C:\A~, ~Directory~,
           while "C:\A Directory" would be read correctly


# The .globalyzerrc Configuration File.

If desired, you may place a file named ".globalyzerrc" in your home directory.
Globalyzer Lite will parse this file for the following options:

server
username
password

All three are required (if the .globalyzerrc file exists). 'username' and 'password' 
may be overridden by the Project Definition file. If the Project Definition File defines 
a server (rather than leaving blank), it must match what is in the .globalyzerrc file.

The requirement for 'server' to match in both files ensures that you are
correctly retrieving the right rule sets from the right location.

Example:

```
username user@company.com
password password1_is__very__secure
server   https://www.globalyzer.com/gzserver
```

# Project Definition Files

Note: See the end of this file for example templates.

## Project Definition File Overview

More information and examples can be found online:
https://www.globalyzer.com/gzserver/help/referenceLite/project-definition-file-overview.html

A Project Definition File specifies the following:

  * Login information
  * Project information
  * Report information
  * A list of scans to perform
    * Customizations for each scan

Globalyzer Lite will read in this file, and perform the scans defined in it.
Globalyzer Lite uses an in-memory database, so it will not save any of its state
between executions. This means that you'll be getting a fresh look with each
scan. Note that rule sets are stored on the server side. They will persist
between executions.


## Login information

The login information includes the following:

  * A Lingoport <username> associated with the rule sets on the server.
    * May instead be specified in the .globalyzerrc file.
  * A <password> for the given username.
    * May instead be specified in the .globalyzerrc file.
  * The <server> where you have your rule sets.
    * May instead be specified in the .globalyzerrc file.
  * A <use-local-rulesets> set to true or false.
    * If true, required to download a Globalyzer.license file.
    * If true, username/password/server are not required.
  * The following Optional proxy settings:
    * <proxy-host>      required if using proxy settings
    * <proxy-port>      ''
    * <proxy-user>      optional if using proxy settings
    * <proxy-password>  ''

If working on OSX or Linux, you may wish to set your .globalyzerrc to be
only readable by you.
E.g. `chmod 600 ~/.globalyzerrc`


### Note: Java also has proxy settings:

-Dhttp.proxyHost=your.server.com
-Dhttp.proxyPort=80
-Dhttps.proxyHost=your.server.com
-Dhttps.proxyPort=80
-Dhttp.nonProxyHosts=123.210.123.210
-DsocksProxyHost=your.server.com
-DsocksProxyPort=1080

More info at: https://docs.oracle.com/javase/7/docs/technotes/guides/net/proxies.html


## Project Information

The project information includes a project path and name:

  * <project-path>: The path to the project that you wish to scan.
  * <project-name>: The name of this project.


## Report Information

Information relevant to generated reports. Consists of a report path and type:

  * <report-path>: The location that you want to place your scan reports
  * <report-type>: Pick a *Report Name* from the following


        Report                   Report             Output        Console
        Name                     Type               Format        Output OK
        .                        .                  .             .
        AggregateDetailedExcel   Detailed project   Excel         No
        AggregateSummaryExcel    Summary  project   Excel         No
        .                        .                  .             .
        ScanDetailedCSV          Detailed scan      CSV           Yes
        ScanDetailedXML          Detailed scan      XML           Yes
        ScanDetailedExcel        Detailed scan      Excel         No
        ScanSummaryHtml          Summary  scan      HTML          No
        ScanSummaryText          Summary  scan      plain text    No


## List of Scans to Perform

This list specifies the details of all scans that are to be run. There is no
limit to the number of scans that may be run, however running a large number
of scans can take a significant amount of time.

You must give each scan a unique name, and associate it with a rule set.
Optionally, you may specify the specific directories/files to scan by specifying
them as scan items. If no scan items are defined, then Globalyzer Lite will
scan all files within the project path that match the given rule sets' file
extension patterns.

You may specify whether or not to incorporate Machine Learning after executing
the scan. Use of this feature requires that Machine Learning was performed in
the Workbench and exported along with the Lite Project Definition file.

Additionally, you may specify the encoding of the source files. This is
unnecessary if your files are using a standard encoding (ASCII, UTF-8).

You may also specify custom names for Globalyzer-centric comments. The
customizable comments are as follows. A 'todo' comment which marks issues as
todo in the Globalyzer Workbench. An 'ignore next line' comment, which hides
issues on the following code line. A 'start ignore' comment, which hides all
issues after it. Up till and 'end ignore' comment.

Finally, you can enable/disable which issue types to scan for. The issue types
are 'embedded strings', 'locale sensitive methods', 'general patterns' and
'static file references'.

  * <scan>
    * <scan-name>: A unique name for the given scan.
    * <ruleset-name>: Name of the rule set associated with this scan.
    * <ruleset-owner>: The owner of the supplied rule set.

  Optional settings:

	* <use-machine-learning>: Incorporate machine learning after scanning; true or false. Optional.
    * <encoding>: Encoding of source files. Optional.
    * <scan-items> (Optional): File(s) and/or directories to be scanned
      * <item>: A single file or directory to scan. Directory scanning is
                recursive.

    * <comments> Specify custom globalyzer detected comments.
      * <todo>: Mark issue as todo.
      * <ignore-next-line>: Don't detect any issues on the next line.
      * <start-ignore>: Begin ignoring issues after this comment.
      * <end-ignore>: Stop ignoring issues after this comment.

    * <checks>: Which issue types to detect. Set these to either
                'true' or 'false'
      * <embedded-strings>: Detect embedded strings
      * <locale-sensitive-methods>: Detect locale sensitive functions/methods
      * <general-patterns>: Various language specific general detection patterns.
      * <static-file-references>: Detect references to static files, which may
                                  need to be altered for different locales.



## Project Definition XML Template

This provides the template overview. A filled-out example is present in the
next section.

    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!-- All items should be allowed anywhere in the xml as long as the
         hierarchy is preserved -->
    <gzproject>
        <login>
            <server> </server>     <!-- must match .globalyzerrc setting
            <username></username>  <!-- must be specified in .globalyzerrc -->
            <password></password>  <!-- must be specified in .globalyzerrc -->
                                        if .globalyzerrc is present        -->
            <use-local-rulesets></use-local-rulesets>  <!-- optional. May be 'true' or 'false'     -->
                                                       <!-- if true, you need a Globalyzer.license -->;

            <!-- Optional Parameters (Delete this section if not using them) -->
            <optional>
                <!-- If using, host and port must be filled out -->
                <proxy-user>    </proxy-user>
                <proxy-password></proxy-password>
                <proxy-host>    </proxy-host>  <!-- required if using proxy -->
                <proxy-port>    </proxy-port>  <!-- required if using proxy -->
            </optional>
        </login>

        <!-- Paths may be absolute, or relative -->
        <project-path></project-path> <!-- may be specified via command line -->
        <project-name></project-name>

        <report-path></report-path>   <!-- may be specified via command line -->
        <report-type></report-type>   <!-- See '## Report Information' -->
        <report-priorities></report-priorities>   <!-- optional, comma-separated list of priorities to include in report -->

        <data-dictionary-location></data-dictionary-location> <!-- optional -->
        <filter-with-dictionary></filter-with-dictionary> <!-- true/false,
                                                               optional     -->

        <scan-timeout>500</scan-timeout>  <!-- optional -->
        <generate-partial-results>false</generate-partial-results> <!-- optional -->
        <save-history>false</save-history> <!-- optional -->


        <scans>
            <scan>
                <!-- create and execute a single scan with this info -->
                <scan-name>    </scan-name>
                <ruleset-name> </ruleset-name>  <!-- must match existing -->
                <ruleset-owner></ruleset-owner>
            </scan>
            <scan>
                <!-- create and execute a single scan with this info -->
                <scan-name>    </scan-name>
                <ruleset-name> </ruleset-name>  <!-- must match existing -->
                <ruleset-owner></ruleset-owner>
                <!-- optional -->
                <use-machine-learning>true</use-machine-learning> <!-- machine learning zip files must exist -->
                <!-- optional -->
                <encoding>UTF-8</encoding> <!-- encoding of files to scan -->
                <!-- optional -->
                <scan-items>         <!-- may be overridden via command line -->
                    <item></item>    <!-- delete me if blank -->
                    <item></item>    <!-- delete me if blank -->
                </scan-items>
                <!-- optional -->
                <comments> <!-- customize globalyzer recognized comments -->
                    <todo>SPECIAL_GLOBALYZER_TODO_COMMENT</todo>
                    <ignore-next-line>GBLYZR_IGNORE_NEXT_LINE</ignore-next-line>
                    <start-ignore>GLOBALYZER_START_IGNORE</start-ignore>
                    <end-ignore>GBL_END_IGNORE</end-ignore>
                </comments>
                <!-- optional -->
                <checks>
                  <!-- specify which issue types to detect -->
                  <embedded-strings>true</embedded-strings>
                  <locale-sensitive-methods>false</locale-sensitive-methods>
                  <general-patterns>true</general-patterns>
                  <static-file-references>false</static-file-references>
                </checks>
            </scan>
        </scans>
    </gzproject>



## Project Definition File Template (Filled out minimal example)

    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!-- All items should be allowed anywhere in the xml as long as the
         hierarchy is preserved -->
    <gzproject>
        <login>
            <server>https://www.globalyzer.com/gzserver</server>
            <username>demo@lingoport.com</username>
            <password>demopass</password>

            <!-- optional proxy section removed -->
        </login>

        <project-path>/home/username/workspace/acme_supplies</project-path>
        <project-name>ACME Supplies</project-name>

        <report-path>LingoportReports</report-path>
        <report-type>ScanDetailedXML</report-type>

        <scans>
            <scan>
                <!-- create and execute a single scan with this info -->
                <scan-name>Clever Java Scan Name</scan-name>
                <ruleset-name>Company Java Base</ruleset-name>
                <ruleset-owner>user@company.com</ruleset-owner>
            </scan>
            <scan>
                <!-- create and execute a single scan with this info -->
                <scan-name>Clever JavaScript Scan Name</scan-name>
                <ruleset-name>Company JavaScript Extended</ruleset-name>
                <ruleset-owner></ruleset-owner>
                <!-- optional -->
                <scan-items>
                    <item>srv</item>
                    <item>src\website</item>
                    <item>src\main\js_helpers\userfacing.js</item>
                </scan-items>
            </scan>
        </scans> </gzproject>



## Project Definition File Template (Filled out full example)

<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- All items should be allowed anywhere in the xml as long as the hierarchy
     is preserved -->
<gzproject>
  <!-- optional, may be set in RC File -->
  <login>
    <server>https://www.globalyzer.com/gzserver</server> <!-- required! -->
    <!-- <username></username> - filled out in .globalyzerrc -->
    <!-- <password></password> - filled out in .globalyzerrc -->
    <!-- optional Parameters -->
    <optional>
        <!-- Proxy user and password are optional here.
        Server and port must be entered. -->
        <proxy-user></proxy-user>
        <proxy-password></proxy-password>
        <proxy-port>3912</proxy-port>
        <proxy-server>your.companys-proxy-server.com</proxy-server>
    </optional>
    <use-local-rulesets>false</use-local-rulesets>   <!-- default is false -->
  </login>


  <project-path>/path/to/your/project</project-path>
  <project-name>DemoProjDefFile</project-name>

  <report-path>globalyzer-lite-reports</report-path>
  <report-type>ScanDetailedXML</report-type>
  <report-priorities>C,1</report-priorities> <!-- default is blank, which means all -->

  <!-- optional -->
  <!-- Defaults to $HOME/.globalyzer -->
  <data-dictionary-location>/home/masnes/gzdict/</data-dictionary-location>
  <filter-with-dictionary>true</filter-with-dictionary>

  <!-- optional -->
  <scan-timeout>120</scan-timeout> <!-- In seconds. 600 (10 minutes) is max -->
  <generate-partial-results>false</generate-partial-results> <!-- default is false -->
  <save-history>false</save-history> <!-- default is false -->

  <scans>
    <scan>
      <!-- create and execute a single scan with this info -->
      <scan-name>Java Basic</scan-name>
      <ruleset-name>Java Ruleset</ruleset-name>
      <ruleset-owner>user@company.com</ruleset-owner>
      <scan-items>
        <item>src/main/java</item>
        <item>src/Base File.java</item>
      </scan-items>
      <!-- New fields. All new fields are optional -->
      <comments> <!-- Recognize  non-default globalyzer comments in source code
                 -->
        <todo>SPECIAL_COMMENT</todo>
        <ignore-next-line>IGNORELINE</ignore-next-line>
        <start-ignore>STARTIGNORE</start-ignore>
        <end-ignore>ENDIGNORE</end-ignore>
      </comments>
      <encoding>UTF-8</encoding>
      <checks>
        <static-file-references>true</static-file-references>
        <embedded-strings>false</embedded-strings>
        <!-- only static file references will be detected -->
      </checks>
    </scan>

    <scan>
      <!-- create and execute a single scan with this info -->
      <scan-name>XML</scan-name>
      <ruleset-name>Company XML extends Company Base XML</ruleset-name>
      <ruleset-owner>user@company.com</ruleset-owner>
      <!-- assume default encoding while reading source files -->
      <!-- recognize standard globalyzer comments in source code -->
      <checks>
        <embedded-strings>false</embedded-strings>
        <static-file-references>false</static-file-references>
        <!-- locale-sensitive methods and general patterns will both be
             detected -->
      </checks>
    </scan>

    <scan>
      <scan-name>PHP Basic</scan-name>
      <ruleset-name>Basic Php</ruleset-name>
      <ruleset-owner>user@company.com</ruleset-owner>
      <!-- scan all files in project (no scan items) -->
      <!-- assume default encoding while reading source files (no encoding)-->
      <!-- recognize standard globalyzer comments in source code (no comments)-->
      <!-- all issue types will be detected (no checks) -->
    </scan>
  </scans>
</gzproject>

END OF README.

NOTE: **Users skipping to this location**:
  While the rest of this Readme contains useful info, you may have skipped here
  looking for a few things.

WARNING!:  If you are using **Eclipse** as your IDE.
  You will want to read the instructions for installing the ClickableConsole
  plugin. Installation is very easy, and it enables much better clickable
  console output from Lite. Note the distinction between eclipse-default and gnu
  console output. (ClickableConsole uses gnu style console output)

* Project Definition files:
  * Full template with descriptions of fields: 3 sections above.
  * Basic, filled-out template: 2 sections above.
  * Full, filled-out template: Look just above here.

* Command Line options:
  * See 1/2 page down from top of Readme.

Otherwise, please see the table of contents at the top.
