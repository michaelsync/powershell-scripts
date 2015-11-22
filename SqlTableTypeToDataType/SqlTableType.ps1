Class SqlTableType {   
   $_sqlConnectionString;    
   
   SqlTableType([string]$server, [string]$dbName, [string]$userName, [string]$password){
     $this._sqlConnectionString = "Server = $server; Database = $dbName;User ID=$userName; Password=$password"
   }
   
   [string]GetColumns([string]$tableType) {
		$_commandText = "SELECT tt.name AS table_Type, c.name, st.name AS table_Type_col_datatype, c.max_length, c.precision, c.is_nullable
						FROM sys.table_types tt
						INNER JOIN sys.columns c ON c.object_id = tt.type_table_object_id
						INNER JOIN sys.systypes AS ST  ON ST.xtype = c.system_type_id
						WHERE tt.name = '$tableType'"
   
		$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
		$SqlConnection.ConnectionString = $this._sqlConnectionString;
		
		[console]::beep(800,900)
		return "A"
	}
}
