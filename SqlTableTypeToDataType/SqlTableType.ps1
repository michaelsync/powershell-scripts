. ".\SqlTableColumn.ps1" 

$list = New-Object System.Collections.Generic.List``1[SqlTableColumn]

Class SqlTableType {   
   $_sqlConnectionString;    
   
   SqlTableType([string]$server, [string]$dbName, [string]$userName, [string]$password){
     $this._sqlConnectionString = "Server = $server; Database = $dbName;User ID=$userName; Password=$password"
   }   
   
   [System.Collections.Generic.List``1[SqlTableColumn]]GetColumns([string]$tableType) {
		
		$commandText = "SELECT tt.name AS table_Type, c.name, st.name AS table_Type_col_datatype, c.max_length, c.precision, c.is_nullable " +
						"FROM sys.table_types tt " +
						"INNER JOIN sys.columns c ON c.object_id = tt.type_table_object_id " +
						"INNER JOIN sys.systypes AS ST  ON ST.xtype = c.system_type_id " +
						"WHERE tt.name = '$tableType'"
						
		write-host "CommandText : $commandText"
		
		$sqlConnection = New-Object System.Data.SqlClient.SqlConnection
		$sqlConnection.ConnectionString = $this._sqlConnectionString;
		$sqlConnection.Open();
		
		$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
		$sqlCommand.CommandText = $commandText
		$sqlCommand.Connection = $SqlConnection
		$sqlReader = $sqlCommand.ExecuteReader()

		$list = New-Object System.Collections.Generic.List``1[SqlTableColumn]		
		
		While ($sqlReader.Read()){
			$sqlTableColumn = New-Object SqlTableColumn
			$sqlTableColumn.ColumnName = $sqlReader.GetString(1)
			$sqlTableColumn.ColumnType = $sqlReader.GetString(2)
			$sqlTableColumn.MaxLength = $sqlReader.GetInt16(3)
			$sqlTableColumn.Percision = $sqlReader.GetByte(4)
			$sqlTableColumn.Nullable = $sqlReader.GetBoolean(5)			
			$list.Add($sqlTableColumn)			
		}

		write-host "Column Count: "$list.Count
		
		return $list
	}
}
