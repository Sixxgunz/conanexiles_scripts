
@echo Installing custom view - item ownership info
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < itemownership.sql

)
close