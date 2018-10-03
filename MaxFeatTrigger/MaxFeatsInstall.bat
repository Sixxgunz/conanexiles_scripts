for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < MaxFeats-Customizable.sql

)
close