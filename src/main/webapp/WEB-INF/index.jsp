<!DOCTYPE html>
<html>
<head>

<style>
table,th,td
{
border:1px solid black;
border-collapse:collapse;
}
</style>

<script>
function loadXMLDoc(resource)
{
   var xmlhttp;
   if (window.XMLHttpRequest)
     {// code for IE7+, Firefox, Chrome, Opera, Safari
       xmlhttp=new XMLHttpRequest();
     }
   else
     {// code for IE6, IE5
       xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
     }
   xmlhttp.onreadystatechange=function(){
     if (xmlhttp.readyState==4 && (xmlhttp.status==200 || xmlhttp.status==304))
       {
        if(resource=='Matches'){ document.getElementById("myDiv").innerHTML=parseMatchesResponse(xmlhttp.responseText);}
      	if(resource=='Matches_Today'){ document.getElementById("myDiv").innerHTML=parseTodaysMatchesResponse(xmlhttp.responseText);}
  	if(resource=='Group_Results'){ document.getElementById("myDiv").innerHTML=parseGroupResultsResponse(xmlhttp.responseText);}
	if(resource=='Teams'){ document.getElementById("myDiv").innerHTML=parseTeamsResponse(xmlhttp.responseText);}
       }
   }
   xmlhttp.open("GET",getResourceURL(resource),true);
   xmlhttp.send();
}

function getResourceURL(resource){
   var resourceURL;

   if(resource=='Matches'){ resourceURL='http://worldcup.sfg.io/matches';}
   if(resource=='Matches_Today'){ resourceURL='http://worldcup.sfg.io/matches/today';}
   if(resource=='Group_Results'){ resourceURL='http://worldcup.sfg.io/group_results';}
   if(resource=='Teams'){ resourceURL='http://worldcup.sfg.io/teams';}
   
   return resourceURL;
}

function parseTodaysMatchesResponse(response){
   var json_obj = JSON.parse(response);

   var output="<br/><table style=\"width:300px\"> <tr> <td><b>Match ID</b></td> <td><b>Team-1</b></td> <td><b>Goals</b></td> <td><b>Team-2</b></td> <td><b>Goals</b></td>  <td><b>Status</b></td> <td><b>Winner</b></td> <td><b>Timing</b></td> <td><b>Location</b></td> </tr>";

   for (var i in json_obj)
     {
       output+="<tr><td>" + json_obj[i].match_number + "</td><td>" + json_obj[i].home_team.country + "</td><td>" + json_obj[i].home_team.goals + "</td><td>" + json_obj[i].away_team.country + "</td><td>" + json_obj[i].away_team.goals + "</td><td>"  + json_obj[i].status + "</td><td>" + json_obj[i].winner + "</td><td>" + json_obj[i].datetime + "</td><td>" + json_obj.location  + "</td></tr>";
     }
   output+="</table>";

   return output;
}

function parseGroupResultsResponse(response){
var json_obj = JSON.parse(response);
  
  var output="<br/><table style=\"width:300px\"> <tr> <td><b>Country</b></td>  <td><b>FIFA Code</b></td> <td><b>Group ID</b></td> <td><b>Wins</b></td> <td><b>Draws</b></td> <td><b>Losses</b></td> <td><b>Goals For</b></td> <td><b>Goals Against</b></td> <td><b>Knocked Out</b></td>  </tr>";

  for (var i in json_obj)
     {
        output+="<tr><td>" + json_obj[i].country + "</td><td>" + json_obj[i].fifa_code + "</td><td>" + json_obj[i].group_id + "</td><td>" + json_obj[i].wins + "</td><td>" + json_obj[i].draws + "</td><td>" + json_obj[i].losses + "</td><td>" + json_obj[i].goals_for + "</td><td>" + json_obj[i].goals_against + "</td><td>" + json_obj[i].knocked_out  + "</td></tr>";
     }
  output+="</table>";
  
  return output;
}

function parseTeamsResponse(response){
  var json_obj = JSON.parse(response);

  var output="<br/><table style=\"width:300px\"> <tr> <td><b>Country</b></td>  <td><b>Alternate Name</b></td> <td><b>FIFA Code</b></td> <td><b>Group ID</b></td> </tr>";

  for (var i in json_obj)
     {
	output+="<tr><td>" + json_obj[i].country + "</td><td>" + json_obj[i].alternate_name + "</td><td>" + json_obj[i].fifa_code + "</td><td>" + json_obj[i].group_id + "</td></tr>";	
     }	
  output+="</table>";
  
  return output;
}

function parseMatchesResponse(response){
   var json_obj = JSON.parse(response);
        
   var output="<br/><table style=\"width:300px\"> <tr> <td><b>Match ID</b></td> <td><b>Team-1</b></td> <td><b>Goals</b></td> <td><b>Team-2</b></td> <td><b>Goals</b></td>  <td><b>Status</b></td> <td><b>Winner</b></td> <td><b>Timing</b></td> </tr>";
   for (var i in json_obj)        
     {
       output+="<tr><td>" + json_obj[i].match_number + "</td><td>" + json_obj[i].home_team.country + "</td><td>" + json_obj[i].home_team.goals + "</td><td>" + json_obj[i].away_team.country + "</td><td>" + json_obj[i].away_team.goals + "</td><td>"  + json_obj[i].status + "</td><td>" + json_obj[i].winner + "</td><td>" + json_obj[i].datetime  + "</td></tr>";
     }
   output+="</table>";
   return output;
}

</script>
</head>
<body>

<h2>2014 FIFA World Cup</h2>

<button type="button" onclick="loadXMLDoc('Teams')">Teams</button>
<button type="button" onclick="loadXMLDoc('Matches_Today')">Today's Matches</button>
<button type="button" onclick="loadXMLDoc('Matches')">Matches</button>
<button type="button" onclick="loadXMLDoc('Group_Results')">Group Results</button>

<div id="myDiv"></div>

</body>
</html>
