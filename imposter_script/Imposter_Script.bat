::Make sure you backup a copy of your main database into a seperate directory in case we run into any issues down the road.
::Run.
@echo off
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < Imposter_Script.sql
)
pause

