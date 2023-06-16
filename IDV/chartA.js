function(e){
  chartA = e
  $tbody = $("#widget-chartA tbody")
  $tbody.on('click', 'tr', function () {
          if ($(this).hasClass('selected')) {
              $(this).removeClass('selected');
          } else {
              dt.$('tr.selected').removeClass('selected');
              $(this).addClass('selected');
          }
      });
}
