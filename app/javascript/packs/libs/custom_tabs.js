const ready = () => {
    const body = $('body');
    if (body.attr('data-turbolinks-preview') === '')
        return;

    $('#myTab a').on('click', function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);