. ".\SqlTableColumn.ps1" 

$list = New-Object System.Collections.Generic.List``1[SqlTableColumn]

Class SqlTableType {   
   $_sqlConnectionString;    
   
   SqlTableType([string]$server, [string]$dbName, [string]$userName, [string]$password){
     $this._sqlConnectionString = "Server = $server; Database = $dbName;User ID=$userName; Password=$password"
   }   
   
   [System.Collections.Generic.List``1[SqlTableColumn]]GetColumns([string]$tableType) {
		$commandText = "SELECT tt.name AS table_Type, c.name, st.name AS table_Type_col_datatype, c.max_length, c.precision, c.is_nullable
						FROM sys.table_types tt
						INNER JOIN sys.columns c ON c.object_id = tt.type_table_object_id
						INNER JOIN sys.systypes AS ST  ON ST.xtype = c.system_type_id
						WHERE tt.name = '$tableType'"
   
		$sqlConnection = New-Object System.Data.SqlClient.SqlConnection
		$sqlConnection.ConnectionString = $this._sqlConnectionString;
		$sqlConnection.Open();
		
		$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
		$sqlCommand.CommandText = $commandText
		$sqlCommand.Connection = $SqlConnection
		$sqlReader = $sqlCommand.ExecuteReader()

		$list = New-Object System.Collections.Generic.List``1[SqlTableColumn]
		$sqlTableColumn = New-Object SqlTableColumn
		$list.Add($sqlTableColumn)
		
		While ($sqlReader.Read()){

			$output = $sqlReader.GetString(1) <# Column Name #> + ' ' +
					  $sqlReader.GetString(2) <# Column Type #> + ' ' +
					  $sqlReader.GetInt16(3) <# Max Length #> + ' ' +
					  $sqlReader.GetByte(4) <# Precision #> + ' ' +
					  $sqlReader.GetBoolean(5) <# Nullable #>

			write-output $output
		}

		[console]::beep(800,900)
		return ,$list
	}
}
