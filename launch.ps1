$startDir = Get-Location
$errorDir = Join-Path -Path $startDir -ChildPath "errorLogs"
Remove-Item $errorDir -Recurse
New-Item $errorDir -ItemType Directory

$config = Get-Content config.json | ConvertFrom-Json

Set-Location -Path $config.WorkingDirectory

$ProcessesList = [System.Collections.ArrayList]@()
$config.ProcessesToRun | ForEach-Object -Process {
  $this = $config.Processes.$_

  $args = "run --project $($this.ProjectDirectory)"
  $errorPath = Join-Path -Path $errorDir -ChildPath "$_.out.txt"
  $ProcessesList += Start-Process -FilePath "dotnet" -ArgumentList $args -RedirectStandardError $errorPath -PassThru
}

Set-Location -Path $startDir

[void](Read-Host 'Press Enter to teardown...')

$LivingProcesses = $ProcessesList | Where-Object {-not $_.HasExited}

Stop-Process -InputObject $LivingProcesses
Wait-Process -InputObject $LivingProcesses
