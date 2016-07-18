create procedure [buggy_proc].[test buggy_proc sends email on failure]
as

	execute tSQLt.SpyProcedure N'proc_that_fails_disasterously', N'RAISERROR (15600,-1,-1, ''proc_that_fails_disasterously'');';
	execute tSQLt.SpyProcedure N'send_email', N'select 100; return';
	
    execute [dbo].[buggy_proc] ;

	declare @actual int = (
							select count(*) from send_email_SpyProcedureLog where priority = 'EMERGENCY' and message = 'Err something badhappened');

	execute tSQLt.AssertEquals 1, @actual, 'The send email procedure was not called or not called with the correct parameters';