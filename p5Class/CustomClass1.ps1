. ".\CustomClass.ps1" 

class CustomClass1 {

  [System.Collections.Generic.List``1[CustomClass]]GetColumns(){
  
     $list = New-Object System.Collections.Generic.List``1[CustomClass]
	 $c = New-Object CustomClass
	 $list.Add($c)
	 
     return $list
  }
}

