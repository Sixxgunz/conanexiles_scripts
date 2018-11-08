@echo Installs All Custom Views and custom reference tables for view scripts
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < InstallViews.sql

)
close
