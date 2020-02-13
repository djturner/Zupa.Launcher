$startDir = Get-Location
$errorDir = Join-Path -Path $startDir -ChildPath "errorLogs"
Remove-Item $errorDir -Recurse
New-Item $errorDir -ItemType Directory

$config = Get-Content config.json | ConvertFrom-Json

Set-Location -Path $config.WorkingDirectory

$config.ProcessesToRun | ForEach-Object -Process {
  $this = $config.Processes.$_

  $args = "run --project $($this.ProjectDirectory)"
  $errorPath = Join-Path -Path $errorDir -ChildPath "$_.out.txt"
  Start-Process -FilePath "dotnet" -ArgumentList $args -RedirectStandardError $errorPath
}

Set-Location -Path $startDir
