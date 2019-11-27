const ready = () => {
    const body = $('body');
    if (body.attr('data-turbolinks-preview') === '')
        return;

    const datePicker = $('input.date_time_picker');

    datePicker.datetimepicker({
        format: 'd/m/Y H:i',
    });
};


$(document).ready(ready);
$(document).on('turbolinks:load', ready);