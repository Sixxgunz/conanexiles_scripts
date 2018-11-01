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

/* Remove old event logs */
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

/*Reinserts server spawned forges and storymode stuff*/
INSERT OR REPLACE INTO `static_buildables` (name,id) VALUES ('/Game/Maps/ConanSandbox/Gameplay/Gameplay_VolcanoDungeon.Gameplay_VolcanoDungeon:PersistentLevel.BP_PL_Volcanic_Forge2_2',6),
 ('/Game/Maps/ConanSandbox/Art/Dungeon/Art_Dungeon_x2_y6_Tempel_of_Frost.Art_Dungeon_x2_y6_Tempel_of_Frost:PersistentLevel.BP_PL_Frost_Temple_Forge2_2',7),
 ('/Game/Maps/ConanSandbox/Gameplay/Camps_NPC/Camps-NPC_x3_y3-2.Camps-NPC_x3_y3-2:PersistentLevel.BP_Storymission_ChaosmouthAltar2_2',8),
 ('/Game/Maps/ConanSandbox/Gameplay/Camps_NPC/Camps_NPC_x3_y2.Camps_NPC_x3_y2:PersistentLevel.BP_Storymission_BatTower2_2',9);
INSERT OR REPLACE INTO `properties` (object_id,name,value) VALUES 
 (6,'BP_PL_Volcanic_Forge_C.m_IsStaticBuildable',X'0000000001'),
 (6,'BP_PL_Volcanic_Forge_C.DecayDisabled',X'0000000001'),
 (6,'CraftingQueue.m_IsStarted',X'0000000001'),
 (6,'CraftingQueue.m_IsDefaultRunStateInitialized',X'0000000001'),
 (7,'BP_PL_Frost_Temple_Forge_C.m_IsStaticBuildable',X'0000000001'),
 (7,'BP_PL_Frost_Temple_Forge_C.DecayDisabled',X'0000000001'),
 (7,'CraftingQueue.m_IsStarted',X'0000000001'),
 (7,'CraftingQueue.m_IsDefaultRunStateInitialized',X'0000000001'),
 (8,'BP_Storymission_ChaosmouthAltar_C.m_IsStaticBuildable',X'0000000001'),
 (8,'BP_Storymission_ChaosmouthAltar_C.DecayDisabled',X'0000000001'),
 (9,'BP_Storymission_BatTower_C.m_IsStaticBuildable',X'0000000001'),
 (9,'BP_Storymission_BatTower_C.DecayDisabled',X'0000000001'),
 (9,'CraftingQueue.m_IsStarted',X'0000000001'),
 (9,'CraftingQueue.m_IsDefaultRunStateInitialized',X'0000000001');
INSERT OR REPLACE INTO `buildings` (object_id,owner_id) VALUES 
 (6,0),
 (7,0),
 (8,0),
 (9,0);
INSERT OR REPLACE INTO `buildable_health` (object_id,instance_id,health_id,template_id,health_percentage) VALUES 
 (6,-1,0,11064,1.0),
 (7,-1,0,18041,1.0),
 (8,-1,0,11502,1.0),
 (9,-1,0,11502,1.0);
INSERT OR REPLACE INTO `actor_position` (class,map,id,x,y,z,sx,sy,sz,rx,ry,rz,rw) VALUES 
 ('/Game/DLC/DLC_Khitai/BP_ModController_Khitai_DLC.BP_ModController_Khitai_DLC_C','ConanSandbox',1,0.0,0.0,0.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/DLC/DLC_Aquilonia/DLC_Aquilonia_ModController.DLC_Aquilonia_ModController_C','ConanSandbox',2,0.0,0.0,0.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/DLC/ConanSword_DLC/BP_ConanSword_DLC_ModController.BP_ConanSword_DLC_ModController_C','ConanSandbox',3,0.0,0.0,0.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/DLC/ConanArmor_DLC/BP_ConanArmor_DLC_ModController.BP_ConanArmor_DLC_ModController_C','ConanSandbox',4,0.0,0.0,0.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/DLC/DLC_Pict/DLC_Pict_Modcontroller.DLC_Pict_Modcontroller_C','ConanSandbox',5,0.0,0.0,0.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/Systems/Building/Placeables/BP_PL_Volcanic_Forge.BP_PL_Volcanic_Forge_C','ConanSandbox',6,346165.5,-353598.90625,-6467.171875,1.0,1.0,1.0,0.0,0.0,0.0,1.0),
 ('/Game/Systems/Building/Placeables/BP_PL_Frost_Temple_Forge.BP_PL_Frost_Temple_Forge_C','ConanSandbox',7,-128000.0,-267584.0,6735.84765625,1.0,1.0,1.0,0.0,0.0,-0.707106053829193,0.707107543945313),
 ('/Game/Systems/Storymission/BP_Storymission_ChaosmouthAltar.BP_Storymission_ChaosmouthAltar_C','ConanSandbox',8,-60599.8046875,30389.27734375,594.71630859375,1.0,1.0,1.0,0.0,0.0,-1.0,3.57627868652344e-07),
 ('/Game/Systems/Storymission/BP_Storymission_BatTower.BP_Storymission_BatTower_C','ConanSandbox',9,-62135.484375,158682.59375,-224.165512084961,1.0,1.0,1.0,0.0,0.0,0.161826282739639,0.986819267272949);
INSERT OR REPLACE INTO `mod_controllers` (id) VALUES 
 (1),
 (2),
 (3),
 (4),
 (5);

 /*This replaces all T2 door info with T3 info until our bugs get removed - NO LONGER NEEDED-This bug was patched but I am keeping this here to use as an example to use for other purposes*/
/*
update actor_position set class='/Game/Systems/Building/Placeables/BP_PL_Door_T3.BP_PL_Door_T3_C' where class like '%/Game/Systems/Building/Placeables/BP_PL_Door_T2.BP_PL_Door_T2_C%';
update properties set name='BP_PL_Door_T3_C.PlacingPlayerUniqueID' where name like '%BP_PL_Door_T2_C.PlacingPlayerUniqueID%';
update properties set name='BP_PL_Door_T3_C.SourceItemTemplateID', value=X'0000000060600100' where name like '%BP_PL_Door_T2_C.SourceItemTemplateID%'; 
update properties set name='BP_PL_Door_T3_C.DecayDisabled', value=X'0000000001' where name like '%BP_PL_Door_T2_C.DecayDisabled%';
*/

/*This will compress our database, reindex for faster searching/querying,Analyze and then an integrety check and close the database after our transactions above have finished*/ 
VACUUM;
REINDEX;
ANALYZE;
pragma integrity_check;
.quit
