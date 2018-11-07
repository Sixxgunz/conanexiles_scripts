::Please read InactiveCleanout.sql for what this contains. This is what I use on my server to help clear out inactive players.
::This can be a very lengthy process if you have a large database, but at this time the devs have not come up a solution to decay
::Place this file in a directory with the InactiveCleanout.sql.
::Make sure you backup a copy of your main database into a seperate directory in case we run into any issues down the road.
::And now lets break some stuff.
@echo off
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < freshwipe.sql
)
pause

