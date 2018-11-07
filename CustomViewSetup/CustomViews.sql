CREATE VIEW IF NOT EXISTS "Tier_3_Wheel_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'Wheels' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%wheelofpainXXL_c%' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Tier_3_Altar_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'T3_Altars' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%BP_PL_CraftingStation_WheelOfPainXXL_C' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Tier_2_Wheel_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'Wheels' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%wheelofpainXL_c%' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Tier_2_Altar_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'T2_Altars' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%BP_PL_CraftingStation_WheelOfPainXL_C' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Tier_1_Wheel_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'Wheels' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%wheelofpain_c%' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Tier_1_Altar_Totals" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'T1_Altars' 
FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id 
INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id 
WHERE ap.class LIKE '%BP_PL_CraftingStation_WheelOfPain_C' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Thralls_Placed_In_World" AS 
SELECT
   CASE
      WHEN
         class LIKE '%human%' 
      THEN
         ap.id 
      ELSE
         class 
   END
   'Thrall_ID',CASE
      WHEN
         class LIKE '%human%' 
      THEN
         ap.class
      ELSE
         class 
   END
   'Thrall Class', 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z AS Location 
FROM
   actor_position AS ap 
where
   class like '%human%' 

ORDER BY
   Thrall_ID DESC;
CREATE VIEW IF NOT EXISTS "Thralls, Non-Combat" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'Stored Thralls' FROM item_inventory AS i INNER JOIN item_properties ip ON ip.owner_id = i.owner_id AND ip.item_id = i.item_id INNER JOIN actor_position ap ON i.owner_id = ap.id INNER JOIN buildings b ON b.object_id = ap.id INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id where ip.name = 'ThrallCharLayout' GROUP BY b.owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Thralls, Combat" AS SELECT CASE WHEN class LIKE '%PersistentHuman%' THEN 'Combat' WHEN class LIKE '%EntertainerHuman%' THEN 'Dancer' ELSE class END Thrall, SUBSTR("TSRQPONMLKJIHGFEDCBA",(CASE WHEN (168288-ap.x)/24429 = CAST((168288-ap.x)/24429 AS INT) THEN CAST((168288-ap.x)/24429 AS INT) ELSE 1 + CAST((168288-ap.x)/24429 AS INT) END),1) || (CASE WHEN (ap.y+88930)/24764-1 = CAST((ap.y+88930)/24764-1 AS INT) THEN CAST((ap.y+88930)/24764-1 AS INT) ELSE 1 + CAST((ap.y+88930)/24764-1 AS INT) END) AS 'Pippi', 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z AS Location FROM actor_position AS ap where class like '%Human%' ORDER BY Pippi, Location DESC;
CREATE VIEW IF NOT EXISTS `ThrallInfo` AS select pb.name as player_guild_name,* from item_inventory as i inner join item_properties ip on ip.owner_id = i.owner_id and ip.item_id = i.item_id inner join actor_position ap on i.owner_id = ap.id inner join buildings b on b.object_id = ap.id inner join (Select guildid as pb_id, name from guilds Union select id, char_name from characters) pb on b.owner_id = pb_id where ip.name = 'ThrallCharLayout';
CREATE VIEW IF NOT EXISTS "Structure_Locations" AS SELECT pb.name AS Owner, COUNT(bi.instance_id) AS 'Pieces', SUBSTR("TSRQPONMLKJIHGFEDCBA",(CASE WHEN (168288-ap.x)/24429 = CAST((168288-ap.x)/24429 AS INT) then CAST((168288-ap.x)/24429 AS INT) ELSE 1 + CAST((168288-ap.x)/24429 AS INT) END),1) || (CASE WHEN (ap.y+88930)/24764-1 = CAST((ap.y+88930)/24764-1 AS INT) then CAST((ap.y+88930)/24764-1 AS INT) ELSE 1 + CAST((ap.y+88930)/24764-1 AS INT) END) AS 'Pippi', 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z AS Location FROM building_instances AS bi INNER JOIN buildings b ON b.object_id = bi.object_id INNER JOIN actor_position ap ON ap.id = bi.object_id INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id GROUP BY bi.object_id ORDER BY lower(Owner), Pippi, COUNT(bi.instance_id) DESC;
CREATE VIEW IF NOT EXISTS `Single_Pillar_Spam` AS select ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%pillar%';
CREATE VIEW IF NOT EXISTS `Single_Foundation_Spam` AS select ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%found%';
CREATE VIEW IF NOT EXISTS `Pet_Thrall_Unique_id_info` AS SELECT substr(hguid, 7, 2) || substr(hguid, 5, 2) || substr(hguid, 3, 2) || substr(hguid, 1, 2) || '-' || substr(hguid, 11, 2) || substr(hguid, 9, 2) || '-' || substr(hguid, 15, 2) || substr(hguid, 13, 2) || '-' || substr(hguid, 17, 4) || '-' || substr(hguid, 21, 12) AS value_string FROM (SELECT hex(value) AS hguid FROM properties WHERE name = 'BP_ThrallComponent_C.OwnerUniqueID');
CREATE VIEW IF NOT EXISTS `Out_Of_Bounds` AS 
select
  g.name as guild_name,
  g.guildid as guild_id,
  c.char_name as char_name,
  c.id as char_id,
  ap.id as object_id,
  class as object,
  'TeleportPlayer ' || x || ' ' || y || ' ' || z as location,
  'north' as direction 
from
  actor_position as ap 
  left outer join
    buildings as b 
    on ap.id = b.object_id 
  left outer join
    characters as c 
    on c.id = b.owner_id 
  left outer join
    guilds as g 
    on g.guildid = b.owner_id 
where
  y < '-288547.281' 
UNION ALL
select
  g.name as guild_name,
  g.guildid as guild_id,
  c.char_name as char_name,
  c.id as char_id,
  ap.id as object_id,
  class as object,
  'TeleportPlayer ' || x || ' ' || y || ' ' || z as location,
  'south' as direction 
from
  actor_position as ap 
  left outer join
    buildings as b 
    on ap.id = b.object_id 
  left outer join
    characters as c 
    on c.id = b.owner_id 
  left outer join
    guilds as g 
    on g.guildid = b.owner_id 
where
  y > '351389.906' 
UNION ALL
select
  g.name as guild_name,
  g.guildid as guild_id,
  c.char_name as char_name,
  c.id as char_id,
  ap.id as object_id,
  class as object,
  'TeleportPlayer ' || x || ' ' || y || ' ' || z as location,
  'west' as direction 
from
  actor_position as ap 
  left outer join
    buildings as b 
    on ap.id = b.object_id 
  left outer join
    characters as c 
    on c.id = b.owner_id 
  left outer join
    guilds as g 
    on g.guildid = b.owner_id 
where
  x < '-291709.219' 
UNION ALL
select
  g.name as guild_name,
  g.guildid as guild_id,
  c.char_name as char_name,
  c.id as char_id,
  ap.id as object_id,
  class as object,
  'TeleportPlayer ' || x || ' ' || y || ' ' || z as location,
  'east' as direction 
from
  actor_position as ap 
  left outer join
    buildings as b 
    on ap.id = b.object_id 
  left outer join
    characters as c 
    on c.id = b.owner_id 
  left outer join
    guilds as g 
    on g.guildid = b.owner_id 
where
  x > '396587.625' 
order by
  direction;
CREATE VIEW IF NOT EXISTS "Non_Building_Item_Locations" AS SELECT pb.name AS Owner, pn.name AS Type, COUNT(pn.object_id) AS 'Connected_Structures', SUBSTR("TSRQPONMLKJIHGFEDCBA", (CASE WHEN (168288-ap.x)/24429 = CAST((168288-ap.x)/24429 AS INT) then CAST((168288-ap.x)/24429 AS INT) ELSE 1 + CAST((168288-ap.x)/24429 AS INT) END),1) || (CASE WHEN (ap.y+88930)/24764-1 = CAST((ap.y+88930)/24764-1 AS INT) then CAST((ap.y+88930)/24764-1 AS INT) ELSE 1 + CAST((ap.y+88930)/24764-1 AS INT) END) AS 'Pippi', 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z AS Location FROM properties AS pn INNER JOIN buildings b ON b.object_id = pn.object_id INNER JOIN actor_position ap ON ap.id = pn.object_id INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id GROUP BY pn.object_id ORDER BY lower(Owner), Pippi, COUNT(pn.object_id) DESC;
CREATE VIEW IF NOT EXISTS `Items_In_Structure_Inventories` AS select player_guild_name, ItemName, ItemType, sum(item_count) as item_count from ( select pb.name as player_guild_name, x.Name as ItemName, x.Type as ItemType, case when substr(hex(data), length(hex(data)) - 31, 1) = 'A' then 11 else case when substr(hex(data), length(hex(data)) - 31, 1) = 'B' then 12 else case when substr(hex(data), length(hex(data)) - 31, 1) = 'C' then 13 else case when substr(hex(data), length(hex(data)) - 31, 1) = 'D' then 14 else case when substr(hex(data), length(hex(data)) - 31, 1) = 'E' then 15 else cast(substr(hex(data), length(hex(data)) - 31, 1) as Int) end end end end end * 16 + case when substr(hex(data), length(hex(data)) - 30, 1) = 'A' then 11 else case when substr(hex(data), length(hex(data)) - 30, 1) = 'B' then 12 else case when substr(hex(data), length(hex(data)) - 30, 1) = 'C' then 13 else case when substr(hex(data), length(hex(data)) - 30, 1) = 'D' then 14 else case when substr(hex(data), length(hex(data)) - 30, 1) = 'E' then 15 else cast(substr(hex(data), length(hex(data)) - 30, 1) as Int) end end end end end as item_count from item_inventory as i inner join actor_position ap on i.owner_id = ap.id inner join buildings b on b.object_id = ap.id inner join cust_item_xref x on x.template_id = i.template_id inner join ( Select guildid as pb_id, name from guilds Union select id, char_name from characters ) pb on b.owner_id = pb_id where inv_type = 4 ) iq group by player_guild_name, ItemName, ItemType;
CREATE VIEW IF NOT EXISTS `InactivePlayers` AS select * from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-2 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-2 days') and guild is not null));
CREATE VIEW IF NOT EXISTS `Double_Pillar_Spam` AS select ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%pillar%';
CREATE VIEW IF NOT EXISTS `Double_Foundation_Spam` AS select ap.id, c.char_name, c.playerid, c.id, g.name, g.guildid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z from actor_position as ap inner join buildings as b on ap.id = b.object_id left outer join characters as c on c.id = b.owner_id left outer join guilds as g on g.guildid = b.owner_id inner join building_instances as bi on bi.object_id = b.object_id where bi.instance_id = '0' and bi.object_id not in (select object_id from building_instances where instance_id = '1') and ap.class like '%found%';
CREATE VIEW IF NOT EXISTS `Detailed_Player_Info` AS 
select
   quote(g.name) as GUILD,
   quote(g.guildid) as GUILDid,
   quote(c.char_name) as NAME,
   case
      c.rank 
	  WHEN
	     '3'
	  then
	     'Recruit'
      WHEN
         '2' 
      then
         'Leader' 
      WHEN
         '1' 
      then
         'Officer' 
      WHEN
         '0' 
      then
         'Member' 
      ELSE
         'No Clan' 
   END
   RANK, c.level as LEVEL, quote(c.playerid) as STEAMid, quote(c.id) as DBid, 'TeleportPlayer ' || ap.x || ' ' || ap.y || ' ' || ap.z as LOCATION, datetime(c.lastTimeOnline, 'unixepoch') as LASTONLINE 
from
   characters as c 
   left outer join
      guilds as g 
      on g.guildid = c.guild 
   left outer join
      actor_position as ap 
      on ap.id = c.id 
order by
   g.name, c.rank desc, c.level desc, c.char_name;
CREATE VIEW IF NOT EXISTS 'Crafting Station Totals' AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'Stations' FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id WHERE ap.class LIKE '%CraftingStation%' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;
CREATE VIEW IF NOT EXISTS "Clan Member Totals" AS SELECT name AS Clan, COUNT(name) AS Members FROM guilds AS g INNER JOIN characters c on c.guild = g.guildId GROUP BY name ORDER BY Members DESC;
CREATE VIEW IF NOT EXISTS "Archery_Targets" AS SELECT pb.name AS '[Char/Clan]', COUNT(b.owner_id) AS 'ArcheryTargetCoordsd' FROM actor_position AS ap INNER JOIN buildings b ON b.object_id = ap.id INNER JOIN ( SELECT guildid AS pb_id, name FROM guilds UNION SELECT id, char_name FROM characters ) pb ON b.owner_id = pb_id WHERE ap.class LIKE '%/Game/Systems/Building/Placeables/BP_PL_ArcheryTarget.BP_PL_ArcheryTarget_C' GROUP BY owner_id ORDER BY COUNT(b.owner_id) DESC;

CREATE TABLE IF NOT EXISTS cust_item_xref (
template_id INTEGER,
name TEXT,
type TEXT
);
INSERT INTO `cust_item_xref` (template_id,name,type) VALUES (10001,'Stone','ingredient'),
 (10005,'Bark','ingredient'),
 (10011,'Wood','ingredient'),
 (10012,'Branch','ingredient'),
 (10021,'Bone','ingredient'),
 (10022,'Undead Dragonbone','ingredient'),
 (10023,'Undead Dragonhorn','ingredient'),
 (11001,'Ironstone','ingredient'),
 (11011,'Coal','ingredient'),
 (11051,'Crystal','ingredient'),
 (11052,'Silver','ingredient'),
 (11501,'Iron Bar','ingredient'),
 (11502,'Steel Bar','ingredient'),
 (11551,'Glass','ingredient'),
 (12001,'Plant Fiber','ingredient'),
 (12003,'Gossamer','ingredient'),
 (12011,'Hide','ingredient'),
 (12012,'Thick Hide','ingredient'),
 (12511,'Leather','ingredient'),
 (12512,'Thick Leather','ingredient'),
 (12513,'Silk','ingredient'),
 (12514,'Ichor','ingredient'),
 (13001,'Feral Flesh','ingredient'),
 (13002,'Savoury Flesh','ingredient'),
 (13003,'Exotic Flesh','ingredient'),
 (13011,'Shaleback Egg','consumable'),
 (13012,'Fat Grub','consumable'),
 (13013,'Handful of Insects','consumable'),
 (13014,'Small Scorpion','consumable'),
 (13015,'Seeds','ingredient'),
 (13051,'Human Flesh','ingredient'),
 (13052,'Eyes of Innocence','ingredient'),
 (13501,'Shredded Roast','consumable'),
 (13502,'Grilled Steak','consumable'),
 (13503,'Roasted Haunch','consumable'),
 (13540,'Gruel','consumable'),
 (13550,'Devils Bonemeal','consumable'),
 (13597,'Spoiled Gruel','consumable'),
 (13598,'Rotten Devils Bonemeal','consumable'),
 (13599,'Putrid Meat','consumable'),
 (13601,'Arena Ritual Offering','consumable'),
 (14001,'Aloe Leaves','ingredient'),
 (14101,'Serpent Venom Gland','ingredient'),
 (14102,'Sand Reaper Toxin Gland','ingredient'),
 (14151,'Yellow Lotus Blossom','ingredient'),
 (14171,'Brimstone','ingredient'),
 (14172,'Tar','ingredient'),
 (14173,'Steelfire','ingredient'),
 (14174,'Twine','ingredient'),
 (14175,'Dead Womans Hair','ingredient'),
 (14181,'Tomb Dust','ingredient'),
 (14182,'Demon Blood','ingredient'),
 (14183,'Dragonpowder','ingredient'),
 (15001,'Human Heart','ingredient'),
 (15002,'Unblemished Human Meat','ingredient'),
 (15003,'Lingering Essence','ingredient'),
 (15501,'Heart of a Hero','ingredient'),
 (15502,'Ancient Rhino Horn','ingredient'),
 (16001,'Stone Consolidant','ingredient'),
 (16002,'Iron Reinforcement','ingredient'),
 (16003,'Steel Reinforcement','ingredient'),
 (16011,'Brick','ingredient'),
 (16012,'Hardened Brick','ingredient'),
 (16021,'Shaped Wood','ingredient'),
 (30001,'Scrawled Note','consumable'),
 (30002,'Leather Journal','consumable'),
 (30003,'Prayer to Hanuman','consumable'),
 (30004,'Scribbled Note','consumable'),
 (30005,'Torn Parchment','consumable'),
 (30006,'Razmas Journal #1','consumable'),
 (30007,'Razmas Journal #2','consumable'),
 (30008,'Razmas Journal #3','consumable'),
 (30009,'Razmas Journal #4','consumable'),
 (30010,'Razmas Journal #5','consumable'),
 (30011,'Razmas Journal #6','consumable'),
 (30012,'Razmas Journal #7','consumable'),
 (30013,'Razmas Journal #8','consumable'),
 (30014,'Etched Note','consumable'),
 (30015,'First Mates Report','consumable'),
 (30016,'Black Hand Shanty','consumable'),
 (30017,'Salaceos Instructions','consumable'),
 (30018,'Hunters Note - Shalebacks','consumable'),
 (30019,'Priests Journal','consumable'),
 (30020,'Hunters Note - Hyenas','consumable'),
 (30021,'Hunters Note - Imps','consumable'),
 (30022,'Hunters Note - Crocodiles','consumable'),
 (30023,'Mercenarys Diary Page','consumable'),
 (30024,'Waterstained Note','consumable'),
 (41031,'Improvised Torch','weapon'),
 (41032,'Sealed Waterskin','consumable'),
 (41033,'Torch','weapon'),
 (51001,'Stone Pick','weapon'),
 (51002,'Iron Pick','weapon'),
 (51003,'Steel Pick','weapon'),
 (51011,'Stone Hatchet','weapon'),
 (51012,'Iron Hatchet','weapon'),
 (51013,'Steel Hatchet','weapon'),
 (51021,'Pickaxe','weapon'),
 (51031,'Repair Hammer','weapon'),
 (51151,'Iron Warhammer','weapon'),
 (51152,'Stone Maul','weapon'),
 (51153,'Sledge of Tsotha-lanti','weapon'),
 (51301,'Stone Club','weapon'),
 (51303,'Truncheon','weapon'),
 (51304,'Mitraen Ankh','weapon'),
 (51401,'Hunting Bow','weapon'),
 (51402,'Hyrkanian Bow','weapon'),
 (51403,'Exceptional Hyrkanian Bow','weapon'),
 (51404,'Flawless Hyrkanian Bow','weapon'),
 (51451,'Crossbow','weapon'),
 (51452,'Exceptional Crossbow','weapon'),
 (51453,'Flawless Crossbow','weapon'),
 (51600,'Wooden Shield','weapon'),
 (51601,'Bone Shield','weapon'),
 (51602,'Wooden Targe','weapon'),
 (51611,'Iron Targe','weapon'),
 (51621,'Steel Heater Shield','weapon'),
 (51623,'Ancient Shield','weapon'),
 (51624,'Stygian Shield','weapon'),
 (51625,'Setite Shield','weapon'),
 (51626,'Exceptional Steel Heater Shield','weapon'),
 (51627,'Flawless Steel Heater Shield','weapon'),
 (51711,'Iron Pike','weapon'),
 (51721,'Steel Trident','weapon'),
 (51722,'Gavains Rusty Pike','weapon'),
 (51801,'Stone Sword','weapon'),
 (51811,'Iron Broadsword','weapon'),
 (51812,'Stygian Khopesh','weapon'),
 (51813,'Ancient Khopesh','weapon'),
 (51814,'Exceptional Iron Broadsword','weapon'),
 (51815,'Flawless Iron Broadsword','weapon'),
 (51816,'Phoenix-engraved Sword','weapon'),
 (51817,'Serpent-stamped Khopesh','weapon'),
 (51818,'Exceptional Stygian Khopesh','weapon'),
 (51821,'Falcata','weapon'),
 (51822,'Cutlass','weapon'),
 (51823,'Exceptional Cutlass','weapon'),
 (51831,'Longsword','weapon'),
 (51832,'Dry Scraper','weapon'),
 (51833,'Darfari Axe','weapon'),
 (51834,'Els Drinker','weapon'),
 (51835,'Tulwar of Amir Khurum','weapon'),
 (51836,'Exceptional Longsword','weapon'),
 (51837,'Flawless Longsword','weapon'),
 (51850,'Darfari Cudgel','weapon'),
 (51851,'Cimmerian Battle-axe','weapon'),
 (51853,'Darfari Sword','weapon'),
 (51854,'Yog Cleaver','weapon'),
 (51855,'Yoggite Cudgel','weapon'),
 (51902,'Setite Ritual Knife','weapon'),
 (51911,'Javelin','weapon'),
 (51912,'Throwing Axe','weapon'),
 (51922,'Yoggite Bone Spear','weapon'),
 (51931,'Stygian Spear','weapon'),
 (51951,'Stone Dagger','weapon'),
 (51952,'Iron Poniard','weapon'),
 (51953,'Steel Poniard','weapon'),
 (51954,'Dagger of Nameless Days','weapon'),
 (51955,'Exceptional Iron Poniard','weapon'),
 (51956,'Flawless Iron Poniard','weapon'),
 (51961,'Fiber Bindings','weapon'),
 (51962,'Rawhide Bindings','weapon'),
 (51963,'Leather Bindings','weapon'),
 (51964,'Chain Bindings','weapon'),
 (51965,'Bindings of Dead Women?s Hair','weapon'),
 (52001,'Light Turban','armor'),
 (52002,'Light Chestpiece','armor'),
 (52003,'Light Gauntlets','armor'),
 (52004,'Light Wrap','armor'),
 (52005,'Light Boots','armor'),
 (52011,'Medium Cap','armor'),
 (52012,'Medium Harness','armor'),
 (52013,'Medium Gauntlets','armor'),
 (52014,'Medium Tasset','armor'),
 (52015,'Medium Boots','armor'),
 (52021,'Heavy Helmet','armor'),
 (52022,'Heavy Pauldron','armor'),
 (52023,'Heavy Gauntlets','armor'),
 (52024,'Heavy Tasset','armor'),
 (52025,'Heavy Sabatons','armor'),
 (52071,'Darfari Watcher Mask','armor'),
 (52072,'Darfari Skin Chestpiece','armor'),
 (52073,'Darfari Skin Bracers','armor'),
 (52074,'Darfari Skin Skirt','armor'),
 (52075,'Darfari Skin Greaves','armor'),
 (52076,'Darfari Speaker Mask','armor'),
 (52081,'Sandstorm Breathing Mask','armor'),
 (52092,'Chest Wrap','armor'),
 (52094,'Loin-cloth','armor'),
 (52101,'Zamorian Dancer Headdress','armor'),
 (52102,'Zamorian Dancer Blouse','armor'),
 (52103,'Zamorian Dancer Bracelets','armor'),
 (52104,'Zamorian Dancer Skirt','armor'),
 (52105,'Zamorian Dancer Anklets','armor'),
 (52202,'Coarse Tunic','armor'),
 (52203,'Coarse Handwraps','armor'),
 (52204,'Coarse Leggings','armor'),
 (52205,'Coarse Footwraps','armor'),
 (52212,'Leather Apron','armor'),
 (52213,'Leather Workgloves','armor'),
 (52221,'Shemite Turban','armor'),
 (52222,'Shemite Tunic','armor'),
 (52224,'Shemite Leggings','armor'),
 (52225,'Shemite Shoes','armor'),
 (52301,'Exceptional Light Turban','armor'),
 (52302,'Exceptional Light Chestpiece','armor'),
 (52303,'Exceptional Light Gauntlets','armor'),
 (52304,'Exceptional Light Wrap','armor'),
 (52305,'Exceptional Light Boots','armor'),
 (52401,'Flawless Light Turban','armor'),
 (52402,'Flawless Light Chestpiece','armor'),
 (52403,'Flawless Light Gauntlets','armor'),
 (52404,'Flawless Light Wrap','armor'),
 (52405,'Flawless Light Boots','armor'),
 (52501,'Setite Mask','armor'),
 (52502,'Setite Choker','armor'),
 (52504,'Setite Shendyt','armor'),
 (52505,'Setite Sandals','armor'),
 (52511,'Yoggite Watcher Mask','armor'),
 (52512,'Yoggite Skin Chestpiece','armor'),
 (52513,'Yoggite Skin Bracers','armor'),
 (52514,'Yoggite Skin Skirt','armor'),
 (52515,'Yoggite Skin Greaves','armor'),
 (52523,'Mitraen Gloves','armor'),
 (52524,'Mitraen Breeches','armor'),
 (52525,'Mitraen Shoes','armor'),
 (52532,'Black Hand Vest','armor'),
 (52534,'Black Hand Trousers','armor'),
 (53001,'Aloe Extract','consumable'),
 (53011,'Violet Cureall','consumable'),
 (53101,'Yellow Lotus Potion','consumable'),
 (53201,'Reaper Poison','consumable'),
 (53501,'Purified Flesh','consumable'),
 (53502,'Ambrosia','consumable'),
 (53503,'Set Antidote','consumable'),
 (53511,'Flinthead Bolts','consumable'),
 (53512,'Ironhead Bolts','consumable'),
 (53513,'Razor Bolts','consumable'),
 (53514,'Fire Bolts','consumable'),
 (53611,'Flinthead Arrows','consumable'),
 (53612,'Ironhead Arrows','consumable'),
 (53613,'Razor Arrows','consumable'),
 (53614,'Fire Arrows','consumable'),
 (53651,'Snake Arrows','consumable'),
 (55001,'True Name of Set','consumable'),
 (55002,'True Name of Yog','consumable'),
 (55003,'True Name of Mitra','consumable'),
 (55100,'Manifestation of Zeal','consumable'),
 (60001,'Eyes of Hanuman','consumable'),
 (80101,'Bed','building'),
 (80102,'Bed - Folded','building'),
 (80103,'Bed - Stygian','building'),
 (80111,'Rawhide Bedroll','building'),
 (80112,'Fiber Bedroll','building'),
 (80131,'Water Well','building'),
 (80132,'Large Water Well','building'),
 (80152,'Archery Target','building'),
 (80171,'Spike','building'),
 (80201,'Table','building'),
 (80202,'Table - Round','building'),
 (80210,'Simple Palisade','building'),
 (80211,'Wall Palisade','building'),
 (80251,'Square Stool','building'),
 (80252,'Round Stool','building'),
 (80253,'Woven Stool','building'),
 (80261,'Chair','building'),
 (80271,'Log Bench','building'),
 (80281,'Stone Throne','building'),
 (80301,'Wooden Signpost','building'),
 (80302,'Wall Sign','building'),
 (80311,'Papyrus Scroll','building'),
 (80501,'Standing Torch','building'),
 (80504,'Set Brazier','building'),
 (80511,'Bracketed Torch','building'),
 (80515,'Wall Lantern','building'),
 (80521,'Candle Stub','building'),
 (80522,'White Candle','building'),
 (80523,'Black Candle','building'),
 (80531,'Radium Gem','building'),
 (80551,'Tapestry','building'),
 (80571,'Awning','building'),
 (80601,'Carpet','building'),
 (80621,'Hide Rug','building'),
 (80631,'Pillow','building'),
 (80651,'Earthenware Jug','building'),
 (80661,'Iron Pot','building'),
 (80662,'Mortarium','building'),
 (80663,'Iron Pan','building'),
 (80671,'Barrel','building'),
 (80673,'Ale Keg','building'),
 (80695,'Shelf','building'),
 (80701,'Stygian Flag','building'),
 (80721,'Small Banner','building'),
 (80722,'Medium Banner','building'),
 (80733,'Large Banner','building'),
 (80751,'Gong','building'),
 (80752,'Horn','building'),
 (80753,'Darfari Wind Chimes','building'),
 (80851,'Wooden Box','building'),
 (80852,'Large Chest','building'),
 (80853,'Vault','building'),
 (80901,'Explosive Jar','building'),
 (80911,'Iron Leg-hold Trap','building'),
 (80913,'Wooden Leg-hold Trap','building'),
 (80951,'Sepulcher of Set','building'),
 (80952,'Altar of Set','building'),
 (80953,'Sanctum of Set','building'),
 (80961,'Pit of Yog','building'),
 (80962,'Rift of Yog','building'),
 (80963,'Abyss of Yog','building'),
 (80971,'Shrine of Mitra','building'),
 (80972,'Santuary of Mitra','building'),
 (80973,'Temple of Mitra','building'),
 (80975,'Statue of Refreshment','building'),
 (80976,'Statue of Guidance','building'),
 (81001,'White Rhino Head Trophy','building'),
 (81002,'Black Rhino Head Trophy','building'),
 (81003,'Rhino King Head Trophy','building'),
 (81004,'Grey Rhino Head Trophy','building'),
 (81005,'Gazelle Head Trophy','building'),
 (81006,'Kudo Head Trophy','building'),
 (81007,'Antelope Head Trophy','building'),
 (81008,'Rocknose Head Trophy','building'),
 (81009,'King Rocknose Head Trophy','building'),
 (82001,'White Rhino Head','building'),
 (82002,'Black Rhino Head','building'),
 (82003,'Rhino King Head','building'),
 (82004,'Grey Rhino Head','building'),
 (82005,'Gazelle Head','building'),
 (82006,'Kudu Head','building'),
 (82007,'Antelope Head','building'),
 (82008,'Rocknose Head','building'),
 (82009,'King Rocknose Head','building'),
 (89001,'Campfire','building'),
 (89010,'Bonfire','building'),
 (89101,'Furnace','building'),
 (89103,'Firebowl Cauldron','building'),
 (89104,'Tannery','building'),
 (89201,'Armorers Bench','building'),
 (89301,'Blacksmiths Bench','building'),
 (89401,'Carpenters Bench','building'),
 (89911,'Lesser Wheel of Pain','building'),
 (89912,'Wheel of Pain','building'),
 (89913,'Greater Wheel of Pain','building'),
 (90001,'Sandstone Foundation','building'),
 (90002,'Sandstone Wall','building'),
 (90003,'Sandstone Ceiling','building'),
 (90004,'Sandstone DoorFrame','building'),
 (90005,'Sandstone Stairs','building'),
 (90006,'Sandstone Triangle','building'),
 (90007,'Sandstone Frame','building'),
 (90008,'Simple Wooden Door','building'),
 (90009,'Sandstone Pillar','building'),
 (90010,'Sandstone Fence','building'),
 (90011,'Sandstone Triangle Foundation','building'),
 (90013,'Thatch Sloped Roof','building'),
 (90014,'Thatch Wedge Sloped Roof','building'),
 (90015,'Left-sloping Sandstone Wall','building'),
 (90017,'Right-sloping Sandstone Wall','building'),
 (90018,'Inverted Thatch Wedge Sloped Roof','building'),
 (90019,'Sandstone Window','building'),
 (90020,'Sandstone Fence Foundation','building'),
 (90101,'Stonebrick Foundation','building'),
 (90102,'Stonebrick Wall','building'),
 (90103,'Stonebrick Ceiling','building'),
 (90104,'Stonebrick Doorframe','building'),
 (90105,'Stonebrick Stairs','building'),
 (90106,'Stonebrick Wedge','building'),
 (90107,'Stonebrick Frame','building'),
 (90108,'Reinforced Wooden Door','building'),
 (90109,'Stonebrick Piller','building'),
 (90110,'Stonebrick Fence','building'),
 (90111,'Stonebrick Wedge Foundation','building'),
 (90113,'Wooden Sloped Roof','building'),
 (90114,'Wooden Wedge Sloped Roof','building'),
 (90115,'Left-sloping Stonebrick Wall','building'),
 (90117,'Right-sloping Stonebrick Wall','building'),
 (90118,'Inverted Wooden Wedge Sloped Roof','building'),
 (90120,'Stonebrick Fence Foundation','building'),
 (90121,'Stonebrick Gateway','building'),
 (90122,'Stonebrick Gate','building'),
 (90201,'Reinforced Stone Foundation','building'),
 (90202,'Reinforced Stone Wall','building'),
 (90203,'Reinforced Stone Ceiling','building'),
 (90204,'Reinforced Stone Doorway','building'),
 (90205,'Reinforced Stone Stairs','building'),
 (90206,'Reinforced Stone Wedge','building'),
 (90207,'Reinforced Stone Frame','building'),
 (90208,'Heavy Reinforced Door','building'),
 (90209,'Reinforced Stone Pillar','building'),
 (90210,'Reinforced Stone Fence','building'),
 (90211,'Reinforced Stone Wedge Foundation','building'),
 (90213,'Tiled Sloped Roof','building'),
 (90214,'Tiled Wedge Sloped Roof','building'),
 (90215,'Left-sloping Reinforced Stone Wall','building'),
 (90217,'Right-sloping Reinforced Stone Wall','building'),
 (90218,'Inverted Tiled Wedge Sloped Roof','building'),
 (90220,'Reinforced Stone Fence Foundation','building'),
 (90221,'Reinforced Stone Gateway','building'),
 (90222,'Reinforced Stone Gateway','building'),
 (80104,'Double Bed','building'),
 (80203,'Rock Slab','building'),
 (80204,'Table-Rectangle (Variation)','building'),
 (80205,'Low Wooden Table','building'),
 (80206,'Table - Rectangle (Variation)','building'),
 (80262,'Wooden Chair','building'),
 (80263,'Comfortable Chair','building'),
 (80272,'Wooden Bench','building'),
 (80312,'Decorative Bowl','building'),
 (80313,'Note','building'),
 (80314,'Journal','building'),
 (80315,'Note','building'),
 (80316,'Note','building'),
 (80502,'Protected Torch','building'),
 (80503,'Stygian Tripod Brazier','building'),
 (80505,'Iron Brazier','building'),
 (80506,'Wall Brazier','building'),
 (80507,'Hanging Brazier','building'),
 (80508,'Hanging Brazier','building'),
 (80509,'Cimmerian Brazier','building'),
 (80524,'Black Candle Stub','building'),
 (80525,'Candleholder','building'),
 (80552,'Tapestry','building'),
 (80622,'Large Carpet','building'),
 (80623,'Blue Stygian Carpet','building'),
 (80624,'Green Stygian Carpet','building'),
 (80625,'Orange Stygian Carpet','building'),
 (80664,'Large Earthenware Jug','building'),
 (80665,'Large Earthenware Jug','building'),
 (80666,'Large Earthenware Jug','building'),
 (80667,'Iron Bowl','building'),
 (80668,'Iron Bowl','building'),
 (80669,'Iron Bowl','building'),
 (80670,'Small Barrel','building'),
 (80700,'Iron Mug','building'),
 (80702,'Iron Tankard','building'),
 (80703,'Iron Pitcher','building'),
 (80704,'Iron Decanter','building'),
 (80705,'Iron Plate','building'),
 (80706,'Iron Plate','building'),
 (80707,'Wooden Bowl','building'),
 (80708,'Wooden Bowl','building'),
 (80709,'Wooden Bowl','building'),
 (80734,'Darfari Banner','building'),
 (80735,'Darfari Banner','building'),
 (80736,'Darfari Banner','building'),
 (80737,'Dogs of the Desert Banner','building'),
 (80738,'Black Hand Banner','building'),
 (80739,'Relic Hunter Banner','building'),
 (80740,'Darfari Banner','building'),
 (80741,'Skeletal Decoration','building'),
 (80742,'Fireplace and Hearth','building'),
 (80743,'Cupboard','building'),
 (80744,'Stygian Brazier','building'),
 (80745,'Cauldron','building'),
 (80746,'Tea Pot','building'),
 (80747,'Stygian Eathenware Jug','building'),
 (80748,'Stygian Metal Jug','building'),
 (80749,'Stygian Drum','building'),
 (80750,'Stygian Brazier','building'),
 (80754,'Drum','building'),
 (80755,'Large Darfari Wind Chimes','building'),
 (80756,'Bed - Stygian','building'),
 (80757,'Statue of Ymir','building'),
 (80758,'Nordheimer Horn','building'),
 (80811,'Ladder','building'),
 (80914,'Vapor Trap','building'),
 (80915,'Exploding Trap','building'),
 (80974,'Altar of Ymir','building'),
 (80977,'Blooded Altar of Ymir','building'),
 (80978,'Exalted Altar of Ymir','building'),
 (81010,'Shaleback Hatchling Decoration','building'),
 (81011,'Bat Demon Head Trophy','building'),
 (81012,'Crocodile Head Trophy','building'),
 (81013,'Hyena Head Trophy','building'),
 (81014,'Shaleback Head Trophy','building'),
 (81015,'Shaleback King Head Trophy','building'),
 (81016,'Demonic Shaleback Head Trophy','building'),
 (81017,'Undead Hyena Head Trophy','building'),
 (81018,'Skeletal Serpentman Head Trophy','building'),
 (81019,'Kingslayer Polearm','weapon'),
 (82010,'Bat Demon Head','building'),
 (82011,'Crocodile Head','building'),
 (82012,'Hyena Head','building'),
 (82013,'Shaleback Head','building'),
 (82014,'Shaleback King Head','building'),
 (82015,'Demonic Shaleback Head','building'),
 (82016,'Undead Hyena Head','building'),
 (82017,'Skeletal Serpentman Head','building'),
 (82018,'Elk King Head','building'),
 (82019,'Black Bear Trophy','building'),
 (82020,'Black Bear Head','building'),
 (82021,'Deer Trophy','building'),
 (82022,'Deer Head','building'),
 (82023,'Mammoth Trophy','building'),
 (82024,'Mammoth Head','building'),
 (82025,'Mountain Goat Trophy','building'),
 (82026,'Mountain Goat Head','building'),
 (82027,'Wild Boar Trophy','building'),
 (82028,'Wild Boar Head','building'),
 (82030,'Wolf Trophy','building'),
 (82031,'Wolf Head','building'),
 (82032,'Dire Wolf Trophy','building'),
 (82033,'Dire Wolf Head','building'),
 (82034,'Elk Trophy','building'),
 (82035,'Elk Head','building'),
 (82036,'Elk King Head','building'),
 (82037,'Brown Bear Trophy','building'),
 (82038,'Brown Bear Head','building'),
 (82039,'Panther Head','building'),
 (82040,'Panther Trophy','building'),
 (82041,'Sabertooth Head','building'),
 (82042,'Sabertooth Trophy','building'),
 (82043,'Red Dragon Head','building'),
 (82044,'Green Dragon Head','building'),
 (82045,'Red Dragon Trophy','building'),
 (82046,'Green Dragon Trophy','building'),
 (88892,'Impaled Skull','building'),
 (88893,'Vanir Totem','building'),
 (88894,'Vanir Totem','building'),
 (88895,'Vanir Totem','building'),
 (88896,'Vanir Totem','building'),
 (88897,'Srygian Earthenware Jug','building'),
 (88898,'Srygian Earthenware Jug','building'),
 (88899,'Folding Screen','building'),
 (88900,'Stygian Table','building'),
 (88901,'Round Stygian Table','building'),
 (88902,'Triple-Slot Weapon Display Rack','building'),
 (88903,'Single-Slot Weapon Display Rack','building'),
 (88904,'Shield Display Rack','building'),
 (89011,'Large Campfire','building'),
 (89801,'Siege Foundation','building'),
 (89811,'Trebuchet Base','building'),
 (89812,'Trebuchet Frame','building'),
 (89813,'Trebuchet','building'),
 (89851,'Siege Boulder','building'),
 (89852,'Demon-Fire Barrage','building'),
 (90023,'Thatch Sloped Roof Corner','building'),
 (90024,'Wooden Sloped Roof Corner','building'),
 (90025,'Reinforced Wooden Sloped Roof Corner','building'),
 (90026,'Inverted Thatch Sloped Roof Corner','building'),
 (90027,'Inverted Wooden Sloped Roof Corner','building'),
 (90028,'Inverted Reinforced Wooden Sloped Roof Corner','building'),
 (90029,'Thatch Rooftop End','building'),
 (90030,'Wooden Rooftop End','building'),
 (90031,'Reinforced Wooden Rooftop End','building'),
 (90032,'Thatch Rooftop','building'),
 (90034,'Reinforced Wooden Rooftop','building'),
 (90035,'Thatch Rooftop Corner','building'),
 (90036,'Wooden Rooftop Corner','building'),
 (90037,'Reinforced Wooden Rooftop Corner','building'),
 (90038,'Thatch Rooftop Junction','building'),
 (90039,'Wooden Rooftop Junction','building'),
 (90033,'Wooden Rooftop','building'),
 (90040,'Reinforced Wooden Rooftop Junction','building'),
 (90041,'Thatch Rooftop Intersection','building'),
 (90042,'Wooden Rooftop Intersection','building'),
 (90043,'Reinforced Wooden Rooftop Intersection','building'),
 (90044,'Thatch Rooftop Cap','building'),
 (90045,'Wooden Rooftop Cap','building'),
 (90046,'Reinforced Wooden Rooftop Cap','building'),
 (90047,'Thatched Awning','building'),
 (90048,'Thatched Awning Corner','building'),
 (90049,'Insulated Wooden Sloped Roof Corner','building'),
 (90050,'Black Ice-Reinforced Sloped Roof Corner','building'),
 (90051,'Inverted Insulated Wooden Sloped Roof Corner','building'),
 (90052,'Inverted Black Ice-Reinforced Sloped Roof Corner','building'),
 (90053,'Insulated Wood Rooftop End','building'),
 (90054,'Black Ice-Reinforced Rooftop End','building'),
 (90055,'Insulated Wood Rooftop','building'),
 (90056,'Black Ice-Reinforced Rooftop','building'),
 (90057,'Insulated Wood Rooftop Corner','building'),
 (90058,'Black Ice-Reinforced Rooftop Corner','building'),
 (90059,'Insulated Wood Rooftop Junction','building'),
 (90060,'Black Ice-Reinforced Rooftop Junction','building'),
 (90061,'Insulated Wood Rooftop Intersection','building'),
 (90062,'Black Ice-Reinforced Rooftop Intersection','building'),
 (90063,'Insulated Wood Rooftop Cap','building'),
 (90064,'Black Ice-Reinforced Rooftop Cap','building'),
 (90065,'Wooden Awning','building'),
 (90066,'Wooden Awning Corner','building'),
 (90067,'Reinforced Wooden Awning','building'),
 (90068,'Reinforced Wooden Awning Corner','building'),
 (90069,'Sandstone Stairs Corner','building'),
 (90070,'Stonebrick Stairs Corner','building'),
 (90071,'Reinforced Stone Stairs Corner','building'),
 (90072,'Insulated Wooden Stairs Corner','building'),
 (90073,'Black Ice-Reinforced Wooden Stairs Corner','building'),
 (90074,'Insulated Wood Awning','building'),
 (90075,'Insulated Wood Awning Corner','building'),
 (90076,'Reinforced Wooden Awning','building'),
 (90077,'Black Ice-Reinforced Awning Corner','building'),
 (90078,'Stonebrick Stairs','building'),
 (90079,'Reinforced Stone Stairs','building'),
 (90080,'Insulated Wooden Stairs','building'),
 (90081,'Black Ice-Reinforced Wooden Stairs','building'),
 (90223,'Reinforced Stone Crenelated Wall','building'),
 (90224,'Drawbridge','building'),
 (90225,'Elevator Vertical','building'),
 (90226,'Elevator Horizontal','building'),
 (90227,'Siege Cauldron','building'),
 (90243,'Insulated Wooden Foundation','building'),
 (90244,'Insulated Wooden Wall','building'),
 (90245,'Insulated Wooden Ceiling','building'),
 (90246,'Insulated Wooden Doorway','building'),
 (90247,'Insulated Wooden Stairs (rail)','building'),
 (90248,'Insulated Wooden Wedge','building'),
 (90249,'Insulated Wooden Frame','building'),
 (90250,'Insulated Wooden Door','building'),
 (90251,'Insulated Wooden Pillar','building'),
 (90252,'Insulated Wooden Fence','building'),
 (90253,'Insulated Wooden Wedge Foundation','building'),
 (90254,'Tiled Sloped Insulated Wooden Roof','building'),
 (90255,'Tiled Wedge Insulated Wooden Sloped Roof','building'),
 (90256,'Left-sloping Insulated Wooden Wall','building'),
 (90257,'Right-sloping Insulated Wooden Wall','building'),
 (90258,'Inverted Tiled Wedge Insulated Wooden Sloped Roof','building'),
 (90260,'Insulated Wooden Fence Foundation','building'),
 (90261,'Insulated Wooden Gateway','building'),
 (90262,'Insulated Wooden Gate','building'),
 (90263,'Black Ice-Reinforced Wooden Foundation','building'),
 (90264,'Black Ice-Reinforced Wooden Wall','building'),
 (90265,'Black Ice-Reinforced Wooden Ceiling','building'),
 (90266,'Black Ice-Reinforced Wooden Doorway','building'),
 (90267,'Black Ice-Reinforced Wooden Stairs (rail)','building'),
 (90268,'Black Ice-Reinforced Wooden Wedge','building'),
 (90269,'Black Ice-Reinforced Wooden Frame','building'),
 (90270,'Black Ice-Reinforced Wooden Door','building'),
 (90271,'Black Ice-Reinforced Wooden Pillar','building'),
 (90272,'Black Ice-Reinforced Wooden Fence','building'),
 (90273,'Black Ice-Reinforced Wooden Wedge Foundation','building'),
 (90274,'Tiled Sloped Black Ice-Reinforced Wooden Roof','building'),
 (90275,'Tiled Wedge Black Ice-Reinforced Wooden Sloped Roof','building'),
 (90276,'Left-sloping Black Ice-Reinforced Wooden Wall','building'),
 (90277,'Right-sloping Black Ice-Reinforced Wooden Wall','building'),
 (90278,'Inverted Tiled Wedge Black Ice-Reinforced Wooden Sloped Roof','building'),
 (90280,'Black Ice-Reinforced Wooden Fence Foundation','building'),
 (90281,'Black Ice-Reinforced Wooden Gateway','building'),
 (90282,'Black Ice-Reinforced Wooden Gate','building'),
 (90283,'Black Ice-Reinforced Crenelated Wall','building'),
 (90284,'Sandstone Hatch Frame','building'),
 (90285,'Stonebrick Hatch Frame','building'),
 (90286,'Reinforced Stone Hatch Frame','building'),
 (90287,'Insulated Wood Hatch Frame','building'),
 (90288,'Black Ice-Reinforced Hatch Frame','building'),
 (90289,'Hatch Door','building'),
 (90290,'Stonebrick Hatch Door','building'),
 (90291,'Reinforced Stone Hatch Door','building'),
 (90292,'Insulated Wood Hatch Door','building'),
 (90293,'Black Ice-Reinforced Hatch Door','building'),
 (90294,'Left-sloping Inverted Sandstone Wall','building'),
 (90295,'Left-sloping Inverted Stonebrick Wall','building'),
 (90296,'Left-sloping Inverted Reinforced Stone Wall','building'),
 (90297,'Left-sloping Inverted Insulated Wood Wall','building'),
 (90298,'Left-sloping Inverted Black Ice-Reinforced Wall','building'),
 (90299,'Right-sloping Inverted Sandstone Wall','building'),
 (90300,'Right-sloping Inverted Stonebrick Wall','building'),
 (90301,'Right-sloping Inverted Reinforced Stone Wall','building'),
 (90302,'Right-sloping Inverted Insulated Wood Wall','building'),
 (90303,'Right-sloping Inverted Black Ice-Reinforced Wall','building'),
 (10024,'Ice Shard','ingredient'),
 (12013,'Reptile Hide','ingredient'),
 (13600,'Cooked Abysmal Meat','consumable'),
 (14185,'Abysmal Eye','ingredient'),
 (14186,'Abysmal Fang','ingredient'),
 (14187,'Abysmal Flesh','ingredient'),
 (14190,'Grey-flower Lupine','ingredient'),
 (14191,'True Indigo','ingredient'),
 (14192,'Orange Phykos','ingredient'),
 (14193,'Cochineal','ingredient'),
 (14194,'False Mandrake','ingredient'),
 (14195,'Glowing Goop','ingredient'),
 (14196,'Sandbeast Bile Gland','ingredient'),
 (14197,'Glowing Essence','ingredient'),
 (14199,'Asura''s Glory','ingredient'),
 (14200,'Glass Flask','ingredient'),
 (14201,'Water-filled Glass Flask','ingredient'),
 (14601,'Glass Flask Mold','ingredient'),
 (15503,'Ancient Key','ingredient'),
 (15504,'Heart of the Kinscourge','ingredient'),
 (17001,'Dark Dye Colorant','ingredient'),
 (17002,'Light Dye Colorant','ingredient'),
 (17010,'Brown Dye','consumable'),
 (17011,'Light Brown Dye','consumable'),
 (17012,'Dark Brown Dye','consumable'),
 (17020,'Grey Dye','consumable'),
 (17021,'Light Grey Dye','consumable'),
 (17022,'Dark Grey Dye','consumable'),
 (17030,'Cyan Dye','consumable'),
 (17031,'Light Cyan Dye','consumable'),
 (17032,'Dark Cyan Dye','consumable'),
 (17040,'Red Dye','consumable'),
 (17041,'Light Red Dye','consumable'),
 (17042,'Dark Red Dye','consumable'),
 (17050,'Blue Dye','consumable'),
 (17051,'Light Blue Dye','consumable'),
 (17052,'Dark Blue Dye','consumable'),
 (17060,'Green Dye','consumable'),
 (17061,'Light Green Dye','consumable'),
 (17062,'Dark Green Dye','consumable'),
 (17070,'Yellow Dye','consumable'),
 (17071,'Light Yellow Dye','consumable'),
 (17072,'Dark Yellow Dye','consumable'),
 (17080,'Purple Dye','consumable'),
 (17081,'Light Purple Dye','consumable'),
 (17082,'Dark Purple Dye','consumable'),
 (17090,'Orange Dye','consumable'),
 (17091,'Light Orange Dye','consumable'),
 (17092,'Dark Orange Dye','consumable'),
 (17093,'Magenta Dye','consumable'),
 (17094,'Light Magenta Dye','consumable'),
 (17095,'Dark Magenta Dye','consumable'),
 (17096,'Olive Green Dye','consumable'),
 (17097,'Light Olive Green Dye','consumable'),
 (17098,'Dark Olive Green Dye','consumable'),
 (17099,'Ash Dye','consumable'),
 (17100,'Light Ash Dye','consumable'),
 (17101,'Dark Ash Dye','consumable'),
 (17102,'Cimmerian Blue Dye','consumable'),
 (17103,'Light Cimmerian Blue Dye','consumable'),
 (17104,'Dark Cimmerian Blue Dye','consumable'),
 (17105,'Muted Brown Dye','consumable'),
 (17106,'Light Muted Brown Dye','consumable'),
 (17107,'Dark Muted Brown Dye','consumable'),
 (17108,'Tan Dye','consumable'),
 (17109,'Light Tan Dye','consumable'),
 (17110,'Dark Tan Dye','consumable'),
 (17111,'Deep Red Dye','consumable'),
 (17112,'Midnight Blue Dye','consumable'),
 (17113,'Abyssal Violet Dye','consumable'),
 (17114,'Cursed Green Dye','consumable'),
 (18000,'Hops','ingredient'),
 (18001,'Leavening Agent','ingredient'),
 (18002,'Honey','ingredient'),
 (18005,'Highland Berries','ingredient'),
 (18006,'Desert Berries','ingredient'),
 (18007,'Shroom Amanita','ingredient'),
 (18008,'Puffball Mushroom','ingredient'),
 (18010,'Unappetizing Fish','consumable'),
 (18011,'Savory Fish','consumable'),
 (18012,'Exotic Fish','consumable'),
 (18013,'Dried Fish','consumable'),
 (18014,'Dried Meat','consumable'),
 (18020,'Unappetizing Shellfish','consumable'),
 (18021,'Savory Shellfish','consumable'),
 (18022,'Exotic Shellfish','consumable'),
 (18025,'Dry Wood','consumable'),
 (18030,'Resin','ingredient'),
 (18031,'Oil','ingredient'),
 (18032,'Highland Berry Pulp','ingredient'),
 (18033,'Desert Berry Pulp','ingredient'),
 (18040,'Ice','ingredient'),
 (18041,'Black Ice','ingredient'),
 (18052,'Fur','ingredient'),
 (18060,'Star Metal Ore','ingredient'),
 (18061,'Star Metal Bar','ingredient'),
 (18062,'Hardened Steel Bar','ingredient'),
 (18070,'Phykos Rum','consumable'),
 (18071,'Absinthe','consumable'),
 (18072,'Ale','consumable'),
 (18073,'Highland Wine','consumable'),
 (18074,'Cactus Wine','consumable'),
 (18075,'Firewater','consumable'),
 (18076,'Mead','consumable'),
 (18077,'Resin Wine','consumable'),
 (18078,'Wine','consumable'),
 (18079,'Honeyed Wine','consumable'),
 (18080,'Desert Wine','consumable'),
 (18081,'Shroom Beer','consumable'),
 (18188,'Volatile Gland','ingredient'),
 (18200,'Cooked Fish','consumable'),
 (18201,'Cooked Savory Fish','consumable'),
 (18202,'Cooked Exotic Fish','consumable'),
 (18203,'Cooked Shellfish','consumable'),
 (18204,'Cooked Savory Shellfish','consumable'),
 (18205,'Cooked Exotic Shellfish','consumable'),
 (18206,'Bread','consumable'),
 (18207,'Exotic Feast','consumable'),
 (18208,'Savory Feast','consumable'),
 (18209,'Oyster Omlette','consumable'),
 (18210,'Century Egg','consumable'),
 (18211,'Purified Water','consumable'),
 (18212,'Feast to Yog','consumable'),
 (18213,'Feral Feast','consumable'),
 (18214,'Bush Jerky','consumable'),
 (18215,'Corrupting Brew','consumable'),
 (18216,'Flavored Gruel','consumable'),
 (18217,'Spiced Haunch','consumable'),
 (18218,'Feast of Set','consumable'),
 (18219,'Spiced Oysters','consumable'),
 (18220,'Cooked Oyster','consumable'),
 (18221,'Berry Juice','consumable'),
 (18222,'Feast of Mitra','consumable'),
 (18223,'Meaty Mashup','consumable'),
 (18224,'Soup','consumable'),
 (18225,'Enhanced Gruel','consumable'),
 (18226,'Cleansing Brew','consumable'),
 (18227,'Spiced Tea','consumable'),
 (18228,'Herbal Tea','consumable'),
 (18229,'Trail Jerky','consumable'),
 (18230,'Steak and Eggs','consumable'),
 (18231,'Spiced Steak','consumable'),
 (18232,'Savory Jerky','consumable'),
 (18234,'Darfari Bug Soup','consumable'),
 (18235,'Spiced Soup','consumable'),
 (18236,'Aloe Soup','consumable'),
 (18237,'Seed Soup','consumable'),
 (18238,'Yellow Lotus Soup','consumable'),
 (18239,'Mushroom Soup','consumable'),
 (18240,'Roasted Mushrooms','consumable'),
 (18241,'Mulled Brew','consumable'),
 (18242,'Cimmerian Meal','consumable'),
 (18243,'Mushroom Tea','consumable'),
 (18245,'Demon Blood-Sausage','consumable'),
 (18233,'Meat Strips','consumable'),
 (18244,'Hearty Stew','consumable'),
 (18246,'Rhino Head Soup','consumable'),
 (18247,'Lasting Meal','consumable'),
 (18248,'Spiced Slivers','consumable'),
 (18249,'Exquisite Stew','consumable'),
 (18250,'Chili Desert Style','consumable'),
 (18251,'Hearty Meal','consumable'),
 (18252,'Bone Broth','consumable'),
 (18253,'Spiced and Shredded Roast','consumable'),
 (18254,'Bug Kabob','consumable'),
 (18255,'Spiced Egg','consumable'),
 (18256,'Egg Surpise','consumable'),
 (18257,'Cooked Eggs','consumable'),
 (18258,'Dried Berries','consumable'),
 (18259,'Salted Berries','consumable'),
 (18260,'Feast of Ymir','consumable'),
 (18261,'Oyster Flesh','consumable'),
 (18263,'Salt','consumable'),
 (18264,'Spice','consumable'),
 (18268,'Honeyglazed Roast','consumable'),
 (18269,'Honeyed Eggs','consumable'),
 (18270,'Mystery Meat Soup','consumable'),
 (18271,'Honeyed Gruel','consumable'),
 (18272,'Honey Jerky','consumable'),
 (18273,'Honeybread','consumable'),
 (18274,'Ice Tea','consumable'),
 (18400,'Healing Wraps','consumable'),
 (18401,'Numbing Wraps','consumable'),
 (18402,'Midnight Blue Flower','consumable'),
 (18500,'Beehive','building'),
 (18501,'Improved Beehive','building'),
 (18502,'Fish Trap','building'),
 (18503,'Shellfish Trap','building'),
 (18504,'Fermentation Barrel','building'),
 (18505,'Fluid Press','building'),
 (18506,'Dryer','building'),
 (18507,'Preservation box','building'),
 (18508,'Improved Preservation box','building'),
 (18509,'Stove','building'),
 (18510,'Grinder','building'),
 (18511,'Frost Temple Smithy','building'),
 (18512,'Artisan''s Worktable','building'),
 (18513,'Tanner''s Worktable','building'),
 (18514,'Torturer''s Worktable','building'),
 (30025,'XX_Plaseholder_Lore_1','consumable'),
 (30026,'XX_Plaseholder_Lore_2','consumable'),
 (30027,'XX_Plaseholder_Lore_3','consumable'),
 (30028,'XX_Plaseholder_Lore_4','consumable'),
 (30029,'XX_Plaseholder_Lore_5','consumable'),
 (30030,'XX_Plaseholder_Lore_6','consumable'),
 (30031,'XX_Plaseholder_Lore_7','consumable'),
 (30032,'XX_Plaseholder_Lore_8','consumable'),
 (30033,'XX_Plaseholder_Lore_9','consumable'),
 (30034,'XX_Plaseholder_Lore_10','consumable'),
 (30035,'XX_Plaseholder_Lore_11','consumable'),
 (30036,'XX_Plaseholder_Lore_12','consumable'),
 (30037,'XX_Plaseholder_Lore_13','consumable'),
 (30038,'XX_Plaseholder_Lore_14','consumable'),
 (30039,'XX_Plaseholder_Lore_15','consumable'),
 (30040,'XX_Plaseholder_Lore_16','consumable'),
 (30041,'XX_Plaseholder_Lore_17','consumable'),
 (30042,'XX_Plaseholder_Lore_18','consumable'),
 (30043,'XX_Plaseholder_Lore_19','consumable'),
 (30044,'XX_Plaseholder_Lore_20','consumable'),
 (54008,'King Rocknose Head Trophy','building'),
 (55004,'True Name of Ymir','consumable'),
 (56230,'Vanir Tasset','armor'),
 (70001,'Snake Idol','building'),
 (41020,'Simple Armor Patch Kit','consumable'),
 (41021,'Armor Patch Kit','consumable'),
 (41022,'Advanced Armor Patch Kit','consumable'),
 (41023,'Master Armor Patch Kit','consumable'),
 (41024,'Simple Weapon Repair Kit','consumable'),
 (41025,'Weapon Repair Kit','consumable'),
 (41026,'Advanced Weapon Repair Kit','consumable'),
 (41027,'Master Weapon Repair Kit','consumable'),
 (41028,'Steel Cleaver','weapon'),
 (41029,'Hardened Steel Cleaver','weapon'),
 (41030,'Star Metal Cleaver','weapon'),
 (41035,'Glowing Stick','weapon'),
 (41051,'Balanced Weapon Fitting','consumable'),
 (41052,'Simple Weapon Damage Kit','consumable'),
 (41053,'Weapon Damage Kit','consumable'),
 (41054,'Advanced Weapon Damage Kit','consumable'),
 (41055,'Weighted Weapon Fitting','consumable'),
 (41056,'Simple Tool Upgrade Kit','consumable'),
 (41057,'Tool Upgrade Kit','consumable'),
 (41058,'Advanced Tool Upgrade Kit','consumable'),
 (41059,'Simple Blunted Weapon Fitting','consumable'),
 (41060,'Blunted Weapon Fitting','consumable'),
 (41061,'Advanced Blunted Weapon Fitting','consumable'),
 (41063,'Paring Blade','consumable'),
 (41064,'Simple Weapon Reinforcement','consumable'),
 (41065,'Weapon Reinforcement','consumable'),
 (41066,'Advanced Weapon Reinforcement','consumable'),
 (41067,'Spiked Weapon Fitting','consumable'),
 (41068,'Armor Reduction Kit','consumable'),
 (41069,'Thin Armor Plating','consumable'),
 (41070,'Armor Plating','consumable'),
 (41071,'Thick Armor Plating','consumable'),
 (41072,'Simple Armor Rebalance Kit','consumable'),
 (41073,'Armor Rebalance Kit','consumable'),
 (41074,'Advanced Armor Rebalance Kit','consumable'),
 (41075,'Simple Armor Flexibility Kit','consumable'),
 (41076,'Armor Flexibility Kit','consumable'),
 (41077,'Advanced Armor Flexibility Kit','consumable'),
 (51014,'Hardened Steel Hatchet','weapon'),
 (51015,'Star Metal Hatchet','weapon'),
 (51022,'Hardened Steel Pick','weapon'),
 (51023,'Star Metal Pick','weapon'),
 (51040,'Steel Sickle','weapon'),
 (51041,'Hardened Steel Sickle','weapon'),
 (51042,'Star Metal Sickle','weapon'),
 (51066,'Telith''s Lament','weapon'),
 (51067,'Hoar-Frost Hatchet','weapon'),
 (51068,'Glacier-Crack','weapon'),
 (51069,'Star Metal Sword','weapon'),
 (51070,'Exceptional Star Metal Sword','weapon'),
 (51071,'Flawless Star Metal Sword','weapon'),
 (51072,'Deathbringer Axe','weapon'),
 (51073,'xx_Wight_Sword','weapon'),
 (51074,'xx_Wight_Axe','weapon'),
 (51154,'Steel Warhammer','weapon'),
 (51155,'Ancient Warhammer','weapon'),
 (51156,'Hardened Steel Hammer','weapon'),
 (51157,'Exceptional Hardened Steel Hammer','weapon'),
 (51158,'Flawless Hardened Steel Hammer','weapon'),
 (51159,'Star Metal Hammer','weapon'),
 (51160,'Exceptional Star Metal Hammer','weapon'),
 (51161,'Flawless Star Metal Hammer','weapon'),
 (51162,'Exceptional Iron Warhammer','weapon'),
 (51163,'Flawless Iron Warhammer','weapon'),
 (51164,'Exceptional Steel Warhammer','weapon'),
 (51165,'Flawless Steel Warhammer','weapon'),
 (51166,'Exceptional Iron Mace','weapon'),
 (51167,'Flawless Iron Mace','weapon'),
 (51168,'Exceptional Hunting Bow','weapon'),
 (51169,'Flawless Hunting Bow','weapon'),
 (51170,'Exceptional Heavy Crossbow','weapon'),
 (51171,'Flawless Heavy Crossbow','weapon'),
 (51172,'Exceptional Iron Pike','weapon'),
 (51173,'Flawless Iron Pike','weapon'),
 (51174,'Exceptional Steel Trident','weapon'),
 (51175,'Flawless Steel Trident','weapon'),
 (51176,'Exceptional Falcata','weapon'),
 (51177,'Flawless Falcata','weapon'),
 (51178,'Exceptional Cimmerian Battle-axe','weapon'),
 (51179,'Flawless Cimmerian Battle-axe','weapon'),
 (51180,'Exceptional Stygian Spear','weapon'),
 (51181,'Flawless Stygian Spear','weapon'),
 (51182,'Exceptional Steel Poniard','weapon'),
 (51183,'Flawless Steel Poniard','weapon'),
 (51184,'Bone Arrow','weapon'),
 (51185,'Bobe Bolt','weapon'),
 (51186,'Flanged Iron Mace','weapon'),
 (51187,'Exceptional Flanged Iron Mace','weapon'),
 (51188,'Flawless Flanged Iron Mace','weapon'),
 (51189,'Iron Corseque','weapon'),
 (51190,'Exceptional Iron Corseque','weapon'),
 (51191,'Flawless Iron Corseque','weapon'),
 (51195,'Iron War Axe','weapon'),
 (51196,'Exceptional Iron War Axe','weapon'),
 (51197,'Flawless Iron War Axe','weapon'),
 (51198,'Studded Iron Mace','weapon'),
 (51199,'Exceptional Studded Iron Mace','weapon'),
 (51200,'Flawless Studded Iron Mace','weapon'),
 (51971,'Demon-fire Orb','weapon'),
 (51209,'Steel Spear','weapon'),
 (51210,'Exceptional Steel Spear','weapon'),
 (51211,'Flawless Steel Spear','weapon'),
 (51212,'Ancient Axe','weapon'),
 (51972,'Grease Orb','weapon'),
 (51302,'Iron Mace','weapon'),
 (51305,'Steel Mace','weapon'),
 (51306,'Iron Truncheon','weapon'),
 (51307,'Steel Truncheon','weapon'),
 (51406,'Ancient Bow','weapon'),
 (51454,'Heavy Crossbow','weapon'),
 (51622,'Lantern Shield','weapon'),
 (51628,'Hardened Steel Shield','weapon'),
 (51629,'Exceptional Hardened Steel Shield','weapon'),
 (51630,'Flawless Hardened Steel Shield','weapon'),
 (51631,'Star Metal Shield','weapon'),
 (51632,'Exceptional Star Metal Shield','weapon'),
 (51633,'Flawless Star Metal Shield','weapon'),
 (51715,'Stone Pike','weapon'),
 (51723,'Star Metal Spear','weapon'),
 (51724,'Exceptional Star Metal Spear','weapon'),
 (51725,'Flawless Star Metal Spear','weapon'),
 (51726,'Hardened Steel Spear','weapon'),
 (51727,'Exceptional Hardened Steel Spear','weapon'),
 (51728,'Flawless Hardened Steel Spear','weapon'),
 (51827,'Saw','weapon'),
 (51828,'Adze','weapon'),
 (51829,'Carpentry Hammer','weapon'),
 (51830,'Drum','weapon'),
 (51841,'Hardened Steel Sword','weapon'),
 (51842,'Exceptional Hardened Steel Sword','weapon'),
 (51843,'Flawless Hardened Steel Sword','weapon'),
 (51852,'Iron Axe','weapon'),
 (51973,'Water Orb','weapon'),
 (51974,'Gaseous Orb','weapon'),
 (51957,'Abysmal Dagger','weapon'),
 (51958,'Abysmal Sword','weapon'),
 (51959,'Hardened Steel Dagger','weapon'),
 (51960,'Exceptional Hardened Steel Dagger','weapon'),
 (51966,'Flawless Hardened Steel Dagger','weapon'),
 (51967,'Star Metal Dagger','weapon'),
 (51968,'Exceptional Star Metal Dagger','weapon'),
 (51969,'Flawless Star Metal Dagger','weapon'),
 (51970,'Acheronian Sickle','weapon'),
 (51975,'Black Ice Longsword','weapon'),
 (51976,'Black Ice Broadsword','weapon'),
 (51977,'Black Ice Pick','weapon'),
 (51978,'Acheronian Pick','weapon'),
 (51979,'Acheronian Longsword','weapon'),
 (51980,'Exceptional Acheronian Longsword','weapon'),
 (51981,'Flawless Acheronian Longsword','weapon'),
 (51982,'Acheronian Spear','weapon'),
 (51983,'Exceptional Acheronian Spear','weapon'),
 (51984,'Flawless Acheronian Spear','weapon'),
 (51985,'Acheronian War-Axe','weapon'),
 (51986,'Exceptional Acheronian War-Axe','weapon'),
 (51987,'Flawless Acheronian War-Axe','weapon'),
 (52016,'Reptilian Helm','armor'),
 (52017,'Reptilian Gauntlets','armor'),
 (52018,'Reptilian Chestpiece','armor'),
 (52019,'Reptilian Tasset','armor'),
 (52020,'Reptilian Boots','armor'),
 (52026,'Exceptional Medium Cap','armor'),
 (52027,'Exceptional Medium Harness','armor'),
 (52028,'Exceptional Medium Gauntlets','armor'),
 (52029,'Exceptional Medium Tasset','armor'),
 (52030,'Exceptional Medium Boots','armor'),
 (52036,'Exceptional Heavy Helmet','armor'),
 (52037,'Exceptional Heavy Pauldron','armor'),
 (52038,'Exceptional Heavy Gauntlets','armor'),
 (52039,'Exceptional Heavy Tasset','armor'),
 (52040,'Exceptional Heavy Sabatons','armor'),
 (52056,'Flawless Medium Cap','armor'),
 (52057,'Flawless Medium Harness','armor'),
 (52058,'Flawless Medium Gauntlets','armor'),
 (52059,'Flawless Medium Tasset','armor'),
 (52060,'Flawless Medium Boots','armor'),
 (52061,'XX_Stygian Headdress','armor'),
 (52062,'XX_Stygian Vest','armor'),
 (52064,'XX_Stygian Shendyt','armor'),
 (52065,'XX_Stygian Sandals','armor'),
 (52066,'Flawless Heavy Helmet','armor'),
 (52067,'Flawless Heavy Pauldron','armor'),
 (52068,'Flawless Heavy Gauntlets','armor'),
 (52069,'Flawless Heavy Tasset','armor'),
 (52070,'Flawless Heavy Sabatons','armor'),
 (52293,'Climbing Gloves','armor'),
 (52295,'Climbing Boots','armor'),
 (52522,'Mitraen Tunic','armor'),
 (52541,'Relic Hunter Turban','armor'),
 (52542,'Relic Hunter Shirt','armor'),
 (52543,'Relic Hunter Gloves','armor'),
 (52544,'Relic Hunter Trousers','armor'),
 (52545,'Relic Hunter Boots','armor'),
 (52551,'Hyena Skull Helmet','armor'),
 (52552,'Hyena-fur Chestpiece','armor'),
 (52553,'Hyena-fur Gloves','armor'),
 (52554,'Hyena-fur Wrap','armor'),
 (52555,'Hyena-fur Boots','armor'),
 (52556,'Star Metal Helmet','armor'),
 (52557,'Star Metal Pauldron','armor'),
 (52558,'Star Metal Gauntlets','armor'),
 (52559,'Star Metal Tasset','armor'),
 (52560,'Star Metal Boots','armor'),
 (52561,'Hardened Steel Helmet','armor'),
 (52562,'Hardened Steel Pauldron','armor'),
 (52563,'Hardened Steel Gauntlets','armor'),
 (52564,'Hardened Steel Tasset','armor'),
 (52565,'Hardened Steel Boots','armor'),
 (52566,'Fur Helmet','armor'),
 (52567,'Fur Harness','armor'),
 (52568,'Fur Gauntlets','armor'),
 (52569,'Fur Tasset','armor'),
 (52570,'Fur Boots','armor'),
 (52571,'Exceptional Star Metal Helmet','armor'),
 (52572,'Exceptional Star Metal Pauldron','armor'),
 (52573,'Exceptional Star Metal Gauntlets','armor'),
 (52574,'Exceptional Star Metal Helmet','armor'),
 (52575,'Exceptional Star Metal Boots','armor'),
 (52576,'Exceptional Hardened Steel Helmet','armor'),
 (52577,'Exceptional Hardened Steel Pauldron','armor'),
 (52578,'Exceptional Hardened Steel Gauntlets','armor'),
 (52579,'Exceptional Hardened Steel Tasset','armor'),
 (52580,'Exceptional Hardened Steel Boots','armor'),
 (52581,'Exceptional Fur Helmet','armor'),
 (52582,'Exceptional Fur Harness','armor'),
 (52583,'Exceptional Fur Gauntlets','armor'),
 (52584,'Exceptional Fur Tasset','armor'),
 (52585,'Exceptional Fur Boots','armor'),
 (52586,'Flawless Star Metal Helmet','armor'),
 (52587,'Flawless Star Metal Pauldron','armor'),
 (52588,'Flawless Star Metal Gauntlets','armor'),
 (52589,'Flawless Star Metal Tasset','armor'),
 (52590,'Flawless Star Metal Boots','armor'),
 (52591,'Flawless Hardened Steel Helmet','armor'),
 (52592,'Flawless Hardened Steel Pauldron','armor'),
 (52593,'Flawless Hardened Steel Gauntlets','armor'),
 (52594,'Flawless Hardened Steel Tasset','armor'),
 (52595,'Flawless Hardened Steel Boots','armor'),
 (52596,'Flawless Fur Helmet','armor'),
 (52597,'Flawless Fur Harness','armor'),
 (52598,'Flawless Fur Gauntlets','armor'),
 (52599,'Flawless Fur Tasset','armor'),
 (52600,'Flawless Fur Boots','armor'),
 (52601,'Heavy Plated Helmet','armor'),
 (52602,'Horned Heavy Plated Helmet','armor'),
 (52603,'Silent Legion Helmet','armor'),
 (52604,'Silent Legion Pauldron','armor'),
 (52605,'Silent Legion Gauntlets','armor'),
 (52606,'Silent Legion Tasset','armor'),
 (52607,'Silent Legion Boots','armor'),
 (52610,'Winter''s Majesty','armor'),
 (52611,'Ymir''s Aegis','armor'),
 (52612,'Ymir''s Might','armor'),
 (52613,'Ymir''s Shanks','armor'),
 (52614,'Ymir''s Stride','armor'),
 (52615,'Vanir Fur Cap','armor'),
 (52616,'Vanir Fur Harness','armor'),
 (52617,'Vanir Fur Gauntlets','armor'),
 (52618,'Vanir Fur Tasset','armor'),
 (52619,'Vanir Fur Boots','armor'),
 (52620,'Exceptional Vanir Fur Cap','armor'),
 (52621,'Exceptional Vanir Fur Harness','armor'),
 (52622,'Exceptional Vanir Fur Gauntlets','armor'),
 (52623,'Exceptional Vanir Fur Tasset','armor'),
 (52624,'Exceptional Vanir Fur Boots','armor'),
 (52625,'Flawless Vanir Fur Cap','armor'),
 (52626,'Flawless Vanir Fur Harness','armor'),
 (52627,'Flawless Vanir Fur Gauntlets','armor'),
 (52628,'Flawless Vanir Fur Tasset','armor'),
 (52629,'Flawless Vanir Fur Boots','armor'),
 (52630,'Aquilonian Helmet','armor'),
 (52631,'Aquilonian Chestplate','armor'),
 (52632,'Aquilonian Bracers','armor'),
 (52633,'Aquilonian Tasset','armor'),
 (52634,'Aquilonian Sandals','armor'),
 (52635,'Exceptional Aquilonian Helmet','armor'),
 (52636,'Exceptional Aquilonian Chestplate','armor'),
 (52637,'Exceptional Aquilonian Bracers','armor'),
 (52638,'Exceptional Aquilonian Tasset','armor'),
 (52639,'Exceptional Aquilonian Sandals','armor'),
 (52640,'Flawless Aquilonian Helmet','armor'),
 (52641,'Flawless Aquilonian Chestplate','armor'),
 (52642,'Flawless Aquilonian Bracers','armor'),
 (52643,'Flawless Aquilonian Tasset','armor'),
 (52644,'Flawless Aquilonian Sandals','armor'),
 (52911,'Medium Helmet Padding','armor'),
 (52912,'Medium Chest Padding','armor'),
 (52913,'Medium Gauntlet Lining','armor'),
 (52914,'Medium Legging Lining','armor'),
 (52915,'Medium Boot Lining','armor'),
 (52916,'Heavy Helmet Padding','armor'),
 (52917,'Heavy Chest Padding','armor'),
 (52918,'Heavy Gauntlet Lining','armor'),
 (52919,'Heavy Legging Lining','armor'),
 (52920,'Heavy Boot Lining','armor'),
 (52921,'Light Helmet Padding','armor'),
 (52922,'Light Chest Padding','armor'),
 (52932,'Light Gloves Lining','armor'),
 (52933,'Light Legging Lining','armor'),
 (52934,'Light Boot Lining','armor'),
 (52935,'Zamorian Thief Hood','armor'),
 (52936,'Zamorian Thief Chest','armor'),
 (52937,'Zamorian Thief Gauntlets','armor'),
 (52938,'Zamorian Thief Breeches','armor'),
 (52939,'Zamorian Thief Boots','armor'),
 (52940,'Exceptional Zamorian Thief Hood','armor'),
 (52941,'Exceptional Zamorian Thief Chest','armor'),
 (52942,'Exceptional Zamorian Thief Gauntlets','armor'),
 (52943,'Exceptional Zamorian Thief Breeches','armor'),
 (52944,'Exceptional Zamorian Thief Boots','armor'),
 (52945,'Flawless Zamorian Thief Hood','armor'),
 (52946,'Flawless Zamorian Thief Chest','armor'),
 (52947,'Flawless Zamorian Thief Gauntlets','armor'),
 (52948,'Flawless Zamorian Thief Breeches','armor'),
 (52949,'Flawless Zamorian Thief Boots','armor'),
 (52950,'Hyperborean Slaver Waistguard','armor'),
 (52951,'Hyperborean Slaver Bracers','armor'),
 (52952,'Exceptional Hyperborean Slaver Waistguard','armor'),
 (52953,'Exceptional Hyperborean Slaver Bracers','armor'),
 (52954,'Flawless Hyperborean Slaver Waistguard','armor'),
 (52955,'Flawless Hyperborean Slaver Bracers','armor'),
 (53102,'Beathing Potion','consumable'),
 (53202,'XX_Demon''s Bane','consumable'),
 (53652,'Abysmal Arrows','consumable'),
 (53653,'Abysmal Bolts','consumable'),
 (53654,'Hardened Steel Arrow','consumable'),
 (53655,'Hardened Steel Bolt','consumable'),
 (53656,'Star Metal Arrow','consumable'),
 (53657,'Star Metal Bolt','consumable'),
 (53658,'Ice Shard Arrows','consumable'),
 (53659,'Ice Shard Bolts','consumable');
 
CREATE VIEW IF NOT EXISTS`Item_Ownership_Info` AS 
select
  player_guild_name,
  ItemName,
  sum(item_count) as item_count 
from
  (
    select
      pb.name as player_guild_name,
      x.Name as ItemName,
      case
        when
          substr(hex(data), length(hex(data)) - 31, 1) = 'A' 
        then
          11 
        else
          case
            when
              substr(hex(data), length(hex(data)) - 31, 1) = 'B' 
            then
              12 
            else
              case
                when
                  substr(hex(data), length(hex(data)) - 31, 1) = 'C' 
                then
                  13 
                else
                  case
                    when
                      substr(hex(data), length(hex(data)) - 31, 1) = 'D' 
                    then
                      14 
                    else
                      case
                        when
                          substr(hex(data), length(hex(data)) - 31, 1) = 'E' 
                        then
                          15 
                        else
                          cast(substr(hex(data), length(hex(data)) - 31, 1) as Int) 
                      end
                  end
              end
          end
      end
      * 16 + 
      case
        when
          substr(hex(data), length(hex(data)) - 30, 1) = 'A' 
        then
          11 
        else
          case
            when
              substr(hex(data), length(hex(data)) - 30, 1) = 'B' 
            then
              12 
            else
              case
                when
                  substr(hex(data), length(hex(data)) - 30, 1) = 'C' 
                then
                  13 
                else
                  case
                    when
                      substr(hex(data), length(hex(data)) - 30, 1) = 'D' 
                    then
                      14 
                    else
                      case
                        when
                          substr(hex(data), length(hex(data)) - 30, 1) = 'E' 
                        then
                          15 
                        else
                          cast(substr(hex(data), length(hex(data)) - 30, 1) as Int) 
                      end
                  end
              end
          end
      end
      as item_count 
    from
      item_inventory as i 
      inner join
        actor_position ap 
        on i.owner_id = ap.id 
      inner join
        buildings b 
        on b.object_id = ap.id 
      inner join
        cust_item_xref x 
        on x.template_id = i.template_id 
      inner join
        (
          Select
            guildid as pb_id,
            name 
          from
            guilds 
          Union
          select
            id,
            char_name 
          from
            characters
        )
        pb 
        on b.owner_id = pb_id 
    where
      inv_type = 4 
  )
  iq 
group by
  player_guild_name,
  ItemName;
create table if not exists zpet_ownership(pet_id bigint not null, player_owner_id bigint not null, clan_owner_id bigint not null);
create table if not exists zthrall_ownership(thrall_id bigint not null, player_owner_id bigint not null, clan_owner_id bigint not null);
DROP VIEW IF EXISTS Detailed_Player_Inventory;
CREATE VIEW `Detailed_Player_Inventory` AS 
select
quote(i.owner_id) as Player_Id, quote(cx.name) as Item_Name, quote(i.template_id) as Item_Id, quote(c.char_name) as player_name
from
   characters as c,
   cust_item_xref as cx
left outer join
   item_inventory as i
      on i.template_id = cx.template_id and i.owner_id = c.id WHERE inv_type = 0 or inv_type = 1 or inv_type = 2  
order by
   c.id;
   
   
DROP VIEW IF EXISTS Detailed_Structure_Inventory;
CREATE VIEW `Detailed_Structure_Inventory` AS 
select
   quote(i.owner_id) as owner_id, quote(cx.name) as ItemName, quote(i.template_id) as template_id
from
   item_inventory as i
left outer join
      cust_item_xref as cx 
      on i.template_id = cx.template_id WHERE inv_type = 4  
order by
   i.owner_id;

--This pulls specific stat data pertaining to stat point amounts, feat points, current level, how much weight currently carrying and current health
DROP VIEW IF EXISTS Detailed_Player_Stats;
CREATE VIEW `Detailed_Player_Stats` AS SELECT Distinct (SELECT c.char_name) AS Player_Name, (SELECT c.id) AS Player_ID, (SELECT cs.stat_value WHERE cs.stat_id = 19 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Agility, (SELECT cs.stat_value WHERE cs.stat_id = 17 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Strength, (SELECT cs.stat_value WHERE cs.stat_id = 14 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Vitality, (SELECT cs.stat_value WHERE cs.stat_id = 18 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Accuracy, (SELECT cs.stat_value WHERE cs.stat_id = 15 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Grit, (SELECT cs.stat_value WHERE cs.stat_id = 16 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Encumbrance, (SELECT cs.stat_value WHERE cs.stat_id = 20 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Survival, (SELECT cs.stat_value WHERE cs.stat_id = 1 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Current_Health, (SELECT cs.stat_value WHERE cs.stat_id = 12 AND cs.stat_type = 1 AND cs.char_id = c.id) AS Current_Weight, (SELECT cs.stat_value WHERE cs.stat_id = 4 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Current_Level, (SELECT cs.stat_value WHERE cs.stat_id = 3 AND cs.stat_type = 0 AND cs.char_id = c.id) AS Feat_Points FROM character_stats AS cs, characters AS c order by Agility desc, Strength desc, Vitality desc, Accuracy desc, Grit desc, Encumbrance desc, Survival desc, Current_Health desc, Current_Weight desc, Current_Level desc, Feat_Points;

--To inspect a specific player using the Detailed Player Stats view
SELECT * FROM Detailed_Player_Stats WHERE Player_Name LIKE '%PLAYER_NAME_HERE%';

--Run this to see if anyone is actually over 50 stat points in any category
SELECT * FROM Detailed_Player_Stats WHERE Agility > 50 OR Strength > 50 OR Vitality > 50 OR Accuracy > 50 OR Grit > 50 OR Encumbrance > 50 OR Survival > 50;

