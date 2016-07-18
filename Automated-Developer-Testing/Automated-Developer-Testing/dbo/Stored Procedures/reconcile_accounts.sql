



			create procedure reconcile_accounts
			as
				select	end_balance.account_id, 
						end_balance.balance, 
						prev_day.balance, 
						prev_day.date, 
						end_balance.date  
				from daily_end_balance end_balance
					left outer join daily_end_balance prev_day 
						on end_balance.account_id = prev_day.account_id and end_balance.date = dateadd(day, 1, prev_day.date)
					left outer join txn 
						on txn.account_id = end_balance.account_id 
					group by end_balance.account_id, 
							 end_balance.balance, 
							 prev_day.balance , 
							 prev_day.date, 
							 end_balance.date
					having prev_Day.balance + sum(txn.amount) <> end_balance.balance





