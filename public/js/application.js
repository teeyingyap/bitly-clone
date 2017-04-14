$(document).ready(function() {
	console.log("jQuery ready!");
     
	$("#menu").accordion({collapsible: true, active: false});
	

	$('#shorten-form').submit(function(event) {
		event.preventDefault();
		console.log("Prevented Default Action!");

		$('body').append('<img src="/img/spinner.gif" id ="spinner"/>');

		$.ajax({
      	  url: '/urls', //this refers to the route post '/urls'
      	  method: 'post',
      	  data: $(this).serialize(),
       	  dataType: 'json',      
      
        beforeSend: function() {
        	$('form input').val('Loading...');
        },


        success: function(data) {      
        	$('#spinner').hide();
            $('form input').val('Shortened!');  
         	$('tr:first-child').after('<tr> <td>' + data.long_url + '</td> <td><a href="' + data.long_url + '">' + data.short_url + '</a></td> <td>' + data.click_count + '</td> </tr>')     
        },      

        error: function(data) {    
        	$('#spinner').hide();
            $('form input').val('Invalid Url!');    
        	$('#flash').html(data.responseText)     
        }    

        
     
    }); // end of function .ajax
  }); // end of function .submit
}); // end of function document.ready

