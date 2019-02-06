-- part of the script later included into the data importing action

-- request for the retraining
declare @conversation_handle uniqueidentifier;

-- dialog is started between two services
begin dialog conversation @conversation_handle
from service TrainingRequestService
to service 'TrainingResponseService'
on contract AsyncTrainingContract
with encryption = off;

-- message is sent to the new conversation
send on conversation @conversation_handle
message type AsyncTrainingRequest('<TrainingRequest/>')
go

select * from [dbo].[TrainingRequestQueue]
select * from [dbo].[TrainingResponseQueue]
select * from [Models].[ModelVersions]
go