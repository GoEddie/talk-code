create procedure [reconcile_accounts].[test when transaction outside of the specified dates then it is ignored]
as
    execute tSQLt.FakeTable 'dbo', 'daily_end_balance';
    execute tSQLt.FakeTable 'dbo', 'txn';

	insert into daily_end_balance(account_id, date, balance)
	select 1, '20160401', 100 --Start balance at 100
	union
	select 1, '20160402', 200 --End balance on day 2 is 200

	insert into txn(account_id, amount, txn_time)	
	select 1, 100, '20160401 12:34'					--a single transaction between the two dates of 100
	union
	select 1, 100, '20190401 12:34'					--a single transaction in a date in the future so reconciliation cannot take place yet
	

	create table #actual_results(account_id int, reconciled_amount decimal(8,4), actual_amount decimal(8,4), start_date date, end_date date)

	insert into #actual_results
    execute [dbo].[reconcile_accounts] ;
    
	declare @result_count int = (select count(*) from #actual_results);

	execute tSQLt.AssertEquals 0, @result_count, 'Did not expect any accounts to fail to reconcile';