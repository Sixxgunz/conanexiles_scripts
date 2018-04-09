--This is only a prototype as I'm still testing performance issues and accuracy - Use at your own risk

--Here we alter the destruction history table
ALTER TABLE destruction_history ADD COLUMN Time_Destroyed timestamp DEFAULT NULL /* replace me */;
UPDATE destruction_history SET Time_Destroyed = CURRENT_TIMESTAMP;
PRAGMA writable_schema = on;
UPDATE sqlite_master
SET sql = replace(sql, 'DEFAULT NULL /* replace me */',
                       'DEFAULT CURRENT_TIMESTAMP')
WHERE type = 'table'
  AND name = 'destruction_history';
PRAGMA writable_schema = off;

--Now we add the trigger
DROP TRIGGER IF EXISTS Log_Destruction_Time;
CREATE TRIGGER Log_Destruction_Time
AFTER
UPDATE
  ON destruction_history FOR EACH ROW BEGIN
UPDATE
  destruction_history
SET
  Time_Destroyed = CURRENT_TIMESTAMP
WHERE
  destroyed_by = new.destroyed_by
  and owner_id = old.owner_id
  and (
    object_type = new.object_type
    OR object_id = new.object_id
  );END
