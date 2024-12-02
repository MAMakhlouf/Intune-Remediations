$DMClientID = (Get-ChildItem C:\ProgramData\Microsoft\DMClient).Name

Get-ScheduledTask | ? { $_.TaskPath -like "*$DMClientID*" -and $_.TaskName -like "Schedule #1*"} | Start-ScheduledTask