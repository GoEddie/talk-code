create procedure [dbo].[proc_that_fails_disasterously]
as

	insert into account(account_id)
	select 999;