# Databases

## Postgres

### Check potentially long running transactions
Table details [can be found here](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).
`xact_start` is when the transaction started, `query_start` is when the query in the transaction started.
```sql
select * 
from pg_stat_activity
where (state = 'idle in transaction')
and xact_start is not null
``` 

Pulls from the same view, but gives a more readable overview of what transactions might be blocking and the operations
that are blocked by these transactions.
```sql
select 
    pid, 
    usename, 
    state, 
    wait_event_type, 
    wait_event, 
    pg_blocking_pids(pid) as blocked_by
from pg_stat_activity
WHERE wait_event_type = 'Lock' OR state = 'idle in transaction';
```

Get all locks. Simple as.
```sql
select * from pg_locks ORDER BY pid;
```

### Replication slots
Lists the state of all replication slots on the postgres instance.
```sql
SELECT 
    slot_name, 
    plugin, 
    slot_type, 
    database, 
    active, 
    restart_lsn,
    confirmed_flush_lsn
FROM pg_replication_slots;
```

Get config related to replication slots and logical replication.
```sql
select 
    name, 
    setting 
from pg_settings 
where name in (
               'max_wal_senders', 
               'max_worker_processes', 
               'wal_level',
               'max_replication_slots'
              );
```

## MySQL
