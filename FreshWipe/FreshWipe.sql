------------------------------------------------------------------
--  This does not delete anything from the accounts table       --
--  I keep personal records of all steam id's for the purpose   --
--  of tracking total number of players that have joined since  -- 
--  conan exiles original release day when we started WWG.      --
------------------------------------------------------------------
DELETE FROM account;
DELETE FROM actor_bounding_box;
DELETE FROM actor_position;
DELETE FROM buildable_health;
DELETE FROM building_instances;
DELETE FROM buildings;
DELETE FROM character_stats;
DELETE FROM characters;
DELETE FROM destruction_history;
DELETE FROM events;
DELETE FROM guilds;
DELETE FROM item_inventory;
DELETE FROM item_properties;
DELETE FROM properties;
DELETE FROM purgescores;
DELETE FROM static_buildables;

--Maintenance and Optimization
VACUUM; --compresses database
REINDEX;--reindexes all tables for faster transactions
ANALYZE;
pragma integrity_check;
.quit