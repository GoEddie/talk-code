create procedure [reconcile_accounts].[test when transactions do not equal end_balance then it is reported]
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
	select 1, 100, '20160401 13:34'					--a second transaction inside the dates that stop the accounts reconciliing
	

	create table #actual_results(account_id int, reconciled_amount decimal(8,4), actual_amount decimal(8,4), start_date date, end_date date)

	insert into #actual_results
    execute [dbo].[reconcile_accounts] ;
    
	declare @result_count int = (select count(*) from #actual_results);

	execute tSQLt.AssertEquals 1, @result_count, 'Expected one account to fail to reconcile';	