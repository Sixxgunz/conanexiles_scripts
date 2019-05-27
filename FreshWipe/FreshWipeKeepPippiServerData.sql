------------------------------------------------------------------
--  This does not delete anything from the accounts table       --
--  I keep personal records of all steam id's for the purpose   --
--  of tracking total number of players that have joined since  -- 
--  conan exiles original release day when we started WWG.      --
--  This script in particular is set up to keep all pippi info  --
--  If you are not using pippi, have no fear it is still able   --
--  to fresh wipe your database and keep all character/clan info--
--  if you wish, if you wish to delete ALL data then remove the --
--  comments for characters/guilds table.                       --
------------------------------------------------------------------
--Wipe DB keeping only base character/guild in order to keep pippi information intact
--DELETE FROM account;
DELETE FROM actor_bounding_box;
DELETE FROM actor_position where class NOT LIKE'%systemconfigs%';--Save Pippi Settings through wipe cycles.;
DELETE FROM buildable_health;
DELETE FROM building_instances;
DELETE FROM buildings;
DELETE FROM character_stats;
--Keep Character Info through wipe cycles to keep pippi info
--DELETE FROM characters;
DELETE FROM destruction_history;
DELETE FROM events;
DELETE FROM game_events;
--Keep Character Guild Info through wipe cycles to keep pippi info
--DELETE FROM guilds;
DELETE FROM item_inventory;
--Saving Pippi info through wipe cycles
--DELETE FROM item_properties;
DELETE FROM properties where name NOT LIKE'%pippi%';--Save Pippi Settings through wipe cycles.
DELETE FROM purgescores;
DELETE FROM static_buildables;
DELETE FROM z_thrall_ownership;
DELETE FROM z_pet_ownership;

--Maintenance and Optimization
VACUUM; --compresses database
REINDEX;--reindexes all tables for faster transactions
ANALYZE;
pragma integrity_check;
.quit