--Use top section at your own risk, the uncommented section is the maintenance section.
/*
PRAGMA default_cache_size=700000;
PRAGMA cache_size=700000;
PRAGMA PAGE_SIZE = 4096;
PRAGMA auto_vacuum = FULL;
*/
VACUUM;
REINDEX;
ANALYZE;
pragma integrity_check;
.quit
