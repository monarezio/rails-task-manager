$(document).on('ready turbolinks:load', () => {
    const datePicker = $('input.date_time_picker');

    datePicker.datetimepicker({
        format: 'd/m/Y H:i',
    });
});