/*Custom Decay Settings - Default 3 days - Targets inactive solos and whole clans - One active member saves the clan!*/
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from properties where object_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and object_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null)));
delete from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and guild is null);
delete from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from item_properties where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from item_properties where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from item_inventory where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days')) and owner_id not in (select id from characters where guild in (select guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from item_inventory where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from actor_position where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from actor_position where id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and guild is null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and guild is null);
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-3 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-3 days') and guild is not null));

/* Transfer Pet and Thrall ownership ID's to our custom tables before we remove old event logs*/
create table if not exists zpet_ownership(pet_id bigint not null, player_owner_id bigint not null, clan_owner_id bigint not null);
create table if not exists zthrall_ownership(thrall_id bigint not null, player_owner_id bigint not null, clan_owner_id bigint not null);

insert into
  zpet_ownership (pet_id, player_owner_id, clan_owner_id) 
  select distinct
    objectid,
    ownerid,
    ownerguildid 
  from
    game_events 
  where
    not exists 
    (
      select
        pet_id 
      from
        zpet_ownership 
      where
        zpet_ownership.pet_id = game_events.objectid 
    )
    and eventtype = 89 
    and objectname like '%pet_%';
insert into
  zthrall_ownership (thrall_id, player_owner_id, clan_owner_id) 
  select distinct
    objectid,
    ownerid,
    ownerguildid 
  from
    game_events 
  where
    not exists 
    (
      select
        thrall_id 
      from
        zthrall_ownership 
      where
        zthrall_ownership.thrall_id = game_events.objectid 
    )
    and eventtype = 89 
    and objectname like '%Aquilonian%' 
    or objectname like '%Cimmerian%' 
    or objectname like '%Darfari%' 
    or objectname like '%Hyborian%' 
    or objectname like '%Hyrkanian%' 
    or objectname like '%Kambujan%' 
    or objectname like '%Khitan%' 
    or objectname like '%Kushite%' 
    or objectname like '%Lemurian%' 
    or objectname like '%Nordheimer%' 
    or objectname like '%Shemite%' 
    or objectname like '%Stygian%' 
    or objectname like '%Zamorian%' 
    or objectname like '%Zingarian%' 
    or objectname like '%Black_Hand%' 
    or objectname like '%Darfari%' 
    or objectname like '%Dogs%' 
    or objectname like '%Exile%' 
    or objectname like '%Forgotten%' 
    or objectname like '%Heir%' 
    or objectname like '%Lemurian%' 
    or objectname like '%Relic_%' 
    or objectname like '%Votaries%' 
    or objectname like '%Alchemist%' 
    or objectname like '%Archer%' 
    or objectname like '%Armorer%' 
    or objectname like '%Bearer%' 
    or objectname like '%Blacksmith%' 
    or objectname like '%Carpenter%' 
    or objectname like '%Cook%' 
    or objectname like '%Entertainer%' 
    or objectname like '%Fighter%' 
    or objectname like '%Priest%' 
    or objectname like '%Smelter%' 
    or objectname like '%Tanner%' 
    or objectname like '%Taskmaster%' 
    or objectname like '%Witch_Queen%' 
    or objectname like '%broodwarden%';

/* Remove All Pets and Thralls*/
delete from game_events where worldTime < strftime('%s', 'now', '-1 days');

/*Single and Double Foundation/Pillar spam removal*/
CREATE TEMPORARY TABLE CleanUp_SingleFoundations AS
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%BuildFoundation%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%FenceFoundation%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%Pillar%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
delete from buildable_health where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from building_instances where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from actor_position where id in (select distinct id from CleanUp_SingleFoundations);
delete from buildings where object_id in (select distinct id from CleanUp_SingleFoundations);
delete from properties where object_id in (select distinct id from CleanUp_SingleFoundations);
DROP TABLE CleanUp_SingleFoundations;

CREATE TEMPORARY TABLE CleanUp_DoubleFoundations AS
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%BuildFoundation%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%Pillar%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%FenceFoundation%'
UNION ALL
SELECT ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '1' and bi.object_id not in (select object_id from building_instances where instance_id = '2') and ap.class like '%BuildTriangleFoundation%'order by ap.id;;
delete from buildable_health where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from building_instances where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from actor_position where id in (select distinct id from CleanUp_DoubleFoundations);
delete from buildings where object_id in (select distinct id from CleanUp_DoubleFoundations);
delete from properties where object_id in (select distinct id from CleanUp_DoubleFoundations);
DROP TABLE CleanUp_DoubleFoundations;

/*Crafting Station fix - Fishtraps, Wells, Wheels, Beehives, Alters*/
INSERT INTO properties (object_id, name, value)
SELECT DISTINCT id, classname || '.HasBeenPlacedInWorld' as name, X'0000000001' as value
FROM 
(
SELECT replace(class, rtrim(class, replace(class, '.', '')), '') AS classname, id
FROM actor_position
WHERE classname IN ('BP_PL_Crafting_FishNet_C', 'BP_PL_Crafting_CrabPot_C', 'BP_PL_Crafting_Beehive_C', 'BP_PL_Crafting_Beehive_Improved_C', 
  'BP_PL_Water_Well_C', 'BP_PL_Water_Well_Large_C', 'BP_PL_Water_Well_Tier2_C', 'BP_PL_Water_Well_MitraStatue_C',
  'BP_PL_Crafting_Water_Well_C', 'BP_PL_Crafting_Water_Well_Large_C', 'BP_PL_Crafting_Water_Well_Tier2_C', 'BP_PL_Crafting_Water_Well_MitraStatue_C', 
  'BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C')
)
WHERE id NOT IN
(
SELECT object_id
FROM properties
WHERE replace(name, rtrim(name, replace(name, '.', '')), '') LIKE 'HasBeenPlacedInWorld'
);

INSERT INTO properties (object_id, name, value)
SELECT DISTINCT object_id AS object_id, 'CraftingQueue.m_IsRunning' AS name, X'0000000001' AS value
FROM
(
SELECT object_id
FROM properties
WHERE name = 'CraftingQueue.m_IsStarted' AND value = X'0000000001'
  AND object_id NOT IN
  (
    SELECT DISTINCT object_id FROM properties WHERE name LIKE 'CraftingQueue.m_IsRunning'
  )
  AND object_id IN
  (
    SELECT DISTINCT id 
	FROM actor_position
	WHERE replace(class, rtrim(class, replace(class, '.', '')), '') IN ('BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C')
  )
);

/* Remove All Corpse's */
delete from item_inventory where owner_id in (select distinct id from actor_position where class like '%corpse%');
delete from actor_position where class like '%Corpse%';
delete from properties where name like '%Corpse%';

/*reset purge scores*/
UPDATE purgescores SET purgescore = 0;

VACUUM;
REINDEX;
ANALYZE;
pragma integrity_check;
.quit