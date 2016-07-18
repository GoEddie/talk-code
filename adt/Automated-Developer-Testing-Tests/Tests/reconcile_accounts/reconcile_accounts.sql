CREATE SCHEMA [reconcile_accounts]
    AUTHORIZATION dbo
GO
EXECUTE sp_addextendedproperty @name = 'tSQLt.TestClass', @value = 1, @level0type = 'SCHEMA', @level0name = 'reconcile_accounts'