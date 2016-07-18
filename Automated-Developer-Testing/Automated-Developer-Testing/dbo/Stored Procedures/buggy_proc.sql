create proc buggy_proc
as

begin try
    exec proc_that_fails_disasterously
end try
begin catch
    exec send_email 'EMERGENCY', 'Err something badhappened'
end catch
   
