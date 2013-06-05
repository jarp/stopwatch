 $( document ).ready(function() {
      
  $('#new_entry').on('ajax:success', function(event, xhr, status) {
      refreshEntries();
      clearForm()
    });

  $('#new_entry').on('ajax:error', function(event, xhr, status) {
      alert('something wicked this way comes...')
    });


  $('input.dev-filter').click(function(){
          filterEntries();
      })

});

function refreshEntries(){
  $('#current-entries').html("loading");
  $('#current-entries').load('/entries?widget', pauseFilter());  
  }

  function pauseFilter(el) { 
      setTimeout(
          function() { filterEntries(); }, 500);
          } 

function clearForm(){
  $('input.to-clear').val("");
  }

function filterEntries(){
    var toHide = $('input.dev-filter:not(:checked)') 
    var toShow = $('input.dev-filter:checked') 

    toHide.each(function(){
      $('tr').filter('#'+ $(this).attr('id')).fadeOut()
    })
    toShow.each(function(){
      $('tr').filter('#'+ $(this).attr('id')).fadeIn()
    })            
  }