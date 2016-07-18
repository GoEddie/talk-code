create procedure [get_balance].[test get_balance gets correct balance]
as

    execute tSQLt.FakeTable 'dbo', 'large_table';

	declare @id as int = 1;

	insert into dbo.large_table(id, amount)
	select @id, 1480
	union
	select @id, 3710
	union
	select @id, 1210
	union
	select 2, 1000000
	union
	select 0, 1;
	   
    declare @expected decimal(19, 4) = (1480 + 3710 + 1210);
	declare @result int;
		
	execute @result = [dbo].[get_balance] @id;
    
	execute tSQLt.AssertEquals @expected, @result, N'balance was not correct';