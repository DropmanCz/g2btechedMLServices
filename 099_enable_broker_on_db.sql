use master
go

alter database Phones set single_user with rollback immediate
alter database Phones set enable_broker
alter database Phones set multi_user