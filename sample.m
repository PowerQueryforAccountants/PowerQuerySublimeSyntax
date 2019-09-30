let
  SalesTotal = 100 + 15 + 275 + 25,
  CommissionRate = 0.2,
  CalculateCommission = (sales, rate) => sales * rate,
  Commission = CalculateCommission(SalesTotal, CommissionRate),
  Result = Commission
in
  Result

// fnGetParameter function written by Ken Puls, FCPA, FCMA, MS MVP (Excel)
// Original source can be found at the following URL:
// http://www.excelguru.ca/blog/2014/11/26/building-a-parameter-table-for-power-query/

// To use the function you must have a table called "Parameters" in your workbook
// The header row must contain a "Parameter" and a "Value" column (with those names)

// Data rows should list the paramter name in the first column and the value of that
// parameter in the second column

// Provided you save this query under the name "fnGetParameter", you can then reference
// it from other queries as follows:
//
//  =fnGetParameter("your_parameter_name")

// One useful sample to return the current folder:
// Parameter Name:  File Path
// Parameter Value: =LEFT(CELL("filename",A1),FIND("[",CELL("filename",A1),1)-1)
// Call as  "fnGetParamater("File Path")

(ParameterName as text) =>
let
    ParamSource = Excel.CurrentWorkbook(){[Name="Parameters"]}[Content],
    ParamRow = Table.SelectRows(ParamSource, each ([Parameter]=ParameterName)),
    Value=
    if Table.IsEmpty(ParamRow)=true
    then null
    else Record.Field(ParamRow{0},"Value")
in
    Value