--написать функцию, которая покажет список всех пользовательских баз данных SQL Server, и их общие размеры в байтах

CREATE FUNCTION All_db()
RETURNS TABLE AS RETURN
SELECT DB_NAME(database_id) AS name_db, CAST(SUM(size) * 8. / 1024 AS DECIMAL(8,2)) AS size
FROM sys.master_files
GROUP BY database_id

SELECT * FROM dbo.All_db()

-----------------------------------------------------------------------------------------------------------------------------
--написать функцию, которая покажет список всех таблиц базы данных, название которой передано как параметр, 
--количество записей в каждой из её таблиц, и общий размер каждой таблицы в байтах

CREATE FUNCTION ListTables_db()
RETURNS TABLE AS RETURN
SELECT sys.tables.name AS Name, sys.partitions.rows AS Rows, SUM(sys.allocation_units.total_pages) * 8. / 1024 AS Size
FROM sys.tables JOIN sys.partitions
ON sys.tables.object_id = sys.partitions.object_id
JOIN sys.allocation_units
ON sys.allocation_units.container_id = sys.partitions.partition_id
GROUP BY sys.tables.name, sys.partitions.rows, sys.allocation_units.total_pages

SELECT * FROM dbo.ListTables_db()


