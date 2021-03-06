ALTER proc [Models].[procTrainModels]
as
declare @sqlMin nvarchar(500) = N'select PhoneId, IsCorporate, Size, ActionRoute
	, MonthAndYear, Units, Unit, RecomputeUnits 
	from SourceData.viInputCalls where MonthAndYear > ''2017-01-01'' and Unit = ''min'''
declare @sqlPc nvarchar(500) = N'select PhoneId, IsCorporate, Size, ActionRoute
	, MonthAndYear, Units, Unit, RecomputeUnits 
	from SourceData.viInputCalls where MonthAndYear > ''2017-01-01'' and Unit = ''pc'''

create table #models
(
ModelStream varbinary(max)
, PredictedUnits nvarchar(10) null 
)

insert #models (ModelStream)
exec sp_execute_external_script
	@language = N'R'
	, @script = N'
		#formula for linear regression
		formula <- Units ~ IsCorporate + Size + ActionRoute + MonthAndYear;
		actions <- InputDataSet;

		#factorization of the date
		actions$MonthAndYear <- as.Date.factor(actions$MonthAndYear);

		#model from training data
		model <- rxLinMod(formula, actions);

		OutputDataSet <- data.frame(rxSerializeModel(model, realtimeScoringOnly = TRUE));
	'
	, @input_data_1 = @sqlMin

update #models set PredictedUnits = 'min'

insert #models (ModelStream)
exec sp_execute_external_script
	@language = N'R'
	, @script = N'
		#formula for linear regression
		formula <- Units ~ IsCorporate + Size + ActionRoute + MonthAndYear;
		actions <- InputDataSet;

		#factorization of the date
		actions$MonthAndYear <- as.Date.factor(actions$MonthAndYear);

		#model from training data
		model <- rxLinMod(formula, actions);

		OutputDataSet <- data.frame(rxSerializeModel(model, realtimeScoringOnly = TRUE));
	'
	, @input_data_1 = @sqlPc

update #models set PredictedUnits = 'pc' where PredictedUnits is null

insert Models.ModelVersions (ModelStream, PredictedUnits)
select ModelStream, PredictedUnits from #models
