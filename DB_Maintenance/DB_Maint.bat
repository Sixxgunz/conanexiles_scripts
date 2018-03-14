::Use this to optimize your CE Database for smoother operation.
::Run.
@echo off
for %%a in (game.db) do (
echo "%%a"
sqlite3 %%a < DB_Maint.sql
)
pause

