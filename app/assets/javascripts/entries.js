$( document ).ready(function() {

    function setRemoteMessage(msg){
        $('div#remote-message').html(msg).fadeIn();
       // console.log("message is: " + msg)
       // console.log($('div.remote-message'))

    }

    $('.entry-checkbox').change(function(){
        var entryId = $(this).val();
        
        if ( $(this).is(':checked') ) {
            
            var path = '/invoices/addEntry/'+entryId + '.json';
        
            $.ajax({
                url: path,
                beforeSend: function ( xhr ) {
                    //xhr.overrideMimeType("application/json; charset=x-user-defined");
                    },
                error: function(response){
                    alert('bad!');
                    console.log(response.status)
                    },
                success: function(response) {
                    var count = 2;
                    console.log(response) 
                    setRemoteMessage("Entry has been added to your invoice! There are now " + response.count + " entries added. "  + invoiceLink(response.project_id));
                    
                    }


        });


        }

        else {

            var path = '/invoices/removeEntry/'+entryId + '.json';
            $.ajax({
                url: path,
                beforeSend: function ( xhr ) {
                    //xhr.overrideMimeType("application/json; charset=x-user-defined");
                    },
                error: function(response){
                    alert('bad!');
                    console.log(response.status)
                    },
                success: function(response) {
                    var count = 2;
                    console.log(response) 
                    setRemoteMessage("Entry has been removed from your invoice! There are now " + response.count + " entries added. " + invoiceLink(response.project_id));
                    
                    }

                    
             });

             }
        });


    function invoiceLink(id){
        return '<a href="/invoices/current/' + id + '">Go there now!</a>';
    }



});