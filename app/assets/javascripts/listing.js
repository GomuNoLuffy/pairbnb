  document.addEventListener("turbolinks:load",function(){


$(document).ready(function () {

        $("#from").datepicker({
            dateFormat: "yy-mm-dd",
            minDate: 1,
            onSelect: function (date) {
                var to = $('#to');
                var startDate = $(this).datepicker('getDate');
                var minDate = $(this).datepicker('getDate');
                to.datepicker('setDate', minDate);
                startDate.setDate(startDate.getDate() + 30);
                //sets dt2 maxDate to the last day of 30 days window
                to.datepicker('option', 'maxDate', startDate);
                to.datepicker('option', 'minDate', minDate);
                $(this).datepicker('option', 'minDate', minDate);
            }
        });
        $('#to').datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
});