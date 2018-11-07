::This will delete everything.  Be prepared to be amazed with black magic now.
::Please make sure to use our custom inactivecleanout scripts to ensure your 
::database is back to default forge spawns/dlc content

@echo off
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < freshwipe.sql
)
pause

