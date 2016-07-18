create table [dbo].[large_table]
(
    [lt_id] int not null primary key clustered,
	[id] int not null,
	[r1] int not null,
	[r2] int not null,
	[r3] int not null,
	[r4] int not null,
	[r5] int not null,
	[amount] decimal(19,4) not null,
	constraint [fk_r1] foreign key (r1) references referenced(Id),
	constraint [fk_r2] foreign key (r2) references referenced(Id),
	constraint [fk_r3] foreign key (r3) references referenced(Id),
	constraint [fk_r4] foreign key (r4) references referenced(Id),
	constraint [fk_r5] foreign key (r5) references referenced(Id)
)
