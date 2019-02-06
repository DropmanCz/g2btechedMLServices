exec sp_configure

exec sp_configure 'external scripts enabled', 1
reconfigure		-- funguje pri vypnutem SQL Server Launchpad!

exec sp_execute_external_script
	@language = N'R'
	, @script = N''