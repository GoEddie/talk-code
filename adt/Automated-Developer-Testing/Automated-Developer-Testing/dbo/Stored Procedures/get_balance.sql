create procedure [dbo].[get_balance]
	@id int
as

	return (
		select top 1 sum(t.amount) balance from large_table t
			where id = @id		
	);