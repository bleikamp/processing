# Processing in Atom

Run Processing sketches from Atom by pressing `ctrl+alt+b`

![processing package in action](https://cloud.githubusercontent.com/assets/25792/7103068/73799eda-e04b-11e4-8bbc-8ce625883730.png)

### Running a sketch from Atom

1. [Download Processing](https://processing.org/) if you don't already have it installed.
2. Install processing-java:
    * Mac OS: Open Processing and install processing-java from the Tools menu:
    ![image](https://cloud.githubusercontent.com/assets/25792/7103868/f8b90c1a-e06f-11e4-9dea-c84edab60097.png)
    * Linux: Add `processing-java` to your executable search path. This can be done by adding the Processing directory to your `PATH` environment variable or by adding a symlink to any existing directory within your `PATH`.
      The following command should do this on most linux distributions (replace `/path/to/processing` with the path where processing is installed):

      ```
        sudo ln -s /path/to/processing/processing-java /usr/local/bin/
      ```
    * Windows: Add `processing-java` to your Command Prompt. This can be done by adding the Processing directory to your `PATH` environment variable:
      * Open _Advanced System Settings_ either by running `sysdm.cpl` or searching in _Control Panel_.
      * Click the _Environment Variable_ button on the _Advanced_ tab.
      * Edit the `PATH` variable to include the Processing directory (e.g. `C:\Program Files\Processing-3.1.1\`) in either the User variables (for just your account) or System variables (for all users).
3. Open a Processing sketch in Atom and run it: `ctrl+alt+b`
