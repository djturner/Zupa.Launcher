# What is this?
This script lets you specifiy:
 - a series of dotnet core project directories under a common working directory
 - a list of which of these projects you currently wish to launch

When the script is run it will launch each of them using syntax `dotnet run --Project <project_dir>`.

# Usage
## Configuration
Current configuration lives in `config.json`.
- `WorkingDirectory`: the common working directory for your projects
- `ProcessesToRun`: an array of the projects you currently wish to run (as specified within `Processes`)
- `Processes`: an object referencing the details of each of project you may want to run, keyed by the project name

## Launching
- Ensure `ProcessesToRun` reflects the projects you wish to run
- Open a powershell terminal
- Execute `./launch.ps1`

## Troubleshooting
If a process dies (e.g. `dotnet run` fails to build the project), its window will close. Look in the ErrorLogs directory to find a log of the standard error output for that proccess.
