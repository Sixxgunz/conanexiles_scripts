@echo Install Custom Views
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < InstallViews.sql

)
close