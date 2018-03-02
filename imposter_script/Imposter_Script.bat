::Please read Imposter_Script.sql for what this contains. This is what I use on my server to help clear out inactive players.
::This is a very lengthy process, but at this time the devs have not come up with a better solution
::And our current decay script has been deprecated as it no longer removes character and structure data properly.
::Place this file in a directory with the Imposter_Script.sql.
::Make sure you backup a copy of your main database into a seperate directory in case we run into any issues down the road.
::Run.
@echo off
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < Imposter_Script.sql
)
pause

