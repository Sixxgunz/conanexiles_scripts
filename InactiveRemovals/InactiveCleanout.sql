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

delete from item_inventory where template_id in ('80152','51201','51202','51203','51215','51912','51932','51933','51934','51938','51939','51940','51943','51944','51945','51946','53735');

delete from item_inventory where owner_id in (select distinct id from actor_position where class like '%corpse%');
delete from actor_position where class like '%Corpse%';

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

VACUUM;
REINDEX;
ANALYZE;
pragma integrity_check;
.quit