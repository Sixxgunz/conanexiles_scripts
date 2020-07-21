/* Transfer Pet and Thrall ownership ID's to our custom tables before we remove old event logs*/
create table if not exists z_pet_ownership(pet_id bigint null, player_owner_id bigint null, clan_owner_id bigint null);
create table if not exists z_thrall_ownership(thrall_id bigint null, player_owner_id bigint null, clan_owner_id bigint null);
insert into z_pet_ownership (pet_id, player_owner_id, clan_owner_id) select distinct objectid, ownerid, ownerguildid from game_events where not exists ( select pet_id from z_pet_ownership where z_pet_ownership.pet_id = game_events.objectid ) and eventtype = 89 and objectname like '%pet_%';
insert into z_thrall_ownership (thrall_id, player_owner_id, clan_owner_id) select distinct objectid, ownerid, ownerguildid from game_events where not exists ( select thrall_id from z_thrall_ownership where z_thrall_ownership.thrall_id = game_events.objectid ) and eventtype = 89 and objectname like '%Aquilonian%' or objectname like '%Cimmerian%' or objectname like '%Darfari%' or objectname like '%Hyborian%' or objectname like '%Hyrkanian%' or objectname like '%Kambujan%' or objectname like '%Khitan%' or objectname like '%Kushite%' or objectname like '%Lemurian%' or objectname like '%Nordheimer%' or objectname like '%Shemite%' or objectname like '%Stygian%' or objectname like '%Zamorian%' or objectname like '%Zingarian%' or objectname like '%Black_Hand%' or objectname like '%Darfari%' or objectname like '%Dogs%' or objectname like '%Exile%' or objectname like '%Forgotten%' or objectname like '%Heir%' or objectname like '%Lemurian%' or objectname like '%Relic_%' or objectname like '%Votaries%' or objectname like '%Alchemist%' or objectname like '%Archer%' or objectname like '%Armorer%' or objectname like '%Bearer%' or objectname like '%Blacksmith%' or objectname like '%Carpenter%' or objectname like '%Cook%' or objectname like '%Entertainer%' or objectname like '%Fighter%' or objectname like '%Priest%' or objectname like '%Smelter%' or objectname like '%Tanner%' or objectname like '%Taskmaster%' or objectname like '%Witch_Queen%' or objectname like '%broodwarden%';

/* Remove duplicate owned npc id rows from our custom tables above */
delete from z_thrall_ownership where rowid not in ( select min(rowid) from z_thrall_ownership group by thrall_id ) ; 
delete from z_pet_ownership where rowid not in ( select min(rowid) from z_pet_ownership group by pet_id ) ;

/* Replace 0 values with Null value */
update `z_pet_ownership` set `player_owner_id` = null where player_owner_id = 0;
update `z_pet_ownership` set `clan_owner_id` = null where clan_owner_id = 0;
update `z_thrall_ownership` set `player_owner_id` = null where player_owner_id = 0;
update `z_thrall_ownership` set `clan_owner_id` = null where clan_owner_id = 0;

/*remove inactive player/clan pets*/

delete from properties where object_id in (select distinct pet_id from z_pet_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from properties where object_id in (select distinct pet_id from z_pet_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from actor_position where id in (select distinct pet_id from z_pet_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from actor_position where id in (select distinct pet_id from z_pet_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from item_inventory where owner_id in (select distinct pet_id from z_pet_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from item_inventory where owner_id in (select distinct pet_id from z_pet_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from character_stats where char_id in (select distinct pet_id from z_pet_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from character_stats where char_id in (select distinct pet_id from z_pet_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));


/*remove inactive player/clan thralls*/

delete from properties where object_id in (select distinct thrall_id from z_thrall_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from properties where object_id in (select distinct thrall_id from z_thrall_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from actor_position where id in (select distinct thrall_id from z_thrall_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from actor_position where id in (select distinct thrall_id from z_thrall_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from item_inventory where owner_id in (select distinct thrall_id from z_thrall_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from item_inventory where owner_id in (select distinct thrall_id from z_thrall_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from character_stats where char_id in (select distinct thrall_id from z_thrall_ownership where player_owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and player_owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from character_stats where char_id in (select distinct thrall_id from z_thrall_ownership where clan_owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));


/* Remove old event logs */
delete from game_events where worldTime < strftime('%s', 'now', '-5 days');

/*Custom Decay Settings - Default 3 days - Targets inactive solos and whole clans - One active member saves the clan!*/

delete from follower_markers where owner_id in (select distinct id from characters where lastTimeOnline > strftime('%s', 'now', '-6 days'));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6  days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from properties where object_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and object_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6  days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null)));
delete from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and guild is null);
delete from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from item_properties where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and owner_id not in (select id from characters where guild in (select guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from item_properties where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from item_inventory where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days')) and owner_id not in (select id from characters where guild in (select guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from item_inventory where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from actor_position where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from actor_position where id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days'));
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and guild is null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and guild is null);
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-6 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-6 days') and guild is not null));
delete from account where id not in (select distinct playerid from characters);


/*Single/Double/Triple/Quadruple Foundation AND Pillar spam removal - Uncomment if you wish to use the latter*/
CREATE TEMPORARY TABLE CleanUp_SingleFoundations AS SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%BuildFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%FenceFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%Pillar%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
delete from buildable_health where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from building_instances where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from actor_position where id in (select distinct id from CleanUp_SingleFoundations);
delete from buildings where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from properties where object_id in (select distinct id from CleanUp_SingleFoundations);
DROP TABLE CleanUp_SingleFoundations;

CREATE TEMPORARY TABLE CleanUp_DoubleFoundations AS SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%BuildFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%Pillar%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%FenceFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
delete from buildable_health where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from building_instances where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from actor_position where id in (select distinct id from CleanUp_DoubleFoundations);
delete from buildings where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from properties where object_id in (select distinct id from CleanUp_DoubleFoundations);
DROP TABLE CleanUp_DoubleFoundations;

CREATE TEMPORARY TABLE CleanUp_TripleFoundations AS SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '2' and bi.object_id not in (select object_id from building_instances where instance_id = '3') and ap.class like '%BuildFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '2' and bi.object_id not in (select object_id from building_instances where instance_id = '3') and ap.class like '%Pillar%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '2' and bi.object_id not in (select object_id from building_instances where instance_id = '3') and ap.class like '%FenceFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '2' and bi.object_id not in (select object_id from building_instances where instance_id = '3') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
delete from buildable_health where object_id in (select distinct id from CleanUp_TripleFoundations);
delete from building_instances where object_id in (select distinct id from CleanUp_TripleFoundations);
delete from actor_position where id in (select distinct id from CleanUp_TripleFoundations);
delete from buildings where object_id in (select distinct id from CleanUp_TripleFoundations);
delete from properties where object_id in (select distinct id from CleanUp_TripleFoundations);
DROP TABLE CleanUp_TripleFoundations;

--CREATE TEMPORARY TABLE CleanUp_QuadFoundations AS SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '3' and bi.object_id not in (select object_id from building_instances where instance_id = '4') and ap.class like '%BuildFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '3' and bi.object_id not in (select object_id from building_instances where instance_id = '4') and ap.class like '%Pillar%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '3' and bi.object_id not in (select object_id from building_instances where instance_id = '4') and ap.class like '%FenceFoundation%' UNION ALL SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '3' and bi.object_id not in (select object_id from building_instances where instance_id = '4') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
--delete from buildable_health where object_id in (select distinct id from CleanUp_QuadFoundations);
--delete from building_instances where object_id in (select distinct id from CleanUp_QuadFoundations);
--delete from actor_position where id in (select distinct id from CleanUp_QuadFoundations);
--delete from buildings where object_id in (select distinct id from CleanUp_QuadFoundations);
--delete from properties where object_id in (select distinct id from CleanUp_QuadFoundations);
--DROP TABLE CleanUp_QuadFoundations;

/*Crafting Station fix - Fishtraps, Wells, Wheels, Beehives, Alters*/
--Uncomment if you wish to use 
--INSERT INTO properties (object_id, name, value) SELECT DISTINCT id, classname || '.HasBeenPlacedInWorld' as name, X'0000000001' as value FROM ( SELECT replace(class, rtrim(class, replace(class, '.', '')), '') AS classname, id FROM actor_position WHERE classname IN ('BP_PL_Crafting_FishNet_C', 'BP_PL_Crafting_CrabPot_C', 'BP_PL_Crafting_Beehive_C', 'BP_PL_Crafting_Beehive_Improved_C', 'BP_PL_Water_Well_C', 'BP_PL_Water_Well_Large_C', 'BP_PL_Water_Well_Tier2_C', 'BP_PL_Water_Well_MitraStatue_C', 'BP_PL_Crafting_Water_Well_C', 'BP_PL_Crafting_Water_Well_Large_C', 'BP_PL_Crafting_Water_Well_Tier2_C', 'BP_PL_Crafting_Water_Well_MitraStatue_C', 'BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C') ) WHERE id NOT IN ( SELECT object_id FROM properties WHERE replace(name, rtrim(name, replace(name, '.', '')), '') LIKE 'HasBeenPlacedInWorld' );
--INSERT INTO properties (object_id, name, value) SELECT DISTINCT object_id AS object_id, 'CraftingQueue.m_IsRunning' AS name, X'0000000001' AS value FROM ( SELECT object_id FROM properties WHERE name = 'CraftingQueue.m_IsStarted' AND value = X'0000000001' AND object_id NOT IN ( SELECT DISTINCT object_id FROM properties WHERE name LIKE 'CraftingQueue.m_IsRunning' ) AND object_id IN ( SELECT DISTINCT id FROM actor_position WHERE replace(class, rtrim(class, replace(class, '.', '')), '') IN ('BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C') ) );

/* Remove All Corpse's */
--Uncomment if you wish to use 
delete from item_inventory where owner_id in (select distinct id from actor_position where class like '%corpse%');
delete from actor_position where class like '%Corpse%';
delete from properties where name like '%Corpse%';

/* Remove Mitras Justice and Set's Tongue */
--&delete from item_inventory where template_id in ('51393','51394');

/*reset purge scores*/
--Uncomment if you wish to use                                                                                                                
--UPDATE purgescores SET purgescore = 0;
                                                                                                                                        
--Uncomment if you wish to use 
/*Fish Trap Cleaner - Thanks to MVP*/
--create temporary table fish_traps as select actor_position.id from actor_position where actor_position.class like '%Fish%' or actor_position.class like '%crab%';
--delete from buildable_health where object_id in (select id from fish_traps);
--delete from game_events where game_events.objectId in (select id from fish_traps);
--delete from item_inventory where item_inventory.owner_id in (select id from fish_traps);
--delete from properties where properties.object_id in (select id from fish_traps);
--delete from actor_position where actor_position.id in (select id from fish_traps);
--drop table fish_traps;
 
/*

--Custom Zohne Locations:
--Market: 		TP:		TeleportPlayer 147174.75 256399.96875 -18315.195313
--Dregs     	OB: 	TeleportPlayer -141410.140625 216889.546875 -13576.22168
--Sinkhole  	OB: 	TeleportPlayer 25025.923828 134439.0625 -7167.101563
--Unnamed   	OB: 	TeleportPlayer -123929.46875 112207.234375 -9788.019531
--Springs   	OB: 	TeleportPlayer -204256.296875 51964.898438 -7770.13623
--Mounds    	OB: 	TeleportPlayer -237115.046875 -100462.875 -1867.082642
--BlackKeep 	OB: 	TeleportPlayer -68457.789063 -116081.289063 4851.418457
--Frost Temp	OB: 	TeleportPlayer -119442.46875 -217645.53125 12212.088867
--Volcano   	OB: 	TeleportPlayer -7185.756836 -220169.1875 46180.382813
--JungMarsh 	OB: 	TeleportPlayer 187030.03125 13565.135742 -18130.939453
--Jungle    	OB: 	TeleportPlayer 316852.40625 118351.15625 -9515.992188

--END CUSTOM ZOHNES
*/

/*This will compress our database, reindex for faster querying, Analyze and then an integrety check and close the database after our transactions above have finished*/ 
VACUUM;
REINDEX;
ANALYZE;
PRAGMA integrity_check;
PRAGMA optimize;
