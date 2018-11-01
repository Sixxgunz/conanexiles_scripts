::Please read inactivecleanout.sql for what this contains. This is what I use on my server to help clean out inactive players.
::This is a very lengthy process, but at this time the devs have not come up with a better solution
::And our current decay script has been deprecated as it no longer removes character and structure data properly.
::To gather log data create 2 new folders in saved folder called Chat_Logs and BackupServer_Logs

@echo Inactive Cleanout and Chat Logs
set curTimestamp=%date:~7,2%_%date:~3,3%_%date:~10,4%_%time:~0,2%_%time:~3,2%
findstr /s "ChatWindow:" *.log >> C:\ConanServers\Conan_Server_1\ConanSandbox\Saved\Chat_Logs\Server_ChatLogs-"%curTimestamp%".txt
findstr /s ":" *.log >> C:\conanservers\Conan_Server_1\ConanSandbox\Saved\BackupServer_Logs\Backup_Server_Logs-"%curTimestamp%".txt
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < InactiveCleanout.sql

)
close
