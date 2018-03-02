--RUN THIS TO SWAP STEAM ID'S WITH PLAYERS FOR RANDOM INSPECTION OR REMOVAL PURPOSES
--This first line gives the admin the player character
UPDATE `characters` SET `playerId`='INSPECTING_ADMIN_STEAM_ID'  WHERE `char_name`='DETAINED_PLAYER_NAME';
--This second line gives the player the admin character
UPDATE `characters` SET `playerId`='DETAINED_PLAYER_STEAM_ID'  WHERE `char_name`='INSPECTING_ADMIN_NAME';

--Now we reverse the steam ID Swap
--RUN THIS TO SWAP STEAM ID'S BACK TO ORIGINAL OWNER AFTER INSPECTION HAS BEEN PERFORMED
UPDATE `characters` SET `playerId`='INSPECTING_ADMIN_STEAM_ID'  WHERE `char_name`='INSPECTING_ADMIN_NAME';
UPDATE `characters` SET `playerId`='DETAINED_PLAYER_STEAM_ID'  WHERE `char_name`='DETAINED_PLAYER_NAME';