------------------------------------------------------------------
--  Fresh Wipe Keep all Pippi Server Data                       --
------------------------------------------------------------------
--Wipe DB keeping only base character/guild in order to keep pippi information intact
DELETE FROM actor_bounding_box;
DELETE FROM actor_position where class NOT LIKE'%pippi%';--Save Pippi Settings through wipe cycles.;
DELETE FROM buildable_health;
DELETE FROM building_instances;
DELETE FROM buildings;
DELETE FROM character_stats;
DELETE FROM destruction_history;
DELETE FROM events;
DELETE FROM game_events;
DELETE FROM item_inventory;
DELETE FROM item_properties;
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
